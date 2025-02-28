#!/bin/bash

echo "Starting the new Docker container..."

# Fetch DOCKER_TAG and DEPLOYMENT_NAME from SSM Parameter Store
DOCKER_TAG=$(aws ssm get-parameter --name "/myapp/DOCKER_TAG" --query "Parameter.Value" --output text)
DEPLOYMENT_NAME=$(aws ssm get-parameter --name "/myapp/DEPLOYMENT_NAME" --query "Parameter.Value" --output text)
DOCKER_HUB_REPO=$(aws ssm get-parameter --name "/myapp/DOCKER_HUB_REPO" --query "Parameter.Value" --output text)

source /tmp/deployment_variables.txt
RANDOM_PORT=$(shuf -i 1024-65535 -n 1)

docker run -d -p $RANDOM_PORT:8501 --name $DEPLOYMENT_NAME $DOCKER_HUB_REPO:$DOCKER_TAG

#docker run -d -p 4563:8501 --name divi divijeshhub/pikube:development-v1
echo "Docker container started on port $RANDOM_PORT."
