# List of all posts
markdowns=$(wildcard posts/*.md)
htmls=$(patsubst posts/%.md, dist/%.html, $(markdowns))

build: dist $(htmls)

# Macros
# $@ left side of :
# $^ right side of :
# $< first item of dep list
#
# http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
# https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html

dist/%.html: posts/%.md
	markdown $^ > $@.tmp
	m4 --include=dist/ --define ARTICLE=$@.tmp layout/index.html > $@

dist:
	mkdir dist

clean:
	rm -rf dist

.PHONY: build clean
