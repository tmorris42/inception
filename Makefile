CONFIG_PATH = ./srcs/docker-compose.yml 

.DEFAULT_GOAL := all

all:
#	docker build -t my_nginx_img -f srcs/requirements/nginx/Dockerfile srcs/requirements/nginx/
#	docker build -t my_mariadb_img -f srcs/requirements/mariadb/Dockerfile srcs/requirements/mariadb/
#	docker build -t my_wordpress -f srcs/requirements/wordpress/Dockerfile srcs/requirements/wordpress/
	docker-compose -f $(CONFIG_PATH) build
	docker-compose -f $(CONFIG_PATH) up -d

done:
	docker-compose -f $(CONFIG_PATH) down

re:
	$(MAKE) done
	$(MAKE) all

create_user:
	sudo usermod -aG docker $(USER)
	newgrp docker

.PHONY: all done re
