
MY_VAR := $(shell eval git branch --sort=-committerdate | head -1)

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
HASH := $(shell git rev-parse HEAD)

ENV_NAME ?= blog
PYTHON_VERSION ?= 3.12

new: 
	python3 new-post.py

serve:
	rm -rf _site && bundle exec jekyll serve  --incremental

clean:
	rm -rf _site && rm .jekyll-metadata