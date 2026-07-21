.DEFAULT_GOAL := help

help: ## Show available targets
	@awk 'BEGIN {FS = ":.*## "; printf "Available targets:\n"} /^[a-zA-Z0-9_-]+:.*## / { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: serve
serve:  ## zola build & serve
# 	@zola check
	@zola build
	@zola serve



.PHONY: post
BLOG_CONTENT_DIR ?= content/blog
TAGS ?=
post:
	@if [ -z "$(TITLE)" ]; then \
		echo 'Usage: make post TITLE="My Title" [TAGS="tag1,tag2"] [BLOG_CONTENT_DIR=content/blog]'; \
		exit 1; \
	fi
	sh scripts/post.sh -T "$(TITLE)" $(if $(TAGS),-t "$(TAGS)") -d "$(BLOG_CONTENT_DIR)"
# make post TAGS="Kubernets,Vllm" TITLE="LLM Inference"


.PHONY: project
PROJECT_CONTENT_DIR ?= content/projects
TAGS ?=
project:
	@if [ -z "$(TITLE)" ]; then \
		echo 'Usage: make post TITLE="My Title" [TAGS="tag1,tag2"] [PROJECT_CONTENT_DIR=content/projects]'; \
		exit 1; \
	fi
	sh scripts/post.sh -T "$(TITLE)" $(if $(TAGS),-t "$(TAGS)") -d "$(PROJECT_CONTENT_DIR)"
# make project TAGS="Kubernets,Vllm" TITLE="LLM Inference"