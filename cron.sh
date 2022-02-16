#!/usr/bin/env bash
set -uf -o pipefail
IFS=$'\n\t'

BOOKMARKS_FILE_SRC=~/brain/wiki/bookmarks.org
BOOKMARKS_FILE_DEST=README.org

cp "$BOOKMARKS_FILE_SRC" "$BOOKMARKS_FILE_DEST"
git add --all
git commit --amend -m "Sync $(date +\"%Y-%m-%d\")"
git push --force
