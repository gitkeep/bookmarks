#!/usr/bin/env bash
set -uf -o pipefail
IFS=$'\n\t'

BOOKMARKS_FILE_SRC=~/brain/wiki/bookmarks.org
BOOKMARKS_FILE_DEST=README.org
FEED_DEST=feed.xml

cp "$BOOKMARKS_FILE_SRC" "$BOOKMARKS_FILE_DEST"
./generate_feed.sh >"$FEED_DEST"

git add --all
git commit -m "Sync $(date +\"%Y-%m-%d\")"
git push
