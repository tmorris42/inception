# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tmorris <tmorris@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/13 16:53:08 by tmorris           #+#    #+#              #
#    Updated: 2021/05/20 15:41:15 by tmorris          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y -q \
	mariadb-client \
	mariadb-server

WORKDIR /tmp/
COPY . .
RUN cp ./50-server.cnf /etc/mysql/mariadb.conf.d/

# Expose ports and set autoindex
EXPOSE 3306
CMD ["bash", "entrypoint.sh"]
