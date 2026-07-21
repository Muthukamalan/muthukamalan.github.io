#!/bin/sh
#
# project - generate a new Zola project page with front matter (POSIX sh compatible)
#
# Usage:
#   ./project -T "My Project" -t Rust,PyO3,CLI
#
set -eu

usage() {
    echo "Usage: $0 -T \"Title\" -t Tag1,Tag2 [-d content_dir] [-i image_path]"
    exit 1
}

content_dir="content/projects"
tags=""
title=""
image=""

while getopts "t:T:d:i:h" opt; do
    case "$opt" in
        t) tags="$OPTARG" ;;
        T) title="$OPTARG" ;;
        d) content_dir="$OPTARG" ;;
        i) image="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

if [ -z "$title" ]; then
    echo "Error: title (-T) is required" >&2
    usage
fi

# slugify title -> filename (filename stays lowercase; tags keep their case)
slug=$(echo "$title" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g' \
    | sed -E 's/^-+|-+$//g')

# build tags array: "Tag1","Tag2" - case preserved (e.g. PascalCase) as typed
tags_formatted=""
if [ -n "$tags" ]; then
    old_ifs="$IFS"
    IFS=,
    for t in $tags; do
        IFS="$old_ifs"
        # trim leading/trailing whitespace, keep original case
        t_trimmed=$(echo "$t" | sed -E 's/^ +| +$//g')
        [ -z "$t_trimmed" ] && continue
        tags_formatted="${tags_formatted}\"$t_trimmed\","
        IFS=,
    done
    IFS="$old_ifs"
    tags_formatted="${tags_formatted%,}"
fi

date_str=$(date "+%Y-%m-%d %H:%M:%S")

mkdir -p "$content_dir"
filepath="${content_dir}/${slug}.md"

if [ -e "$filepath" ]; then
    echo "Error: $filepath already exists" >&2
    exit 1
fi

cat > "$filepath" <<EOF
+++
date = "$date_str"
draft = false
title = "$title"
description = ""
template = "page.html"
weight = 1


[taxonomies]
tags = [$tags_formatted]

[extra]
local_image = '$image'
giscus = false
toc = false
quick_navigation_buttons = true
+++
<details>
    <summary>Table Of Content</summary>
    <!-- toc -->
</details>
EOF

echo "Created $filepath"