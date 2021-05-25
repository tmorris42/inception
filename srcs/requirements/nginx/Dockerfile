# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tmorris <tmorris@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/13 16:53:08 by tmorris           #+#    #+#              #
#    Updated: 2021/05/24 17:07:00 by tmorris          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y -q \
	nginx \
	openssl \
	wget

# Create SSL Certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=tmorris.42.fr"

# Copy necessary site files
COPY ./conf /etc/nginx/sites-available/tmorris
RUN ln -s /etc/nginx/sites-available/tmorris /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default

# DEBUGGING ONLY
RUN echo "<?php phpinfo(); ?>" > /var/www/html/test.php

# Expose ports and set autoindex to on by default
EXPOSE 443
ENV AUTOINDEX=on
CMD nginx -g "daemon off;"
