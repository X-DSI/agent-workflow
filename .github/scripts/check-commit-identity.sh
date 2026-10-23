#!/usr/bin/env bash
# check-commit-identity.sh — enforce PROTOCOL.md §13 on a range of commits.
#
# Usage: check-commit-identity.sh <base> <head>
#   Checks every commit in <base>..<head>. Exits 1 if any commit
#   - is authored or committed by an address matching FORBIDDEN_EMAIL_REGEX, or
#   - has a Co-Authored-By trailer matching FORBIDDEN_TRAILER_REGEX.
#
# Environment overrides (extended regex, matched case-insensitively):
#   FORBIDDEN_EMAIL_REGEX    default: @anthropic\.com$
#   FORBIDDEN_TRAILER_REGEX  default: ^co-authored-by:.*(claude|anthropic|openai|codex|copilot|cursor|gemini)
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "usage: $0 <base> <head>" >&2
  exit 2
fi

base=$1
head=$2
email_re=${FORBIDDEN_EMAIL_REGEX:-'@anthropic\.com$'}
trailer_re=${FORBIDDEN_TRAILER_REGEX:-'^co-authored-by:.*(claude|anthropic|openai|codex|copilot|cursor|gemini)'}

# In GitHub Actions, print errors as annotations; locally, plain text.
report() {
  if [[ -n "${GITHUB_ACTIONS:-}" ]]; then
    echo "::error title=Commit identity::$1"
  else
    echo "ERROR: $1"
  fi
}

failures=0
checked=0

while IFS= read -r sha; do
  [[ -z "$sha" ]] && continue
  checked=$((checked + 1))
  short=${sha:0:7}
  author=$(git show -s --format='%an <%ae>' "$sha")
  author_email=$(git show -s --format='%ae' "$sha")
  committer_email=$(git show -s --format='%ce' "$sha")
  subject=$(git show -s --format='%s' "$sha")

  if grep -Eiq -- "$email_re" <<<"$author_email"; then
    report "$short \"$subject\" is authored by $author. Commits must use the maintainer's git identity."
    failures=$((failures + 1))
  fi
  if grep -Eiq -- "$email_re" <<<"$committer_email"; then
    report "$short \"$subject\" is committed by $committer_email. Commits must use the maintainer's git identity."
    failures=$((failures + 1))
  fi
  if git show -s --format='%B' "$sha" | grep -Eiq -- "$trailer_re"; then
    report "$short \"$subject\" has an AI Co-Authored-By trailer. Remove it."
    failures=$((failures + 1))
  fi
done < <(git rev-list "$base..$head")

if [[ $failures -gt 0 ]]; then
  echo
  echo "$failures problem(s) in $checked commit(s). Fix with, for example:"
  echo "  git config user.name  \"<your name>\""
  echo "  git config user.email \"<your email>\""
  echo "  git rebase $base --exec 'git commit --amend --no-edit --reset-author'"
  echo "and delete any AI Co-Authored-By lines while rewording."
  exit 1
fi

echo "OK: $checked commit(s) checked, no forbidden identities or AI co-author trailers."
