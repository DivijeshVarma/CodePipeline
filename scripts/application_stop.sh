#!/bin/bash

echo "Stopping the Docker container..."
docker ps -a --filter "name=$DEPLOYMENT_NAME" --format "{{.ID}}" | xargs -r docker stop
docker ps -a --filter "name=$DEPLOYMENT_NAME" --format "{{.ID}}" | xargs -r docker rm

echo "Docker container stopped and removed."

