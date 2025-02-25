NAME = inception
# This flag is used in the context of specifying a particular file to be used by a command. In Makefiles, the -f flag is commonly associated with commands that need to reference a specific file for their operations
all:
	@mkdir -p /home/$(USER)/data/frontend
	@mkdir -p /home/$(USER)/data/backend
	@docker compose -f ./srcs/docker-compose.yml up -d

down:
	@docker compose -f ./srcs/docker-compose.yml down

start:
	@docker compose -f ./srcs/docker-compose.yml start
# Stops running containers without removing them. They can be started again with docker compose start.
stop:
	@docker compose -f ./srcs/docker-compose.yml stop

# v flag stands for "volumes." When this flag is used, Docker Compose will also remove the named volumes declared in the `volumes` section of the Compose file and any anonymous volumes attached to containers. This ensures that all data stored in volumes is cleaned up.
# --remove-orphans: This option tells Docker Compose to remove containers that were created by a previous `docker-compose up` but are not defined in the current Compose file. This helps in cleaning up any leftover containers that are no longer needed.
# 	docker-compose -p $(NAME) -f srcs/docker-compose.yml down -v --remove-orphans

clean: down
	@sudo rm -rf /home/$(USER)/data
	@docker system prune -a -f


re: clean all

.PHONY: all down clean re stop start

# delete all volumes
# docker volume rm $(docker volume ls -q)





