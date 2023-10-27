
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Bottleneck in Airflow DAG Scheduler Causing Task Execution Delays
---

This incident type refers to a bottleneck within the Apache Airflow DAG (Directed Acyclic Graph) Scheduler that causes delays in task execution. Apache Airflow is an open-source platform used to programmatically author, schedule, and monitor workflows. The DAG Scheduler is responsible for scheduling tasks based on their dependencies and availability of resources. When a bottleneck occurs within this component, it leads to delays in task executions, which can impact the overall workflow and potentially cause failures. This type of incident requires investigation and resolution to ensure optimal performance and reliability of the Apache Airflow platform.

### Parameters
```shell
export DAG_SCHEDULER_POD_NAME="PLACEHOLDER"

export OTHER_POD_IP="PLACEHOLDER"

export YOUR_DEPLOYMENT_NAME="PLACEHOLDER"

export YOUR_NAMESPACE="PLACEHOLDER"

export NEW_NUMBER_OF_REPLICAS="PLACEHOLDER"
```

## Debug

### List all Apache Airflow Pods running in the cluster
```shell
kubectl get pods -l app=airflow
```

### Check the logs of the DAG Scheduler Pod
```shell
kubectl logs ${DAG_SCHEDULER_POD_NAME}
```

### Check the resource usage of the DAG Scheduler Pod
```shell
kubectl top pod ${DAG_SCHEDULER_POD_NAME}
```

### Check the status of the Kubernetes Nodes
```shell
kubectl get nodes
```

### Check the resource usage of the Kubernetes Nodes
```shell
kubectl top node
```

### Check the CPU and memory limits set for the DAG Scheduler Pod
```shell
kubectl describe pod ${DAG_SCHEDULER_POD_NAME} | grep -E "(Limits|Requests)"
```

### Check the CPU and memory usage of the DAG Scheduler Pod over time
```shell
kubectl top pod ${DAG_SCHEDULER_POD_NAME} --containers
```

### Check the network connectivity between the DAG Scheduler Pod and other Pods
```shell
kubectl exec ${DAG_SCHEDULER_POD_NAME} -- ping ${OTHER_POD_IP}
```

### Check the Kubernetes events related to the DAG Scheduler Pod
```shell
kubectl get events --field-selector involvedObject.name=${DAG_SCHEDULER_POD_NAME}
```

## Repair

### Increase the number of DAG Scheduler workers to distribute the workload and reduce the bottleneck.
```shell


#!/bin/bash



# Set the parameters

NAMESPACE=${YOUR_NAMESPACE}

DEPLOYMENT=${YOUR_DEPLOYMENT_NAME}

NEW_REPLICAS=${NEW_NUMBER_OF_REPLICAS}



# Update the deployment with the new number of replicas

kubectl scale deployment $DEPLOYMENT --namespace=$NAMESPACE --replicas=$NEW_REPLICAS


```