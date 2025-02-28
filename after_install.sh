#!/bin/bash

# Fetch DOCKER_TAG and DEPLOYMENT_NAME from SSM Parameter Store
DOCKER_TAG=$(aws ssm get-parameter --name "/myapp/DOCKER_TAG" --query "Parameter.Value" --output text)
DOCKER_HUB_REPO=$(aws ssm get-parameter --name "/myapp/DOCKER_HUB_REPO" --query "Parameter.Value" --output text)

source /tmp/deployment_variables.txt

echo "Pulling the new Docker image from Docker Hub..."
docker pull $DOCKER_HUB_REPO:$DOCKER_TAG

#docker pull divijeshhub/pikube:development-v1
echo "New Docker image pulled successfully!"

