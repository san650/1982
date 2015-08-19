#!/usr/bin/env bash

if [ -z "$TITLE" ]
then
  echo 'You need to supply a title'
  echo '$ make new_post TITLE="My awesome post"'

  exit 1
fi

# Helper functions

function cleanup_name()
{
  sed 's/[,.]//' \
    | tr '[A-Z ]' '[a-z-]'
}

DATE=$( date "+%Y-%m-%d-%H-%M" )
CLEAN_TITLE=$( echo "$TITLE" | cleanup_name )
TARGET=posts/${DATE}-${CLEAN_TITLE}.md

echo "---" > "$TARGET"

printf 'title: '"$TITLE"'
name: '"$AUTHOR"'
---

Put your content here.
' >> "$TARGET"

echo "Created $TARGET"
