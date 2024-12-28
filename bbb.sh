#!/bin/bash -eu
chown -hR mysql_test:mysql_test /var/lib/mysql
chmod 777 -R /var/lib/mysql
chmod 777 /var/log/mysqld.log
mysqld --initialize-insecure --user=mysql_test
chmod -R 777 /var/run/mysqld

sleep 10s
echo "ALTER USER 'root'@'localhost' identified BY '${1}'"; >> user_add.sql
/usr/sbin/mysqld --user=mysql_test &
sleep 10s
mysql -u root < ./user_add.sql
#exec "$@"
