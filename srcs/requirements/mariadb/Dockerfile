FROM debian:bullseye-slim


RUN	apt-get update 
RUN	apt-get install -y mariadb-server mariadb-client

COPY ./conf/my.cnf /etc/mysql/my.cnf
RUN chmod +x /etc/mysql/my.cnf


# test run in shell is ok can change to Dockerfile but for easy to read I keep it in shell
# RUN mkdir -p /run/mysqld /var/lib/mysql /var/log/mysql
# RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql
# RUN chmod +x /var/log/mysql/

# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/setup.sh"]

# Command launched at the end of the setup
CMD ["/usr/bin/mysqld_safe", "--datadir=/var/lib/mysql"]