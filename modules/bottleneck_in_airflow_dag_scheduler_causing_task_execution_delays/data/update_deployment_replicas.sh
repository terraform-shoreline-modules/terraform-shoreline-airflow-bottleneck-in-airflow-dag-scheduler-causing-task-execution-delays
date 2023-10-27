

#!/bin/bash



# Set the parameters

NAMESPACE=${YOUR_NAMESPACE}

DEPLOYMENT=${YOUR_DEPLOYMENT_NAME}

NEW_REPLICAS=${NEW_NUMBER_OF_REPLICAS}



# Update the deployment with the new number of replicas

kubectl scale deployment $DEPLOYMENT --namespace=$NAMESPACE --replicas=$NEW_REPLICAS