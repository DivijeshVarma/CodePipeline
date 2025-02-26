#!/bin/bash

source /tmp/deployment_variables.txt

echo "Pulling the new Docker image from Docker Hub..."
docker pull $DOCKER_HUB_REPO:$DOCKER_TAG

#docker pull divijeshhub/pikube:development-v1
echo "New Docker image pulled successfully!"

