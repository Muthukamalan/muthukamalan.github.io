#!/bin/sh
#
# post - generate a new Zola post with front matter (POSIX sh compatible)
#
# Usage:
#   ./post -T "My Title" -t tag1,tag2,tag3
#
set -eu

usage() {
    echo "Usage: $0 -T \"Title\" -t tag1,tag2,tag3 [-d content_dir]"
    exit 1
}

content_dir="content/blog"
tags=""
title=""

while getopts "t:T:d:h" opt; do
    case "$opt" in
        t) tags="$OPTARG" ;;
        T) title="$OPTARG" ;;
        d) content_dir="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

if [ -z "$title" ]; then
    echo "Error: title (-T) is required" >&2
    usage
fi

# slugify title -> filename
slug=$(echo "$title" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g' \
    | sed -E 's/^-+|-+$//g')

# build tags array: "tag1","tag2"  (no bash arrays - use a loop with IFS)
tags_formatted=""
if [ -n "$tags" ]; then
    old_ifs="$IFS"
    IFS=,
    for t in $tags; do
        IFS="$old_ifs"
        # trim leading/trailing whitespace
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
draft = true
title = "$title"
description = ""
weight = 1
template = "page.html"


[taxonomies]
tags = [$tags_formatted]


[extra]
local_image  = ''
toc = false
quick_navigation_buttons = true
+++



<details>
    <summary>Table Of Content</summary>
    <!-- toc -->
</details>
EOF

echo "Created $filepath"