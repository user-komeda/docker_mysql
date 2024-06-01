FROM almalinux:minimal

ARG USERNAME=mysql_test
ARG GROUPNAME=mysql_test
ARG UID=1356
ARG GID=1356
RUN groupadd -g $GID $GROUPNAME && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME


ENV PASSWORD=Anikosama@9219
RUN microdnf install -y  expect  mysql-server
COPY ./bbb.sh /
COPY ./user_add.sql /
COPY ./conf.d ./etc/mysql/conf.d
RUN chmod +x ./bbb.sh
RUN chmod +x ./user_add.sql
RUN mkdir -p /var/log/mysql
VOLUME /var/lib/mysql
RUN chown -hR mysql_test:mysql_test /var/log/mysql
RUN chown -hR mysql_test:mysql_test /var/lib/mysql
RUN chown -hR mysql_test:mysql_test /run/mysqld
USER mysql_test

ENTRYPOINT [ "./bbb.sh"]

