CONFIG_PATH = ./srcs/docker-compose.yml 

.DEFAULT_GOAL := all

all:
	docker-compose -f $(CONFIG_PATH) build
	docker-compose -f $(CONFIG_PATH) up -d

done:
	docker-compose -f $(CONFIG_PATH) down

fclean: done
	docker volume rm srcs_mariadb-db srcs_wp-test 
	docker image rm my_wordpress_img my_mariadb_img my_nginx_img

re: fclean
	$(MAKE) all

create_user:
	sudo usermod -aG docker $(USER)
	newgrp docker

.PHONY: all done re
