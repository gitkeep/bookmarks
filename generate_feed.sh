#!/usr/bin/env bash
set -uf -o pipefail
IFS=$'\n\t'

FEED_TITLE="gitkeep/bookmarks"
FEED_LINK="https://github.com/gitkeep/bookmarks"
FEED_URL="https://raw.githubusercontent.com/gitkeep/bookmarks/master/feed.xml"
FEED_SRC=README.org

function write_header() {
	cat <<-END
		<?xml version="1.0" encoding="utf-8" ?>
		 <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
		 <channel>
		 <title>$FEED_TITLE</title>
		 <link>$FEED_LINK</link>
		 <atom:link href="$FEED_URL" rel="self" type="application/rss+xml" />
		 <description></description>
		 <language>en-us</language>
	END
}

function write_footer() {
	cat <<-END
		</channel>
		</rss>
	END
}

function write_item() {
	cat <<-END
		<item>
		 <title>$1</title>
		 <link>$2</link>
		 <description></description>
		 </item>
	END
}

function write_items() {
	source=$(grep "^- \[\[" "$FEED_SRC")
	while read -r LINE; do
		URL=$(echo "$LINE" | cut -d"[" -f3 | cut -d"]" -f1 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
		TITLE=$(echo "$LINE" | cut -d"[" -f4 | cut -d"]" -f1)
		write_item "$TITLE" "$URL"
	done <<<"$source"
}

# write footer
write_header
write_items
write_footer
