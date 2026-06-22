+++
date = "2026-05-01 15:01:35"
title = "Git Routines - Intermediate"
description = "Let's commit it"

[taxonomies]
tags = ["bash", "linux", "git"]

[extra]
image = '/images/post/git/thumbnail.png'
+++


### Introduction
Distributed version control systems combine the capabilities of local and remote systems. Developers can store the entire codebase locally, allowing independent work and offline changes. Developers then synchronize their local changes to a central server for other collaborators to consume.


### Installation
```sh
# GIT
sudo apt update && sudo apt install git
git --version
# GIT LFS
sudo apt-get install git-lfs
git lfs install
```

### Configuration

config file loaded fron `~/.gitconfig` or `~/.config/git/` dir
```toml
[user]
        name = USER_NAME
        email = USER_MAIL
[core]
        editor = code --wait
[init]
        defaultbranch = main
[log]
        decorate = full
[rerere]
        enabled = false
[advice]
        forcedeletebranch = true
[alias]
    lol= "!git --no-pager log --oneline --decorate --graph --parents --all"
    wdiff = diff -w --word-diff=color --ignore-space-at-eol
    ss = status -bsv
[commit]
    verbose=true
```

> [!NOTE] Global/Local Namespace 
> --global adding config in global space
> --local adding config in local git-space level


```sh
git config --global user.name "Your name"
git config --global user.email "email@domain.com"
git config --global core.editor "code --wait"
git config --global init.defaultbranch main
git config --global log.decorate full
git config --global rerere.enabled false
git config --global advice.forcedeletebranch true


#
git config --add --local webflyx.tone Black
git config --add --local webflyx.status Married
git config --add --local webflyx.status FamilyMan
# unset
git config --unset --local webflyx.tone
# unset-all
git config --unset-all --local webflyx.status
# remove section
git config --remove-section webflyx
```