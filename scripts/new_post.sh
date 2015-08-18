#!/usr/bin/env bash

if [ -z "$TITLE" ]
then
  echo 'You need to supply a title'
  echo '$ make new_post TITLE="My awesome post"'

  exit 1
fi

DATE=$( date "+%Y-%m-%d-%H-%M" )
CLEAN_TITLE=$( echo "$TITLE" | tr '[A-Z ]' '[a-z-]')
TARGET=posts/${DATE}-${CLEAN_TITLE}.md

echo "# $TITLE" > "$TARGET"
echo >> "$TARGET"
echo 'Put your content here.' >> "$TARGET"

echo "Created $TARGET"
