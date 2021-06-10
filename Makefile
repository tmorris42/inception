CONFIG_PATH = ./srcs/docker-compose.yml 
PROJECT_NAME = inception

all: build up

up:
	docker-compose -p"$(PROJECT_NAME)" -f $(CONFIG_PATH) up -d

build:
	docker-compose -p"$(PROJECT_NAME)" -f $(CONFIG_PATH) build

down:
	docker-compose -p"$(PROJECT_NAME)" -f $(CONFIG_PATH) down

fclean: down
	docker volume rm inception_mariadb-db inception_wordpress-files
	sudo rm -rf /home/tmorris/data/mariadb-db
	sudo rm -rf /home/tmorris/data/wordpress-files
	sudo mkdir /home/tmorris/data/mariadb-db
	sudo mkdir /home/tmorris/data/wordpress-files
	docker image rm wordpress mariadb nginx

re: fclean
	$(MAKE) all

prepare_volumes:
	sudo mkdir -p /home/tmorris/data/mariadb-db
	sudo mkdir -p /home/tmorris/data/wordpress-files

create_user:
	sudo usermod -aG docker $(USER)
	newgrp docker

.PHONY: all done re
