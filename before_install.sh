#!/bin/bash

source /tmp/deployment_variables.txt

# Fetch DOCKER_TAG and DEPLOYMENT_NAME from SSM Parameter Store
DEPLOYMENT_NAME=$(aws ssm get-parameter --name "/myapp/DEPLOYMENT_NAME" --query "Parameter.Value" --output text)


echo "Stopping old Docker container if running..."
docker ps -a --filter "name=$DEPLOYMENT_NAME" --format "{{.ID}}" | xargs -r docker stop
docker ps -a --filter "name=$DEPLOYMENT_NAME" --format "{{.ID}}" | xargs -r docker rm

echo "Clean up old resources if needed..."
# Add additional cleanup commands if necessary

