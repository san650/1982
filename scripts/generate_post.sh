#!/usr/bin/env bash

# Files

SOURCE="$1"
TARGET="$2"
TMP="${2}.tmp"


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
  local ATTRIBUTE="$1"

  sed -n '/^ *'$1':/{; s/^ *'$1': *\(.*\)/\1/; p; q; }' "$SOURCE"
}

# Post metadata

TITLE=$( get_metadata title )
AUTHOR=$( get_metadata name )

# The magic begins

cat "$SOURCE" \
  | sed -n '/^---$/,/^---$/!{; p; }' \
  | cleanup_markdown \
  | markdown > "$TMP"

m4 \
  --include=layout/ \
  --define ARTICLE="$TMP" \
  --define TITLE="$TITLE" \
  --define AUTHOR="$AUTHOR" \
  layout/index.html > "$TARGET"
