""""Prompts the user to input a title ("new title") this then gets slugified and
the asset folder (assets/YYYY-MM-DD-new-title) gets made and the markdown file
gets made (_posts/YYYY-MM-DD-new-title)."""
import datetime
import os
import unicodedata
import re
import shutil

def header(title: str, date, asset_dirname: str) -> str:
    """Returns the header to be written to the md file"""

    assert len(title) > 0
    assert len(asset_dirname) > 0

    return f"""---
title: "{title}"
date: {date.strftime("%Y-%m-%d")}
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
    teaser: "/../assets/{asset_dirname}/default-thumbnail.png"
author_profile: true
layout: single
classes:
- landing_page
toc: true
toc_sticky: true
categories:  projects
related: false
---
<!-- ctrl + alt + v -->
<!-- cmd + alt + v -->

checklist:
- thumbnail
- tags
- content


"""

def slugify(value, allow_unicode=False) -> str: 
    """
    Convert to ASCII if 'allow_unicode' is False. Convert spaces or repeated
    dashes to single dashes. Remove characters that aren't alphanumerics,
    underscores, or hyphens. Convert to lowercase. Also strip leading and
    trailing whitespace, dashes, and underscores.
    """
    value = str(value)
    if allow_unicode:
        value = unicodedata.normalize('NFKC', value)
    else:
        value = unicodedata.normalize('NFKD', value).encode('ascii', 'ignore').decode('ascii')
    value = re.sub(r'[^\w\s-]', '', value.lower())
    return re.sub(r'[-\s]+', '-', value).strip('-_')

ASSET_DIR = "assets"

if __name__ == "__main__":
    # Request input from user
    title = input("Title of blog post (Ctrl + C to cancel): ")
    slug = slugify(title)
    print("Creating a new blog post for you...")
    print("\tTitle: ", title)
    print("\tSlug: ", slug)

    today = datetime.date.today()
    asset_dirname = "project"+ "-" + slug # ex 2022-05-20-title-of-new-post
    markdown_filename = asset_dirname + ".md" # 2022-05-20-title-of-new-post.md
    print("\tAsset dir: ", asset_dirname)
    print("\tFilename: ", markdown_filename)

    # "Tests"
    assert len(asset_dirname) > 0, "Foldername can't be empty"
    assert len(title) > 3, "Title should be longer than 3 chars"
    assert " " not in markdown_filename, "No spaces allowed in filename"
    assert markdown_filename.endswith(".md"), "Filename should end with .md extension"
    assert markdown_filename.startswith("project"), "Filename should start with YYYY-MM-DD"

    # Create asset dir
    asset_dirpath = os.path.join(ASSET_DIR, asset_dirname)
    os.makedirs(asset_dirpath, exist_ok=True)
    print(f"\tSuccessfully created {asset_dirpath}")

    # Create thumbnail
    default_thumbnail_path = os.path.join(ASSET_DIR, "images","default-thumbnail.png")
    post_thumbnail_path = os.path.join(ASSET_DIR, asset_dirname, "default-thumbnail.png")
    print(f"\tCopying {default_thumbnail_path} -> {post_thumbnail_path}")
    shutil.copy(default_thumbnail_path, post_thumbnail_path)

    # Create markdown file
    markdown_filepath = os.path.join("_projects", markdown_filename)
    with open(markdown_filepath, "w") as f:
        md_header = header(title, today, asset_dirname)
        f.write(md_header)
    print(f"\tSuccessfully created {markdown_filepath}")

    print(f"\tHave fun writing!")