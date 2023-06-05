.PHONY: build run

build:
	docker build -t my-osrm-backend .

run:
	docker run -d -p 5000:5000 my-osrm-backend

deploy:
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin YOUR_ECR_REGISTRY_URI
	docker build -t osrm-backend .
	docker tag osrm-backend:latest YOUR_ECR_REGISTRY_URI/osrm-backend:latest
	docker push YOUR_ECR_REGISTRY_URI/osrm-backend:latest

all:
	build run deploy