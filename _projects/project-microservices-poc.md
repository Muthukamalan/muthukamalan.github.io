---
title: "Microservices in Reality"
published: true
date: 2026-06-31
categories:  projects
author_profile: true
layout: single
classes:
- landing_page
toc: true
toc_sticky: true
categories:  projects
related: false
header:
    teaser: "/../assets/project-microservices-poc/default-thumbnail.png"
excerpt: WIP
---


![alt text](/../assets/project-kserve/image.png)

In this Spae, I yap about three project:
- [votingapp](https://github.com/Muthukamalan/VotingApp)
- [wordwizards](https://github.com/Muthukamalan/WordWizards)
- [](https://github.com/googlecloudplatform/microservices-demo)
- [ML On Orchestr]()



# Learning Microservices the Hands-On Way: A Distributed Voting App

*A detailed look at [VotingApp](https://github.com/Muthukamalan/VotingApp) — a multi-language, multi-container distributed system built to make microservices concepts concrete, complete with observability baked in from day one.*

## The premise

Most microservices tutorials show you one service talking to one database and call it a day. That's not really where the interesting problems live. The interesting problems show up when you have multiple languages, a message broker in between, a cache doing double duty as a task backend, and metrics/tracing wired through the whole thing — because that's what a real distributed system actually looks like.

**VotingApp** is built around exactly that premise: a simple two-option voting app, deliberately kept functionally trivial, so that all the complexity budget goes toward the *plumbing* — queues, caches, persistence, exporters, tracing, dashboards — rather than the business logic.

## The core flow

The application itself is intentionally minimal:

1. A **Python Flask app** (`vote/`) serves the voting UI, letting a user pick between two options.
2. The vote gets pushed onto **RabbitMQ**, which acts as the message broker queuing incoming votes.
3. A **Celery worker** (`worker/`) consumes votes off that queue and writes them into **PostgreSQL**. Celery uses **Redis** as its backend for task state and metadata.
4. A **Node.js app** (`result/`) polls PostgreSQL every 2 seconds and displays live-updating results.

That's the whole "business logic" — four services, three infrastructure pieces, two languages. One vote per client browser is enforced; casting again just overwrites the previous vote rather than adding a new one.

## Where it gets interesting: observability

What sets this apart from the classic Docker example-voting-app it's inspired by is the observability layer stacked on top:

- **Flower** gives a web UI for watching Celery workers and tasks in real time — useful for actually seeing the queue drain rather than trusting it blindly.
- **Redis Insight** provides a GUI for poking around inside Redis directly.
- **Redis Exporter** and **PostgreSQL Exporter** both expose metrics in a Prometheus-scrapeable format, so cache and database health aren't a black box.
- **OpenTelemetry** collects distributed traces as a vote moves across services.
- **Jaeger** visualizes those traces, so you can follow a single vote's journey through Flask → RabbitMQ → Celery → Postgres.
- **Prometheus** scrapes metrics from all of the above.
- **Grafana** turns those metrics into dashboards.

In other words: every piece of infrastructure in this system is also instrumented to be *watched*. That's the real lesson of the project — not "how do you queue a task," but "how do you know your queue, cache, and database are healthy while it's happening."

## Two ways to run it

The project supports both a Docker Compose path and a Kubernetes path, which makes it useful as a bridge between "I understand containers" and "I understand orchestration."

**Docker Compose** — everything defined in a single `compose.yaml`:

```bash
docker compose up
```

**Kubernetes** — manifests live under `k8s/manifests/`, applied recursively:

```bash
kubectl apply -f -R k8s/manifests/
# or, more portably:
find k8s/manifests -type f \( -name "*.yml" -o -name "*.yaml" \) -print0 | xargs -0 kubectl apply -f
```

Having both paths side by side is a nice touch for learning — you can compare how the same nine-or-so services get expressed as Compose service definitions versus Kubernetes Deployments, Services, and manifests.

## Repo layout

```
.
├── vote/           # Flask voting frontend
├── worker/         # Celery worker consuming votes → Postgres
├── result/         # Node.js results app (polls Postgres)
├── postgres/       # DB config/init
├── prometheus/     # Prometheus scrape config
├── otel/           # OpenTelemetry collector config
├── k8s/manifests/  # Kubernetes manifests
└── compose.yaml    # Docker Compose definition
```

Each service directory is self-contained, which is exactly what you'd want if you're picking this apart to understand one piece at a time — you can go read `worker/` in isolation and understand the Celery/RabbitMQ/Postgres relationship without needing to hold the whole system in your head at once.

## Getting it running

Setup is standard Docker Desktop (Mac/Windows) or Docker Engine + Compose plugin (Linux):

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Recent Docker Desktop builds ship Kubernetes support out of the box, so the same machine can run both paths without extra tooling.

## Honest framing

The README itself is upfront about scope, and it's worth repeating here: this isn't meant to be a reference architecture for a production distributed system. It's explicitly a learning tool — a way to see caches, queues, and persistent storage working together across two languages, runnable identically via Compose or Kubernetes, with real observability wired in rather than bolted on as an afterthought. It builds on Docker's own `example-voting-app` and the `awesome-compose` collection, extending them with the monitoring and tracing stack that most basic examples skip entirely.

## Why this is a good project to study

A lot of "microservices demo" repos stop at "here are five containers that talk to each other." This one goes one layer further by making the *operational* side — metrics, traces, dashboards — a first-class part of the system rather than something you bolt on later. If you're trying to build intuition for how a vote actually flows through a distributed system, and more importantly, how you'd *know* if something broke along the way, this is a compact, self-contained place to see it end to end.

---

*Repo: [github.com/Muthukamalan/VotingApp](https://github.com/Muthukamalan/VotingApp)*



inspired from [project](https://github.com/jhonipereira/eGommerce)


inspired from either
    1) [gcp](https://github.com/GoogleCloudPlatform/bank-of-anthos)
    2) [gcp](https://github.com/GoogleCloudPlatform/another-example-boqutique)
    3) weavesdemos