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
useradd -m wpuser
chown -R wpuser:wpuser /var/www/html/
runuser -p wpuser -c 'wp core install --url="tmorris.42.fr"  --title="tmorris Demo" --admin_user=$WP_ADMIN_USERNAME --admin_password=$WP_ADMIN_PASSWORD --admin_email="example@example.com" --skip-email --path=/var/www/html/wordpress/'
runuser -p wpuser -c 'wp user create $WP_SECOND_USER $WP_SECOND_USER_EMAIL --user_pass=$WP_SECOND_USER_PASSWORD --role=author --path=/var/www/html/wordpress/'

exec php-fpm7.3 -F -R

