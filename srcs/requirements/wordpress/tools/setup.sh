#!/bin/sh

mkdir -p /run/php
mkdir -p /var/www/html 
chown -R www-data:www-data /var/www/html/

if [ ! -d "/usr/local/bin/wp" ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
fi


if [ -f "/var/www/html/wordpress/wp-config.php" ]; then
    echo "you already installed wordpress."
else
    chown -R www-data:www-data /var/www/html/
    cd /var/www/html

    wp core download --allow-root

    wp config create	--dbname=${MYSQL_DATABASE_WP} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} \
                        --dbhost=mariadb --allow-root

    wp core install		--url=mwu.42.fr --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} \
                        --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root

    wp user create 		${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=author --allow-root

    wp theme install "ashe" --activate --allow-root
fi;

exec "$@"

