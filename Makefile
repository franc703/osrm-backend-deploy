.PHONY: build run

build:
	docker build -t my-osrm-backend .

run:
	docker run -d -p 5000:5000 my-osrm-backend

deploy:
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 258567528781.dkr.ecr.us-east-2.amazonaws.com
	docker build -t fastapi-deploy .
	docker tag fastapi-deploy:latest 258567528781.dkr.ecr.us-east-2.amazonaws.com/fastapi-deploy:latest
	docker push 258567528781.dkr.ecr.us-east-2.amazonaws.com/fastapi-deploy:latest
all:
	build run deploy