FROM almalinux:minimal

ARG USERNAME=mysql_test
ARG GROUPNAME=mysql_test
ARG UID=1356
ARG GID=1356
RUN groupadd -g $GID $GROUPNAME && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
COPY ./mysql.repo /etc/yum.repos.d/mysql.repo
RUN microdnf -y install  mysql-community-server expect
COPY ./bbb.sh /
COPY ./user_add.sql /
COPY ./conf.d/pass.cnf /etc/conf.d/
RUN chmod +x ./bbb.sh
RUN chmod +x ./user_add.sql
RUN mkdir -p /var/log/mysql
VOLUME /var/lib/mysql
RUN chown -hR mysql_test:mysql_test /var/log/mysql
RUN chmod -R 777 /var/lib/mysql
RUN chown -hR mysql_test:mysql_test /run/mysqld
RUN --mount=type=secret,id=secret \
 SECRET=$(cat /run/secrets/secret) \
 && ./bbb.sh "$SECRET" > /dev/null 2>&1
 USER mysql_test
CMD ["mysqld"]
