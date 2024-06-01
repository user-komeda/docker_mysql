#!/bin/bash
rm -rf /var/lib/mysql/*
mysqld --initialize --user=mysql_test
IntPasswd=$(grep "A temporary password is generated for root@localhost:" /var/log/mysql/mysqld.log | awk '{ print $13}')

/usr/sbin/mysqld &
sleep 5s


expect -c '
    set timeout 10;
    spawn mysql_secure_installation -D;
    expect "Enter password for user root:";
    send -- "'"${IntPasswd}"'\n";
    expect "New password:";
    send -- "'"${PASSWORD}"'\n";
    expect "Re-enter new password:";
    send -- "'"${PASSWORD}"'\n";
    interact;'
#mysql -u root -p Anikosama@9219 < ./user_add.sql
mysql --defaults-extra-file=/etc/mysql/conf.d/pass.cnf  < ./user_add.sql

exec "$@"
