#!/bin/sh

mkdir -p /run/mysqld /var/lib/mysql /var/log/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql
chmod +x /var/log/mysql/

mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db


if [ ! -d "/var/lib/mysql/wpmysql" ]; then

    # These commands are crucial for initializing and starting the MySQL server.
    # This command initializes the MySQL data directory (/var/lib/mysql) 
    # without setting a root password (--initialize-insecure). 
    # The --user=mysql option specifies that the initialization process 
    # should be run under the mysql user account. This step is necessary 
    # to prepare the data directory for the MySQL server to store its databases 
    # and related files.
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
    # command starts the MySQL server daemon (mysqld) using the specified data 
    # directory (--datadir=/var/lib/mysql) and running under the mysql user 
    # account (--user=mysql). The & at the end of the command runs the mysqld 
    # process in the background, allowing the script to continue executing 
    # subsequent commands without waiting for the MySQL server to terminate. 
    # The sleep 2 command pauses the script for 2 seconds to allow the MySQL
    mysqld --datadir=/var/lib/mysql --user=mysql & sleep 2


    mysql -u root <<EOF
        
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE_WP};
        
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        
        DELETE FROM mysql.user WHERE user='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        DELETE FROM mysql.user WHERE user='';
        
        CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_WP}.* TO '${MYSQL_USER}'@'%';
        
        FLUSH PRIVILEGES;
EOF
    # The provided line of code is a commented-out command that would terminate all
    # running instances of the mysqld process if it were uncommented.
    # The killall command is used to send a signal to all processes running a specified command, in this case, mysqld, which is the MySQL server daemon.
    killall mysqld 
fi

# When exec "$@" is executed, the current shell process is replaced by the command specified in the arguments. This means that the script will no longer continue to execute any subsequent commands after exec "$@", as the current process is replaced by the new process.

# This is often used at the end of a script to pass control to another command or program, ensuring that the new command runs in the same process, which can be useful for resource management and signal handling. For example, in a Docker entrypoint script, it allows the container to run the specified command as the main process.
exec "$@"



# this can be new version but wihout condition checek 
# it will be run every time the container is started
# it will cost some time to run this script
# but it seems be more reliable but cost more time

# service mysql start

# mysql -v -u root << EOF
# CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE_WP};
        
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        
# DELETE FROM mysql.user WHERE user='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# DELETE FROM mysql.user WHERE user='';
        
# CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_WP}.* TO '${MYSQL_USER}'@'%';
        
# FLUSH PRIVILEGES;

# sleep 5

# service mysql stop