#!/usr/bin/env bash

TARGET="tmp/post_summaries.html.fragment"

# Overwrite file content
echo > "$TARGET"

ls -1 tmp/*.summary \
  | sort -nr \
  | head -n 10 \
  | xargs cat > "$TARGET"

m4 \
  --include=layout/ \
  --define ARTICLES="$TARGET" \
  layout/index.html > "dist/index.html"
