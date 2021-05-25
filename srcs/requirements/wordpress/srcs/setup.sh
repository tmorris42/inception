service php7.3-fpm start
service php7.3-fpm stop

cp /tmp/html /var/www/

# Set permissions
#chown www-data:www-data /var/www/tmorris/html/phpmyadmin/tmp
#chmod 700 /var/www/tmorris/html/phpmyadmin/tmp
#chmod +x /usr/local/bin/wp

# Install WordPress using non-root user
#useradd -m subuser
#chown -R subuser:subuser /var/www/tmorris/html/wordpress
#runuser -l subuser -c 'wp core install --url="localhost/wordpress/"  --title="tmorris Demo" --admin_user="admin" --admin_password="user42" --admin_email="example@example.com" --path=/var/www/tmorris/html/wordpress'

php-fpm7.3 -F -R

