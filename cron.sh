#!/usr/bin/env bash
set -f -o pipefail
IFS=$'\n\t'

BOOKMARKS_FILE_SRC=~/brain/wiki/bookmarks.org
BOOKMARKS_FILE_DEST=README.org
FEED_DEST=feed.xml

cp "$BOOKMARKS_FILE_SRC" "$BOOKMARKS_FILE_DEST"
./generate_feed.sh >"$FEED_DEST"

git add README.org feed.xml

if [ -z "$1" ]; then
	git commit -m "Sync $(date +\"%Y-%m-%d\")"
	git push
else
	if [ "$1" == "--update" ]; then
		git commit --amend --no-edit
		git push --force
	else
		echo "Unknown argument: $1"
	fi
fi
