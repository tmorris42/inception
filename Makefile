CONFIG_PATH = ./srcs/docker-compose.yml
PROJECT_NAME = inception
MARIA_VOLUME = /home/tmorris/data/mariadb-db
WORDPRESS_VOLUME = /home/tmorris/data/wordpress-files

all: build up

up:
	docker-compose -p"$(PROJECT_NAME)" -f $(CONFIG_PATH) up -d

build: $(MARIA_VOLUME) $(WORDPRESS_VOLUME)
	docker-compose -p"$(PROJECT_NAME)" -f $(CONFIG_PATH) build

down:
	docker-compose -p"$(PROJECT_NAME)" -f $(CONFIG_PATH) down

fclean: down
	docker volume rm inception_mariadb-db inception_wordpress-files
	sudo rm -rf $(MARIA_VOLUME)
	sudo rm -rf $(WORDPRESS_VOLUME)
	docker image rm wordpress mariadb nginx

re: fclean all

$(MARIA_VOLUME):
	sudo mkdir -m 777 -p $(MARIA_VOLUME)

$(WORDPRESS_VOLUME):
	sudo mkdir -m 777 -p $(WORDPRESS_VOLUME)

create_user:
	sudo usermod -aG docker $(USER)
	newgrp docker

.PHONY: all done re up down build fclean create_user
