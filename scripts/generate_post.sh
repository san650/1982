#!/usr/bin/env bash

# Files

SOURCE="$1"
TARGET="$2"
TARGET_FILENAME=$( basename "$TARGET" )
FRAGMENT="tmp/${TARGET_FILENAME}.fragment"
SUMMARY="tmp/${TARGET_FILENAME}.summary"
ARCHIVE="tmp/${TARGET_FILENAME}.archive"

# Helper functions

function cleanup_markdown()
{
  # Change ```XYZ and {% codeblocks XYZ %} by <pre> blocks

  sed \
    -e 's/```..*/<pre>/; s/```$/<\/pre>/' \
    -e 's/{% endcodeblock %}/<\/pre>/; s/{% codeblock.*%}/<pre>/'
}

function get_metadata()
{
  sed -n '/^ *'$1':/{; s/^ *'$1': *\(.*\)/\1/; p; q; }' "$SOURCE"
}

# Post metadata

TITLE=$( get_metadata title )
AUTHOR=$( get_metadata name )

# Generate a page for the post

sed -n '/^---$/,/^---$/!{; p; }' "$SOURCE" \
  | pandoc -f markdown -t html > "$FRAGMENT"
#  | cleanup_markdown \
#  | markdown > "$FRAGMENT"

m4 \
  --include=layout/ \
  --define ARTICLE="$FRAGMENT" \
  --define TITLE="$TITLE" \
  --define AUTHOR="$AUTHOR" \
  layout/post.html > "$TARGET"

# Generate a summary for the post

sed '/<!-- *more *-->/q' "$FRAGMENT" > "${SUMMARY}.md"

m4 \
  --include=layout/ \
  --define ARTICLE="${SUMMARY}.md" \
  --define TITLE="$TITLE" \
  --define AUTHOR="$AUTHOR" \
  --define LINK="$TARGET_FILENAME" \
  layout/post_summary.html > "$SUMMARY"

# Generate archive fragment

DATE=$( echo "$TARGET_FILENAME" | cut -c 1-10 )

m4 \
  --include=layout/ \
  --define TITLE="$TITLE" \
  --define LINK="$TARGET_FILENAME" \
  --define DATE="$DATE" \
  --define AUTHOR="$AUTHOR" \
  layout/archive_fragment.html > "$ARCHIVE"
