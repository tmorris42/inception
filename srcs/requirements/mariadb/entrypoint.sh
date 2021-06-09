# Create directory for mysqld .pid and .sock files
mkdir -m 777 /var/run/mysqld

# Create instructions to create new database and user if necessary
echo "CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;" > /tmp/init.sql
chmod 755 /tmp/init.sql
echo "CREATE USER IF NOT EXISTS '$WORDPRESS_DB_USER'@'wordpress.inception_backend' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';" >> /tmp/init.sql
echo "GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME . * TO  '$WORDPRESS_DB_USER'@'wordpress.inception_backend' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';" >> init.sql
echo "FLUSH PRIVILEGES;" >> init.sql

# Start mysqld
exec mysqld --init-file=/tmp/init.sql;
