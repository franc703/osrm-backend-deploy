# Open Source Routing Machine (OSRM) Backend Deployment

This repository contains the necessary files to deploy an OSRM-backend server using Docker and AWS. The OSRM-backend server is configured to use map data for Minnesota.

## Contents

- **Dockerfile**: This Dockerfile sets up an OSRM-backend server using the map data for Minnesota. It downloads the map data, prepares it for routing, and starts the OSRM-backend server.

- **Makefile**: This Makefile automates the process of building and running the Docker container. It includes tasks for building the Docker image (`make build`) and running the Docker container (`make run`).

## Deployment

To deploy this project, clone the repository, build the Docker image with `make build`, and run the Docker container with `make run`. You can deploy the Docker container on AWS using services like Amazon Elastic Container Service (ECS) or Amazon Elastic Kubernetes Service (EKS).

## Scaling

To handle more requests, you can scale your service by running more tasks in your ECS cluster or use an Application Load Balancer to distribute traffic to multiple tasks.



