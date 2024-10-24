#!/bin/sh

# reference : yoba system(https://github.com/yobasystems)
# mkdir -p /run/mysqld
# chown -R mysql:mysql /run/mysqld

# chown -R mysql:mysql /var/lib/mysql
# mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

mysql_init=mysql_init.sql
cat << EOF > $mysql_init
ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD("$MYSQL_ROOT_PASSWORD");
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

wp_user_create=wp_user_create.sql
cat << EOF > $wp_user_create
create database wordpress;
create user '$MYSQL_USER'@'%' identified by '$MYSQL_PASSWORD';
GRANT ALL ON wordpress.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# rc pid 실행을 수행한다.
openrc default

# datadir에 기본 셋업을 진행한다.
/etc/init.d/mariadb setup

# SQL 쿼리문을 넣기위해 잠시 실행한다.
rc-service mariadb start

# wordpress database 생성 SQL문
mysql -u root < $wp_user_create

# mysql_secure_installation 설정이 담긴 sql쿼리문
mysql -u root < $mysql_init

rc-service mariadb stop

# ForeGround로 실행한다.
/usr/bin/mysqld_safe

# USE mysql;
# GRANT ALL ON *.* TO '$MYSQL_USER'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
# SET PASSWORD FOR '$MYSQL_USER'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
# CREATE DATABASE $MYSQL_DATABASE ;
# FLUSH PRIVILEGES ;

# /usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $mysql_init

# # rm -f tmpfile

# exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@