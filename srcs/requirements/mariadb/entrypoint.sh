service mysql start;
USER_EXISTS=`mysql -Be "SELECT user FROM mysql.user;" | grep "$MYSQL_USER" | wc -l`;
if [ "$USER_EXISTS" = "0" ]; then
	mysql -e "CREATE USER '$MYSQL_USER'@'srcs_wordpress_1.srcs_default' IDENTIFIED BY '$MYSQL_PASSWORD';";
	mysql -e "GRANT ALL PRIVILEGES ON * . * TO  '$MYSQL_USER'@'srcs_wordpress_1.srcs_default' IDENTIFIED BY '$MYSQL_PASSWORD';";
	mysql -e "FLUSH PRIVILEGES;";
fi
DB_EXISTS=`mysql -Be "show databases;" | grep "$MYSQL_DATABASE" | wc -l`;
if [ "$DB_EXISTS" = "0" ]; then
	mysql -u $MYSQL_USER --password="$MYSQL_PASSWORD" -e "CREATE DATABASE $MYSQL_DATABASE;";
fi
mysqld;
