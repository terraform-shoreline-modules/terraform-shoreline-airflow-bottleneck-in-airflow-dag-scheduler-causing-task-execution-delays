terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "bottleneck_in_airflow_dag_scheduler_causing_task_execution_delays" {
  source    = "./modules/bottleneck_in_airflow_dag_scheduler_causing_task_execution_delays"

  providers = {
    shoreline = shoreline
  }
}