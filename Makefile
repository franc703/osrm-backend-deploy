.PHONY: build run

build:
	docker build -t my-osrm-backend .

run:
	docker run -d -p 8080:8080 my-osrm-backend

deploy:
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 231050005521.dkr.ecr.us-east-2.amazonaws.com
	docker build -t osrm-access .
	docker tag osrm-access:latest 231050005521.dkr.ecr.us-east-2.amazonaws.com/osrm-access:latest
	docker push 231050005521.dkr.ecr.us-east-2.amazonaws.com/osrm-access:latest

all:
	build run deploy