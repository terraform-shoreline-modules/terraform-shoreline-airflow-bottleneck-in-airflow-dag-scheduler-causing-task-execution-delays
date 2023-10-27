resource "shoreline_notebook" "bottleneck_in_airflow_dag_scheduler_causing_task_execution_delays" {
  name       = "bottleneck_in_airflow_dag_scheduler_causing_task_execution_delays"
  data       = file("${path.module}/data/bottleneck_in_airflow_dag_scheduler_causing_task_execution_delays.json")
  depends_on = [shoreline_action.invoke_update_deployment_replicas]
}

resource "shoreline_file" "update_deployment_replicas" {
  name             = "update_deployment_replicas"
  input_file       = "${path.module}/data/update_deployment_replicas.sh"
  md5              = filemd5("${path.module}/data/update_deployment_replicas.sh")
  description      = "Increase the number of DAG Scheduler workers to distribute the workload and reduce the bottleneck."
  destination_path = "/tmp/update_deployment_replicas.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_deployment_replicas" {
  name        = "invoke_update_deployment_replicas"
  description = "Increase the number of DAG Scheduler workers to distribute the workload and reduce the bottleneck."
  command     = "`chmod +x /tmp/update_deployment_replicas.sh && /tmp/update_deployment_replicas.sh`"
  params      = ["YOUR_DEPLOYMENT_NAME","YOUR_NAMESPACE","NEW_NUMBER_OF_REPLICAS","NAMESPACE"]
  file_deps   = ["update_deployment_replicas"]
  enabled     = true
  depends_on  = [shoreline_file.update_deployment_replicas]
}

