service mysql start
service php7.3-fpm start

# Set permissions
chown www-data:www-data /var/www/tmorris/html/phpmyadmin/tmp
chmod 700 /var/www/tmorris/html/phpmyadmin/tmp
chmod +x /usr/local/bin/wp

# Link new nginx config and remove default config
ln -s /etc/nginx/sites-available/tmorris /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

# Setup MYSQL User and DB
mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'user42';"
mysql -e "GRANT ALL PRIVILEGES ON * . * TO 'admin'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
mysql -u admin --password="user42" -e "CREATE DATABASE wordpress;"

# Check autoindex
if [ $AUTOINDEX = off ]
then
	sed -i 's/autoindex on/autoindex off/g' /etc/nginx/sites-available/tmorris
	sed -i 's/ON/OFF/g' /var/www/tmorris/html/index.html
else
	sed -i 's/autoindex off/autoindex on/g' /etc/nginx/sites-available/tmorris
	sed -i 's/OFF/ON/g' /var/www/tmorris/html/index.html
fi

# Install WordPress using non-root user
useradd -m subuser
chown -R subuser:subuser /var/www/tmorris/html/wordpress
runuser -l subuser -c 'wp core install --url="localhost/wordpress/"  --title="tmorris Demo" --admin_user="admin" --admin_password="user42" --admin_email="example@example.com" --path=/var/www/tmorris/html/wordpress'

nginx -g "daemon off;"
