# List of all posts
markdowns=$(wildcard posts/*.md)
htmls=$(patsubst posts/%.md, dist/%.html, $(markdowns))
assets=$(patsubst public/%, dist/assets/%, $(wildcard public/*))

# Commands

build: dist dist/assets/screen.css $(assets) $(htmls) dist/index.html

clean:
	rm -rf dist tmp

new_post:
	@ ./scripts/new_post.sh

help:
	@echo "$$BANNER" | column -xts'-'

# Helper targets

dist/%.html: posts/%.md
	./scripts/generate_post.sh $^ $@

dist: tmp/
	mkdir -p dist/assets

tmp/:
	mkdir tmp/

dist/assets/%: public/%
	cp $^ $@

dist/index.html: $(htmls)
	./scripts/generate_index.sh

dist/assets/screen.css: $(wildcard styles/*.css)
	m4 --include=styles/ styles/screen.css > dist/assets/screen.css

.PHONY: build clean new_post public

define BANNER
Usage:
make build - generates site
make clean - clean up temporary files
make new_post TITLE="Post title" AUTHOR="John Doe" - creates a new post
endef

# Make BANNER var available from bash
export BANNER
