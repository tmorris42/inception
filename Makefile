CONFIG_PATH = ./srcs/docker-compose.yml 

.DEFAULT_GOAL := all

all:
	docker-compose -p"inception" -f $(CONFIG_PATH) build
	docker-compose -p"inception" -f $(CONFIG_PATH) up -d

done:
	docker-compose -p"inception" -f $(CONFIG_PATH) down

fclean: done
	docker volume rm inception_mariadb-db inception_wordpress-files
	sudo rm -rf /home/tmorris/data/mariadb-db
	sudo rm -rf /home/tmorris/data/wordpress-files
	sudo mkdir /home/tmorris/data/mariadb-db
	sudo mkdir /home/tmorris/data/wordpress-files
	docker image rm wordpress mariadb nginx

re: fclean
	$(MAKE) all

create_user:
	sudo usermod -aG docker $(USER)
	newgrp docker

.PHONY: all done re
