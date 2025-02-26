#!/bin/bash

echo "Validating the deployed service..."

source /tmp/deployment_variables.txt

# Check if the container is running
docker ps --filter "name=$DEPLOYMENT_NAME" --format "{{.ID}}"
if [ $? -eq 0 ]; then
    echo "Application deployed successfully and is running!"
else
    echo "Deployment failed or application is not running."
    exit 1
fi
