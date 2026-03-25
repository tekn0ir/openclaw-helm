#!/bin/bash

# Exit on error
set -e

# Default image name
IMAGE_NAME="tekn0ir/openclaw"

# Version from Chart.yaml
CHART_VERSION=$(grep '^version:' charts/openclaw/Chart.yaml | awk '{print $2}')

# Build the image
echo "Building ${IMAGE_NAME}:latest and ${IMAGE_NAME}:${CHART_VERSION}..."
docker build -t "${IMAGE_NAME}:latest" -t "${IMAGE_NAME}:${CHART_VERSION}" .

# Push the images
echo "Pushing ${IMAGE_NAME}:latest..."
docker push "${IMAGE_NAME}:latest"

echo "Pushing ${IMAGE_NAME}:${CHART_VERSION}..."
docker push "${IMAGE_NAME}:${CHART_VERSION}"

echo "Build and push completed successfully."
