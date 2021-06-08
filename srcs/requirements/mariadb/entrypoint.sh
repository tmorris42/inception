service mysql start;
DB_EXISTS=`mysql -Be "show databases;" | grep "$WORDPRESS_DB_NAME" | wc -l`;
if [ "$DB_EXISTS" = "0" ]; then
	mysql -e "CREATE DATABASE $WORDPRESS_DB_NAME;";
fi
USER_EXISTS=`mysql -Be "SELECT user FROM mysql.user;" | grep "$WORDPRESS_DB_USER" | wc -l`;
if [ "$USER_EXISTS" = "0" ]; then
	mysql -e "CREATE USER '$WORDPRESS_DB_USER'@'srcs_wordpress_1.srcs_backend' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';";
	mysql -e "GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME . * TO  '$WORDPRESS_DB_USER'@'srcs_wordpress_1.srcs_backend' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';";
	mysql -e "FLUSH PRIVILEGES;";
fi
service mysql stop;

exec mysqld;
