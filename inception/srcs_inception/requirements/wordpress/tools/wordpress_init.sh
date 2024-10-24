#!/bin/sh

mv /app/wordpress/* /var/www/html
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

while ! mariadb-admin ping -h $DB_HOST --user=$MYSQL_USER --password=$MYSQL_PASSWORD --silent ;
	do sleep 1;
done;

sleep 10

while ! mariadb-admin ping -h $DB_HOST --user=$MYSQL_USER --password=$MYSQL_PASSWORD --silent ;
	do sleep 1;
done;
cd /var/www/html
wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$DB_HOST --allow-root
wp config set WP_DEBUG true --raw --allow-root
wp config set WP_DEBUG_LOG true --raw --allow-root
wp config set WP_REDIS_HOST redis --allow-root
# wp config set WP_REDIS_DATABASE 0 --allow-root
# wp config set WP_CACHE_KEY_SALT hyungjuk.42.fr --allow-root
# wp config set WP_REDIS_MAXTTL 86400 --allow-root
wp config set WP_CACHE true --raw --allow-root
# wp plugin activate php-mysqli --allow-root
wp core install --url=hyungjuk.42.fr --title=$MYSQL_USER --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
wp user create $WP_USER $WP_EMAIL --role=subscriber --user_pass=$WP_PASSWORD
wp plugin install redis-cache --activate --allow-root
wp redis enable
php-fpm81 -F
