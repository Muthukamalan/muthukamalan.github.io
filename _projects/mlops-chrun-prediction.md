---
title: "MLOps Case Study"
published: true
date: 2022-03-20
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
    teaser: "/../assets/project-mlops-churn/default-thumbnail.png"
    image: 
excerpt: "case study that demonstrates the transition from Jupyter notebooks to production-grade containers while ensuring reproducibility and observability"
---




Project Home: [`Customer-Churn-Prediction`](https://github.com/Muthukamalan/Customer-Churn-Prediction)

# Introduction
Most churn prediction tutorials stop at a Jupyter notebook and a confusion matrix. [`Customer-Churn-Prediction`](https://github.com/Muthukamalan/Customer-Churn-Prediction) takes the opposite approach: it treats churn modeling as an excuse to wire up a full MLOps stack — versioned data, reproducible hyperparameter search, experiment tracking, and observability — all orchestrated through Docker Compose. Here's a walkthrough of how the pieces fit together and why each one is there.

![churn prediction](/../assets/project-mlops-churn/churn-prediction.png)


## Problem Statement:: Churn Prediction
It's easy to see every problem as an opportunity to use AI. Instead, let's start with the problem statement and determine whether AI is the right tool.
![nails](/../assets/project-mlops-churn/nail.gif)

Let's Discuss the problem cycle before we jump into tools, solving technology is also good problem.

Every Industrial problems should be evaluated from multiple feasibility perspectives before development begins.
- **Technical feasibility**  - assesses whether sufficient, high-quality data and appropriate tools are available or what tools needs to be useful.
- **Economic feasibility** determines whether the expected business benefits, such as reduced customer loss and increased retention.
- **Operational feasibility** evaluates whether the organization can effectively use ![scope-change.png](/../assets/project-mlops-churn/scope-change.png)
- **Auditing & Governance feasibility**  focuses on establishing clear policies for data ownership, data sources, fairness and compliance thoughout it's lifecycle


Use Cases of Churn Prediction 
1. Stop-loss Intervention and Win-back Forensics
    - Identify customers who are likely to leave and take actionable items such as sending personalized emails, offering discounts, rewards just to encourage them to stay
    - Analyze who already done it and understand why they left how to get them back.
2. Understanding the Drivers of Churn
    - Help the business make improvements based on data rather than assumptions


### Business Phase
Know your KPI, Know your Data

| **KPI**                                   | **What it Measures**                                                     | **Why it Matters**                                                    |
| ----------------------------------------- | ------------------------------------------------------------------------ | --------------------------------------------------------------------- |
| **Gross Customer Churn Rate**             | Percentage of customers who leave during a given period.                 | Measures overall customer loss and retention performance.             |
| **Net Customer Churn Rate**               | Difference between new customer acquisitions and customer cancellations. | Indicates whether the customer base is growing or shrinking.          |
| **Daily Active Users (DAU)**              | Number of customers actively using the product each day.                 | Declining DAU can signal poor customer experience or potential churn. |
| **Weekly/Monthly Active Users (WAU/MAU)** | Number of customers active each week or month.                           | Measures long-term engagement and product adoption.                   |


### Data Phase
Sometime we may loss into complex understanding and data maturity, it may grow as 
1. *Business Domain and Requirements Discovery* – Understanding the business problem, objectives, stakeholders, and success criteria.
1. *ETL Project* – Collecting, cleaning, integrating, and preparing data from multiple sources or formulating implementation of the new workflow.(step 6)
1. *Data Engineering and Data Wrangling Projec*t – Building reliable data pipelines, transforming raw data, and ensuring data quality. In many organizations, this effort takes significantly more time than developing the machine learning model itself.
1. *Feature Engineering Project* – Creating meaningful features that capture customer behavior and improve model performance.
1. *Machine Learning Project* – Selecting algorithms, training models, evaluating performance, and optimizing predictions.
1. *Business Implementation Project* – Deploying the model into production and integrating predictions into business workflows, such as CRM systems or marketing campaigns.
1. *Results Assessment Project* – Monitoring model performance, measuring business impact, validating assumptions, and continuously improving the solution.



Build a standardized Advanced Analytics Data Model that is tailored to your business.
{: .notice--info}

### Prepare Workflow Phase
![lost-in-complex-modeling](/../assets/project-mlops-churn/complex.png)


### Modeling & Interpretation Phase 

Modeling aims to capture the relationship between customer behavior and churn. Most machine learning algorithms are fundamentally curve-fitting method at the EOD by learn relationship from historical data.
![alt text](/../assets/project-mlops-churn/curve-fitting.png)


But What matters is the Actionable insights irrespective of ±0.0?? loss.
![alt text](/../assets/project-mlops-churn/use-ful-info.png)


### Principles of Effective Metrics

* **Measure what matters.** Focus on a small set of meaningful metrics that drive decisions rather than tracking everything.
* **Connect metrics to people.** Metrics should be traceable to individual customers so that quantitative insights can be validated through real customer feedback.
* **Measure business outcomes.** Prioritize metrics that reflect business success, such as revenue, retention, or customer satisfaction, instead of intermediate metrics like clicks or page views.




![actionale-items](/../assets/project-mlops-churn/understandable-model.png)

### Evalution of Model 
Evalution is crucial not only for audit purpose. To understand how it behaves to End Users


![alt text](/../assets/project-mlops-churn/roc-auc.png)

| principle| Strategy | Description  | Example    |
|----------| ---------| -------------|----------- | 
| Listen continuously| Talk to Your Customers                     | Collect regular feedback to understand customer needs and pain points before they leave.                | Send customer satisfaction surveys, provide in-app feedback forms, or use live chat to gather suggestions.      |
| Fix root causes| Know Your Weaknesses                       | Identify product or service shortcomings and continuously improve them.                                 | A SaaS company discovers users struggle with onboarding and redesigns the onboarding experience.                |
| Position yourself| Focus on Your Competitive Advantage        | Reinforce the unique value your product offers compared to competitors.                                 | An online storage service reminds customers about its secure backup and cross-device synchronization features.  |
| Learn from cancellations| Understand Why Customers Cancel            | Capture cancellation reasons and analyze common patterns to reduce future churn.                        | Add an exit survey asking, "Why are you leaving?" with options like "Too expensive" or "Missing features."      |
| Educate customers| Improve Customer Education                 | Help customers realize the full value of your product through proactive guidance.                       | Send tutorial emails, onboarding videos, or feature walkthroughs after signup.                                  |
| Reinforce value| Reassure Customers of Your Product's Value | Regularly remind customers about new features and benefits so they don't overlook your product's value. | Include new feature announcements and success stories in newsletters or support responses.                      |


![confusion matrix](/../assets/project-mlops-churn/confusion_matric.png)





## Engineering Specfication
### Tools
Inside Customer-Churn-Prediction:

<!-- Development -->
[![Python](https://img.shields.io/badge/Python-3.11_|_3.12_|_3.13-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![Anaconda](https://img.shields.io/badge/Anaconda-44A833?logo=anaconda&logoColor=white)](https://www.anaconda.com/)
[![Docker Compose](https://img.shields.io/badge/Docker_Compose-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/compose/)

[![black](https://img.shields.io/badge/Code%20Style-Black-black.svg?labelColor=gray)](https://black.readthedocs.io/en/stable/)
[![isort](https://img.shields.io/badge/%20imports-isort-%231674b1?style=flat&labelColor=ef8336)](https://pycqa.github.io/isort/) 
[![ruff](https://img.shields.io/badge/Ruff-D7FF64?logo=ruff&logoColor=black)](https://docs.astral.sh/ruff/)
[![Precommit](https://img.shields.io/badge/pre--commit-FAB040?logo=precommit&logoColor=black)](https://pre-commit.com/)<br>

<!-- Machine Learning -->
[![Scikit-learn](https://img.shields.io/badge/scikit--learn-F7931E?logo=scikitlearn&logoColor=white)](https://scikit-learn.org/)
[![Optuna](https://img.shields.io/badge/Optuna-6863FF?logo=optuna&logoColor=white)](https://optuna.org/)
[![Hydra](https://img.shields.io/badge/Hydra-89B8CD?logoColor=white)](https://hydra.cc/)
[![MLflow](https://img.shields.io/badge/MLflow-0194E2?logo=mlflow&logoColor=white)](https://mlflow.org/)
[![numpy](https://img.shields.io/badge/NumPy-013243?logo=numpy&logoColor=white)](https://numpy.org/)
[![pandas](https://img.shields.io/badge/Pandas-150458?logo=pandas&logoColor=white)](https://pandas.pydata.org/)

<!-- Data & Storage -->
[![DVC](https://img.shields.io/badge/DVC-945DD6?logo=dvc&logoColor=white)](https://dvc.org/)
[![MinIO](https://img.shields.io/badge/MinIO-C72E49?logo=minio&logoColor=white)](https://min.io/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![pgAdmin](https://img.shields.io/badge/pgAdmin-336791?logo=postgresql&logoColor=white)](https://www.pgadmin.org/)
[![S3](https://img.shields.io/badge/Amazon_S3-569A31?logo=amazons3&logoColor=white)](https://aws.amazon.com/s3/)

<!-- Serving & Monitoring -->
[![FastAPI](https://img.shields.io/badge/FastAPI-009688?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com/)
[![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?logo=prometheus&logoColor=white)](https://prometheus.io/)
[![Grafana](https://img.shields.io/badge/Grafana-F46800?logo=grafana&logoColor=white)](https://grafana.com/)


[![Makefile](https://img.shields.io/badge/Makefile-6D00CC?logo=gnu&logoColor=white)](https://www.gnu.org/software/make/)


### Dataset Scope
The project uses a telecommunications churn dataset assembled from several IBM-provided extracts — demographics, location, population, services, and account status — merged into a single `customer_churn` table. Rather than working off flat CSVs sitting in a repo, the data is loaded into PostgreSQL and versioned from there, which sets the tone for the rest of the project: nothing is treated as a one-off script.



### MLOps Life Cyle

MLOps supports every stage of the ML lifecycle—from data ingestion, feature engineering, model training, deployment, and inferencing to monitoring. 

This project builds an end-to-end Telecom Churn Prediction pipeline using DVC, Hydra, Optuna, MLflow, Docker, PostgreSQL, Prometheus, and Grafana for reproducibility, experiment tracking, deployment, and observability.

The primary objective is to show how modern MLOps tools work together to create a reproducible, scalable, and maintainable machine learning pipeline on  local setup using Docker compose.


```mermaid
flowchart TD

subgraph group_data["Data lifecycle"]
  node_raw["Raw Excel files<br/>source data<br/>[.gitkeep]"]
  node_prep["Ingestion preparation<br/>Python script"]
  node_postgres_init["Postgres initialization<br/>database bootstrap<br/>[init-db.sh]"]
  node_postgres[("Customer churn table<br/>PostgreSQL")]
  node_dvc["Versioned CSV export<br/>DVC artifact"]
end

subgraph group_ml["ML workflows"]
  node_train_config["Hydra train composition<br/>configuration<br/>[train.yaml]"]
  node_model_configs["Model variants<br/>Hydra model configs<br/>[default.yaml]"]
  node_training["Model training<br/>Python entry point<br/>[train.py]"]
  node_hparams_config["Tuning settings<br/>Hydra configuration<br/>[hparams.yaml]"]
  node_search_spaces["Model search spaces<br/>Optuna configs"]
  node_tuning["Hyperparameter tuning<br/>Python entry point<br/>[hparams.py]"]
end

subgraph group_runtime["Local runtime"]
  node_mlflow[("MLflow tracking<br/>experiment tracking")]
  node_minio[("MinIO artifact storage<br/>S3-compatible storage")]
  node_compose["Docker Compose<br/>local orchestrator<br/>[compose.local.yaml]"]
  node_prometheus["Prometheus<br/>metrics collection<br/>[prometheus.yaml]"]
  node_grafana["Grafana<br/>metrics visualization"]
  node_app_environment["Python application environment<br/>runtime definition<br/>[pyproject.toml]"]
end

node_raw -->|"prepare"| node_prep
node_prep -->|"produces ingestion-ready data"| node_postgres_init
node_postgres_init -->|"loads"| node_postgres
node_postgres -->|"DVC import/export"| node_dvc
node_train_config -->|"selects"| node_model_configs
node_train_config -->|"composes runtime config"| node_training
node_model_configs -->|"configures classifier"| node_training
node_dvc -->|"dataset input"| node_training
node_training -->|"logs runs and models"| node_mlflow
node_hparams_config -->|"controls trials"| node_tuning
node_search_spaces -->|"defines candidates"| node_tuning
node_model_configs -->|"tunes model family"| node_tuning
node_dvc -->|"dataset input"| node_tuning
node_tuning -->|"logs tuning runs"| node_mlflow
node_mlflow -->|"stores artifacts"| node_minio
node_compose -->|"starts service"| node_postgres
node_compose -->|"starts service"| node_mlflow
node_compose -->|"starts service"| node_minio
node_compose -->|"starts service"| node_prometheus
node_compose -->|"starts service"| node_grafana
node_prometheus -->|"metrics source"| node_grafana
node_app_environment -.->|"provides dependencies"| node_training
node_app_environment -.->|"provides dependencies"| node_tuning

click node_raw "https://github.com/muthukamalan/customer-churn-prediction/blob/main/data/raw/.gitkeep"
click node_prep "https://github.com/muthukamalan/customer-churn-prediction/blob/main/scripts/prep_db_ingestion.py"
click node_postgres_init "https://github.com/muthukamalan/customer-churn-prediction/blob/main/postgres/init-db.sh"
click node_dvc "https://github.com/muthukamalan/customer-churn-prediction/blob/main/customer_churn.csv.dvc"
click node_train_config "https://github.com/muthukamalan/customer-churn-prediction/blob/main/configs/train.yaml"
click node_model_configs "https://github.com/muthukamalan/customer-churn-prediction/blob/main/configs/model/default.yaml"
click node_training "https://github.com/muthukamalan/customer-churn-prediction/blob/main/src/train/train.py"
click node_hparams_config "https://github.com/muthukamalan/customer-churn-prediction/blob/main/configs/hparams.yaml"
click node_search_spaces "https://github.com/muthukamalan/customer-churn-prediction/blob/main/configs/hparams/random_forest_hparam.yaml"
click node_tuning "https://github.com/muthukamalan/customer-churn-prediction/blob/main/src/hparams/hparams.py"
click node_compose "https://github.com/muthukamalan/customer-churn-prediction/blob/main/compose.local.yaml"
click node_prometheus "https://github.com/muthukamalan/customer-churn-prediction/blob/main/prometheus/prometheus.yaml"
click node_app_environment "https://github.com/muthukamalan/customer-churn-prediction/blob/main/pyproject.toml"

classDef toneNeutral fill:#f8fafc,stroke:#334155,stroke-width:1.5px,color:#0f172a
classDef toneBlue fill:#dbeafe,stroke:#2563eb,stroke-width:1.5px,color:#172554
classDef toneAmber fill:#fef3c7,stroke:#d97706,stroke-width:1.5px,color:#78350f
classDef toneMint fill:#dcfce7,stroke:#16a34a,stroke-width:1.5px,color:#14532d
classDef toneRose fill:#ffe4e6,stroke:#e11d48,stroke-width:1.5px,color:#881337
classDef toneIndigo fill:#e0e7ff,stroke:#4f46e5,stroke-width:1.5px,color:#312e81
classDef toneTeal fill:#ccfbf1,stroke:#0f766e,stroke-width:1.5px,color:#134e4a
class node_raw,node_prep,node_postgres_init,node_postgres,node_dvc toneBlue
class node_train_config,node_model_configs,node_training,node_hparams_config,node_search_spaces,node_tuning toneAmber
class node_mlflow,node_minio,node_compose,node_prometheus,node_grafana,node_app_environment toneMint
```

### Data versioning that respects a database

Instead of the usual "commit a CSV" approach, this project pulls data straight out of Postgres using DVC's database import feature:

```bash
dvc init
dvc config core.autostage true
dvc config core.analytics false

# [dvc-doc](https://doc.dvc.org/command-reference/import-db#database-connections)
# dvc config db.pgsql.url postgresql://user@hostname:port/database
# dvc config --local db.pgsql.password password

dvc config db.pgsql.url "postgresql://mlflow_db:mlflow_db@localhost:5432/mlchurn"
dvc config --local db.pgsql.password mlflow_db

# [dvc-doc](https://doc.dvc.org/command-reference/import-db#installing-database-drivers)
# dvc import-db --table customers_table --conn pgsql

dvc import-db --table "customer_churn" --conn pgsql # import from table to CSV (local) md5 hash
```

![pgadmin](https://imgproxy.flathub.org/insecure/dpr:1/f:webp/rs:fill-down/aHR0cHM6Ly9kbC5mbGF0aHViLm9yZy9tZWRpYS9vcmcvcGdhZG1pbi9wZ2FkbWluNC8yODMwOTU5NDRmZDMyODU2OTI1NmEwOTkzZTY0OGE4MC9zY3JlZW5zaG90cy9pbWFnZS0yX29yaWcucG5n)


This is a nice pattern worth stealing: `dvc import-db` snapshots a table into a local, hashed CSV (tracked via a `.dvc` file), so every training run can point at an exact, reproducible version of the data — even though the source of truth lives in a live database, not a static file. The raw Excel extracts get prepared and normalized by `scripts/prep_db_ingestion.py`, which writes into `data/processed/` before the table gets seeded into Postgres.

### One Compose file, one command

The entire environment — Postgres, MLflow, MinIO (as the artifact store), Prometheus, and Grafana — comes up with:

```bash
docker compose -f compose.local.yaml up -d
```
![Containers](https://raw.githubusercontent.com/Muthukamalan/Customer-Churn-Prediction/main/assets/containers_list.png)

Service discovery between containers is handled entirely inside Compose, so there's no manual wiring of hostnames or ports between the training scripts and the tracking/storage backends. This is the detail that makes the rest of the project actually reproducible on someone else's machine: clone the repo, run one command, and the scaffolding for experiment tracking and monitoring already exists.

### Hyperparameter search: Hydra config groups + Optuna sweeper

The hyperparameter search is config-driven rather than hardcoded. A search space is declared in YAML:

```yaml
# configs/hparams/decision_tree_hparam.yaml
params:
    model.max_depth: range(2, 20, 5)
    model.min_samples_split: range(0, 20, 1)
    model.min_samples_leaf: choice(1, 2, 4)
```

![hparams](https://github.com/Muthukamalan/Customer-Churn-Prediction/raw/main/assets/hparams_search.png)

and launched as a Hydra multirun:

```bash
HYDRA_FULL_ERROR=1 python src/hparams/hparams.py -m hparams=decision_tree_hparam
```
![mlflow](https://github.com/Muthukamalan/Customer-Churn-Prediction/blob/main/assets/run_model.png?raw=true)

<div style="background-color: #faf5ff; border-left: 5px solid #9333ea; padding: 12px 16px; margin: 16px 0; border-radius: 4px; font-family: sans-serif; color: #6b21a8;">
    <strong>✨ Important:</strong> Issues while facing multirun <br>
    <span style="color: #000;">- matplotlib.use("Agg")  # Forces a headless, thread-safe backend</span><br>
    <span style="color: #000;">- optimizing for F1 Score</span>
</div>

Under the hood, Hydra's Optuna sweeper plugin drives the actual search — trial count, direction, and job concurrency are all config values (`n_trials`, `direction: maximize`, `n_jobs`), and the objective being maximized is F1 score, a sensible choice given churn datasets are typically imbalanced and precision/recall trade-offs matter more than raw accuracy. One practical gotcha the author flags: multirun sweeps need `matplotlib.use("Agg")` forced explicitly, since the default backend isn't thread-safe when Optuna fires off concurrent trials.

Swapping `hparams=decision_tree_hparam` for another config file is enough to point the same search machinery at a different model family — the project currently supports:

- Logistic Regression
- Decision Tree
- Gradient Boosting
- K-Nearest Neighbors
- Random Forest

with broader scikit-learn model coverage listed as a TODO.

### Training and artifact tracking

Once a search has identified good hyperparameters, a full training run is a single Hydra-composed command:

```bash
HYDRA_FULL_ERROR=1 python src/train/train.py mlflow.run_name=rf_best_model model=random_forest
```
![minio](https://github.com/Muthukamalan/Customer-Churn-Prediction/blob/main/assets/minio_artifact_path.png?raw=true)

Every run logs to MLflow, and every trained model artifact lands in the MinIO container rather than on local disk — meaning experiment metadata and the actual serialized models are both centrally accessible, which matters the moment more than one person (or more than one machine) touches the project.



### Observability from day one

Most churn-prediction side projects stop at "does the model score well." This one ships Prometheus and Grafana as first-class Compose services from the start, which signals a bias toward treating the model as something that will eventually run as a service and need monitoring — not just a notebook artifact that gets screenshotted into a slide deck.

![prom](https://grafana.com/static/img/docs/grafana-cloud/arch_diagrams/localprom.jpg)

![grafana](https://prometheus.io/assets/docs/grafana_qps_graph.png)

### Why this project is a good MLOps reference

What makes this repo worth reading isn't the model choice — decision trees and random forests on churn data are well-trodden ground. It's the plumbing:

- **DVC + `import-db`** for reproducible database-backed datasets, not just file-backed ones.
- **Hydra config groups** that turn "try a different model" into a one-line CLI override instead of a code change.
- **Optuna via Hydra's sweeper plugin** for hyperparameter search that's declarative and resumable.
- **MLflow + MinIO** for tracking and artifact storage that survive container restarts.
- **Prometheus + Grafana** wired in from the start, not bolted on after a production incident.

For anyone setting up a similar pipeline, the pattern worth copying is the layering: data versioning, config-driven search, experiment tracking, and monitoring are each handled by a purpose-built tool, glued together with Hydra configs and a single Compose file rather than custom orchestration code.




## Gist from experiences:
-  If you keenly following your problem then get to know how to do things like run email and call campaigns, create churn save playbooks and designing pricing and packaging in your org. Don't think SILOS<br>
![elephant and blind](/../assets/project-mlops-churn/elephant-blind-man.png)

- *Churn* — When a customer quits using a service or cancels their subscription.$\text{churn_rate} = \frac{\text{churned_customers}}{\text{start_customers}}$
![churn](/../assets/project-mlops-churn/chrun.png)



-  *Customer retention* — Keeping customers using a service and renewing their subscriptions (if there are subscriptions). Customer retention is the opposite of churn. $\text{retention_rate} = \frac{\text{retained_customers}}{\text{start_customers}}$
![alt text](/../assets/project-mlops-churn/net_retention.png)



![alt text](/../assets/project-mlops-churn/typical-scenario.png)
   - ·A product or service is offered and used on a recurring basis.
   - ·Customers interact with the product.
   - ·Customers may have subscriptions to receive the product or service. Subscriptions often (but not always) cost money.
   - ·Subscriptions can be ended or canceled, which is known as churn. If there are no subscriptions, a customer churns when they stop using the product.
   - ·The timing, prices, and payments for the customers and subscriptions (if any) are captured in a database, typically a transactional database.
   - ·When customers use or interact with the product or service, these events are often tracked and stored in a data warehouse.

1.  Churn measurement—Uses subscription data to identify churns and create churn metrics. The churn rate is an example of a churn metric. The subscription database also allows identification of customers who churned and who renewed and exactly when they did; this data is needed for further analysis.
2.  Behavioral measurement—Uses the event data warehouse to create behavioral metrics that summarize the events pertaining to each subscriber. Creating behavioral metrics is a crucial step that allows the events in the data warehouse to be interpreted.
3.  Churn analysis—Uses behavioral metrics for identified churns and renewals. The churn analysis identifies which subscriber behaviors are predictive of renewal and which are predictive of churn, and can create a churn risk prediction for every subscriber.
o   At this stage, sources of information in addition to the subscriber database and event data warehouse can also be brought into the analysis (not shown in figure 1.1). These include demographic information about customers or users who are individual consumers (age, education, etc.) and firmographic information about subscribers that are businesses (industry, number of employees, etc.).
4.  Segmentation—Based on their characteristics and risks, divides customers into groups or segments that combine aspects of their risk level, their behaviors, and any other significant characteristics. These segments target customers for interventions designed to maximize subscriber lifetime and engagement with the service.
5.  Intervention—Using the insights and subscriber segmentation rules derived from the churn analysis, plans and executes churn-reducing interventions, including email marketing, call campaigns, and training. Another long-term intervention makes changes to the product or service, and the information from the churn analysis is useful for this too.

Price reduction is a “diamond bullet” against churn: it always works, but you can’t afford it.  If a silver bullet means low cost and a reliable method, there are no silver bullets to reduce churn!
{:.notice--success}

A one-size-fits-all churn intervention doesn’t exist, so predicting customers at risk of churn is only a little helpful for reducing churn.
{:.notice--success}

- Focus on understanding the data and designing metrics (aka feature engineering) instead of algorithms


Customer:
- Subscription: a subscriber has a subscription 
    - Monthly recurring revenue (MRR)—Paid subscriptions have an associated amount of recurring monthly revenue.
- customer: customer pays
- users: do neither

**Product with recurring user interaction**

Subscription services can collect three types of payments
- Recurring payments—Fixed payments of the same amount for each period of service
- Usage-based payments—Payments for the amount of service used, based on some unit of measure
- One-time payments—Usually fees for setup but also for temporary (non-recurring) upgrades to service or one-time (in-app) purchases

Products:
   - B2C
   - D2C
   - B2B [SaaS]

Ad-supported media <br>
Consumer feed subscriptions <br>
Freemium Business Model <br>
In-app purchase <br>
   - Inactivity as churn
   - Free trial conversion
   - Upsell/down sell
   - Other yes/no (binary) customer predictions
   - Customer activity predictions 

Customer behavior data <br>

great customer metrics
   - Utilization—Metrics that show how much of the service the customer uses. If the service imposes limits on some types of use, a utilization metric shows what percentage of the allowed amount the customer took advantage of.
   - Success—Metrics that show how successful a user is in activities that have different outcomes.
   - Unit cost—Metrics that relate to the price the customer pays for the quantity of the service consumed or used.


| klipfolio churn vs active users | Broadly churn vs promotors| versature churn vs local calls|
|---------------------------------|---------------------------|-------------------------------|
|![alt text](/../assets/project-mlops-churn/churn_vs_active_users.png)| ![alt text](/../assets/project-mlops-churn/broadly_churn_vs_promotors.png)|![alt text](/../assets/project-mlops-churn/versature_churn_versus_local_calls.png)|


### Measure churn
### Measure Customers
### Observe Renewal and Churn
### Understand behaviours with metrics 
### Relationship between customer metrics
### Segmenting customer with advanced metrics
### Forecasting metrics
### Forecasting accuracy
### Churn demographics and firmographics
### Moral

