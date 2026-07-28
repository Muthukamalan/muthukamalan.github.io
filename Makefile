
MY_VAR := $(shell eval git branch --sort=-committerdate | head -1)

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
HASH := $(shell git rev-parse HEAD)

ENV_NAME ?= blog
PYTHON_VERSION ?= 3.11
POETRY_VERSION ?= 2.1.1

new: 
	python3 new-post.py
