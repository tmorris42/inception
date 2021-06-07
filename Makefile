CONFIG_PATH = ./srcs/docker-compose.yml 

.DEFAULT_GOAL := all

all:
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
