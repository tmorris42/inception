FROM debian:buster
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y -q \
	nginx \
	openssl

# Create SSL Certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=tmorris.42.fr"

# Copy configuration file
COPY ./conf /etc/nginx/sites-available/tmorris
RUN ln -s /etc/nginx/sites-available/tmorris /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default

# Expose port
EXPOSE 443
ENTRYPOINT ["nginx", "-g", "daemon off;"]
