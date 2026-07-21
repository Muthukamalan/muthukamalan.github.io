+++
date = "2022-01-09 05:20:35"
draft = false
title = "Telecom Churn Prediction MLOps"
description = "https://github.com/Muthukamalan/Customer-Churn-Prediction"
weight = 1
template = "page.html"

[taxonomies]
tags = ["Python","MLOps"]


[extra]
local_image = '/images/thumbnails/projects/churn-prediction.png'
quick_navigation_buttons = true
toc = false
+++
<details>
    <summary>Table Of Content</summary>
    <!-- toc -->
</details>

Building an End-to-End Telecom Churn Prediction Pipeline: DVC, Hydra, Optuna, and MLflow in Docker


{% mermaid(invertible=true, full_width=false) %}
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
{% end %}