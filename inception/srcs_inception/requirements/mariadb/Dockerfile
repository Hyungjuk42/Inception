FROM alpine:3.18

WORKDIR /app

RUN apk update --no-cache && apk add --no-cache mariadb mariadb-client openrc \
	&& rm -f /var/cache/apk/* && mkdir -p /run/openrc/softlevel

RUN mkdir /run/mysqld && chown -R mysql /run/mysqld

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/mariadb_init.sh /app

CMD [ "/app/mariadb_init.sh" ]