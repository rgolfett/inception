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
	@docker stop $$(docker ps -qa); \
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q);


.PHONY: all build generate up down