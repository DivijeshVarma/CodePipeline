#!/bin/bash

echo "Pulling the new Docker image from Docker Hub..."
docker pull $DOCKER_HUB_REPO:$DOCKER_TAG

echo "New Docker image pulled successfully!"

