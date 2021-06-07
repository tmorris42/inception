service php7.3-fpm start
service php7.3-fpm stop

cp -r /tmp/html/wordpress /var/www/html/
cp /tmp/wp-config.php /var/www/html/wordpress/

# Set permissions
chmod +x /usr/local/bin/wp

# Verify that mysql is up and running
while ! mysqladmin ping -h"mysql" --silent; do
	echo "Waiting for mysql connection..."
	sleep 1
done
echo "Connected."

# Install WordPress using non-root user
useradd -m subuser
chown -R subuser:subuser /var/www/html/
runuser -l subuser -c 'wp core install --url="localhost/wordpress/"  --title="tmorris Demo" --admin_user="admin" --admin_password="user42" --admin_email="example@example.com" --path=/var/www/html/wordpress/'

php-fpm7.3 -F -R

