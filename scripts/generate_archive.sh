#!/usr/bin/env bash

TARGET="tmp/archive.html.fragment"

# Overwrite file content
echo > "$TARGET"

ls -1 tmp/*.archive \
  | sort -nr \
  | xargs cat > "$TARGET"

m4 \
  --include=layout/ \
  --define ARTICLES="$TARGET" \
  layout/index.html > "dist/archive.html"
