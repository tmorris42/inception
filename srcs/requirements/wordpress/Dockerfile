# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tmorris <tmorris@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/13 16:53:08 by tmorris           #+#    #+#              #
#    Updated: 2021/05/26 20:21:23 by tmorris          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y -q \
	mariadb-client \
	mariadb-server \
	php \
	php-cgi \
	php-fpm \
	php-gd \
	php-gettext \
	php-mysql \
	php-mbstring \
	php-pear \
	php-xml \
	php-zip \
	wget

# Download extra packages (phpmyadmin, WordPress, wp-cli)
WORKDIR /tmp/
RUN wget -q http://wordpress.org/latest.tar.gz
RUN wget -q -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Unpack WordPress
RUN mkdir html
RUN tar xzf latest.tar.gz -C ./html/

COPY ./srcs/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./srcs/wp-config.php ./
COPY ./srcs/setup.sh ./

# Expose ports and set autoindex to on by default
EXPOSE 9000
ENTRYPOINT ["bash", "setup.sh"]
