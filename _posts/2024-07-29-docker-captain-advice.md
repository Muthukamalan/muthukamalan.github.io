---
title: "Docker Captain Advice"
date: 2024-07-29
tags:
- software
- docker

categories: blog
toc: false
toc_sticky: false
header:
    teaser: "/../assets/2024-07-29-docker-captain-advice/default-thumbnail.png"
---
    

# Docker
https://www.xiaoyeshiyu.com/post/cdb9.html

## What is Docker?

## VM Workload
We need to isolate the app components from the host environment

![alt text](/../assets/2024-07-27-kubernetes/vm-workload.png)

## Docker Workload
![alt text](/../assets/2024-07-27-kubernetes/docker-workload.png)


### Resouce Isolation
Implemented by a number of Linux APIs:
- **cgroups:** Restrict resources a process can consume
    - CPU,
    - Memory
    - Disk IO,..
- **namespaces:** Change a process's view of the system
    - Network Interfaces,
    - PIDs,
    - Users,
    - Mounts,...
- **capabilities:** Limit what a user can do
    - mount,
    - kill,
    - chown,...
- **chroots:** Determines what parts of the filesystem a users can see