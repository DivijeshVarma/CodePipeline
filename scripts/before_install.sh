#!/bin/bash

echo "Stopping old Docker container if running..."
docker ps -a --filter "name=$DEPLOYMENT_NAME" --format "{{.ID}}" | xargs -r docker stop
docker ps -a --filter "name=$DEPLOYMENT_NAME" --format "{{.ID}}" | xargs -r docker rm

echo "Clean up old resources if needed..."
# Add additional cleanup commands if necessary

