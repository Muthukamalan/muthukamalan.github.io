#!/usr/bin/env bash

set -e

ASSET_DIR="assets"

header() {
    local title="$1"
    local date="$2"
    local asset_dirname="$3"

    if [[ -z "$title" ]]; then
        echo "Title cannot be empty" >&2
        return 1
    fi

    if [[ -z "$asset_dirname" ]]; then
        echo "Asset directory name cannot be empty" >&2
        return 1
    fi

    cat <<EOF
---
title: "$title"
date: $date
published: true
tags:
# Work or personal?
- work
- personal

# Start here themes
- systems
- software
- learning
- product
- career

# Series
- recently
- practical-advice
- how-I-use-AI

# Big themes that I write about
- artificial intelligence
- complexity
- engineering
- software architecture
- management
- leadership
- productivity
- lean
- memory palace

# Programming languages/Cloud
- advent of code
- rust
- golang
- python
- sql
- javascript
- aws
- testing
- documentation

# Smaller themes
- book summary
- writing
- product
- design
- tools
- advent of code
- aws 
- docker
- machine learning
- programming
- pytorch
- tensorflow
- code
- show-your-work
- tip
- athena
- flashcards
- projects
- startups
- domain driven design
- story
- lessons learned
- video games
- toyota
- lean

header:
    teaser: "/../assets/$asset_dirname/default-thumbnail.png"
author_profile: true
layout: single
classes:
- landing_page
toc: true
toc_sticky: true
categories:  projects
related: false
excerpt: "$asset_dirname"
---
<!-- ctrl + alt + v -->
<!-- cmd + alt + v -->

checklist:
- thumbnail
- tags
- content


EOF
}

slugify() {
    local value="$1"

    # Convert to lowercase.
    value=$(printf '%s' "$value" | tr '[:upper:]' '[:lower:]')

    # Transliterate accented characters where possible.
    if command -v iconv >/dev/null 2>&1; then
        value=$(printf '%s' "$value" | iconv -f UTF-8 -t ASCII//TRANSLIT 2>/dev/null || printf '%s' "$value")
    fi

    # Remove characters that aren't alphanumeric, whitespace,
    # underscores, or hyphens.
    value=$(printf '%s' "$value" | sed 's/[^[:alnum:]_[:space:]-]//g')

    # Convert spaces/repeated dashes to a single dash.
    value=$(printf '%s' "$value" | sed -E 's/[-[:space:]]+/-/g')

    # Strip leading/trailing dashes and underscores.
    value=$(printf '%s' "$value" | sed -E 's/^[-_]+//; s/[-_]+$//')

    printf '%s' "$value"
}

# Request input from user
printf "Title of blog post (Ctrl + C to cancel): "
IFS= read -r title

slug=$(slugify "$title")

echo "Creating a new blog post for you..."
echo -e "\tTitle: $title"
echo -e "\tSlug: $slug"

today=$(date '+%Y-%m-%d')
asset_dirname="project-$slug"
markdown_filename="$asset_dirname.md"

echo -e "\tAsset dir: $asset_dirname"
echo -e "\tFilename: $markdown_filename"

# "Tests"
if [[ -z "$asset_dirname" ]]; then
    echo "Foldername can't be empty" >&2
    exit 1
fi

if [[ ${#title} -le 3 ]]; then
    echo "Title should be longer than 3 chars" >&2
    exit 1
fi

if [[ "$markdown_filename" == *" "* ]]; then
    echo "No spaces allowed in filename" >&2
    exit 1
fi

if [[ "$markdown_filename" != *.md ]]; then
    echo "Filename should end with .md extension" >&2
    exit 1
fi

if [[ "$markdown_filename" != project* ]]; then
    echo "Filename should start with YYYY-MM-DD" >&2
    exit 1
fi

# Create asset dir
asset_dirpath="$ASSET_DIR/$asset_dirname"
mkdir -p "$asset_dirpath"
echo -e "\tSuccessfully created $asset_dirpath"

# Create thumbnail
default_thumbnail_path="$ASSET_DIR/images/default-thumbnail.png"
post_thumbnail_path="$ASSET_DIR/$asset_dirname/default-thumbnail.png"

echo -e "\tCopying $default_thumbnail_path -> $post_thumbnail_path"
cp "$default_thumbnail_path" "$post_thumbnail_path"

# Create markdown file
markdown_filepath="_projects/$markdown_filename"

header "$title" "$today" "$asset_dirname" > "$markdown_filepath"

echo -e "\tSuccessfully created $markdown_filepath"

echo -e "\tHave fun writing!"