---
title: "Pixels Predictions"
published: true
categories:  projects
author_profile: true
layout: single
classes:
- landing_page
toc: true
toc_sticky: true
date: 2023-12-12
categories:  projects
related: false
header:
    teaser: "/../assets/project-pixels-2-prediction/default-thumbnail.png"
excerpt: "Yet to Update"
---

# Why SageMaker?
Before diving into actual project, it's worth spending why I choose AWS SageMaker is the backbone of this project - Obviously Sagemaker been whole product compose other AWS service Glue together & Market Demand 😂

SageMaker is AWS's **fully managed machine learning platform** — it handles the undifferentiated heavy lifting of ML infra

FYI, plain boto3+EC2 can do that too.The value is in what SageMaker automates around training: distributed data loading, experiment tracking, hyperparameter tuning jobs, and one-command deployment to a real-time inference endpoint.

# Problem Statement.

I started as a weekend project, with 10-5 class subset, on the company I worked with given an opportunity to classify 50 different types of furniture on the high level, and it passes to specific model ( I always relies on ensambling btw ) to achieve good results.

A 10–15 class subset (like just the starters) trains fast and hits high accuracy easily — it doesn't stress-test the pipeline or justify a managed platform like SageMaker. Going with the full 150-class Gen 1 Pokédex introduces real inter-class similarity, class imbalance, and a large enough dataset that distributed training, hyperparameter tuning, and hosted endpoints actually earn their place.


| Criteria	              | SageMaker Studio (UI)	                                                       |  boto3 (General-Purpose SDK)	                                                    | SageMaker Python SDK (sagemaker lib)  |
|:-----------------------:|:------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------:|:-------------------------------------:|
| What it is	          | Web-based IDE for notebooks, pipelines, experiments	                           | Low-level AWS SDK — same one used for S3, EC2, Lambda, etc.	                    | High-level, ML-specific SDK built on top of boto3  |
| Best for	              | Exploration, visual debugging, one-off experiments, demoing to non-engineers   | Fine-grained control, scripting infrastructure alongside other AWS services	    | Actual training/deployment workflows — the “SageMaker way”  |
| Learning curve	      | Low — click-and-run	                                                           |Medium–high — raw API calls such as create_training_job() with verbose JSON configs	| Low–medium — purpose-built abstractions such as Estimator, .fit(), .deploy()  |
| Reproducibility	      | Poor — clicks aren't code and are hard to version	                           | Good — scriptable, but verbose and brittle	                                        | Good — scriptable and concise; designed for source control  |
| Automation-friendly     |	No — manual by nature	                                                       | Yes, but you rebuild ML-specific conveniences yourself	                            | Yes — designed for CI/CD and SageMaker Pipelines  |
| Abstraction level	      | Highest — little/no code required	                                           | Lowest — raw AWS API surface	                                                    | Middle — hides boilerplate while keeping control of ML logic  |
