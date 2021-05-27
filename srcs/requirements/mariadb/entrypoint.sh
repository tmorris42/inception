service mysql start;
DB_EXISTS=`mysql -Be "show databases;" | grep "$MYSQL_DATABASE" | wc -l`;
if [ "$DB_EXISTS" = "0" ]; then
	mysql -e "CREATE DATABASE $MYSQL_DATABASE;";
fi
USER_EXISTS=`mysql -Be "SELECT user FROM mysql.user;" | grep "$MYSQL_USER" | wc -l`;
if [ "$USER_EXISTS" = "0" ]; then
	mysql -e "CREATE USER '$MYSQL_USER'@'srcs_wordpress_1.srcs_default' IDENTIFIED BY '$MYSQL_PASSWORD';";
	mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE . * TO  '$MYSQL_USER'@'srcs_wordpress_1.srcs_default' IDENTIFIED BY '$MYSQL_PASSWORD';";
	mysql -e "FLUSH PRIVILEGES;";
fi
service mysql stop;

exec mysqld;
