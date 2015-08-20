#!/usr/bin/env bash

TARGET="dist/post_summaries.tmp"

# Overwrite file content
echo > "$TARGET"

ls -1 dist/*.html.summary \
  | sort -nr \
  | head -n 10 \
  | xargs cat > "$TARGET"

m4 \
  --include=layout/ \
  --define ARTICLES="$TARGET" \
  layout/index.html > "dist/index.html"
