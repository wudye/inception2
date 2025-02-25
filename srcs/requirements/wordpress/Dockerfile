FROM debian:bullseye-slim

RUN	apt-get update && \
    apt-get install -y	\
    curl \
    mariadb-client \
    php7.4 \
    php7.4-fpm \
    php7.4-curl \
    php7.4-mysql \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    php7.4-gd \
    php7.4-imap \
    && sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/7.4/fpm/pool.d/www.conf


# if use sed command in before, we don't need to copy this file, it will use default file
# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# for dockerfile easy to read I keep this in shell
# RUN mkdir -p /run/php
# RUN	mkdir -p /var/www/html 
# The chown command is used to change the ownership of files and directories. The -R option stands for "recursive," meaning that the command will apply to all files and subdirectories within the specified director
# RUN	chown -R www-data:www-data /var/www/html/
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN chmod +x wp-cli.phar
# RUN mv wp-cli.phar /usr/local/bin/wp

# change the ownership of the /var/www/html directory to the www-data user and group
# the folder is /var/
# the old owner is www-d
# the new owner is www-data
# chown -R www-data:www-d /var/

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup.sh", "php-fpm7.4", "-F"]