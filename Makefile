all: build up

build: generate
	docker-compose -f ./srcs/docker-compose.yml build

generate:
	bash ./srcs/requirements/tools/script.sh

up:
	docker-compose -f ./srcs/docker-compose.yml up

down: 
	docker-compose -f ./srcs/docker-compose.yml down

clear: down
	docker system prune -af
	docker volume rm `sudo docker volume ls -q`

.PHONY: all build generate up down