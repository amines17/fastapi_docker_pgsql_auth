#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install it to continue."
    exit
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null
then
    echo "Docker Compose is not installed. Please install it to continue."
    exit
fi

# Display running containers for debugging
echo "Running containers :"
docker-compose ps

# Get the backend container name using docker ps
CONTAINER_NAME=$(docker ps --filter "name=_web_1" --format "{{.ID}}")

# Display the name of the container retrieved for debugging
echo "Name of recovered container : '$CONTAINER_NAME'"

if [ -z "$CONTAINER_NAME" ]; then
    echo "The backend container is not running. Please start the services with 'docker-compose up'."
    exit
fi

# Access the backend container console
docker exec -it "$CONTAINER_NAME" /bin/sh
