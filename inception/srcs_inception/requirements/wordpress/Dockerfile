FROM alpine:3.18

WORKDIR /app

RUN apk --no-cache update && apk --no-cache add php-fpm curl php81 php81-curl php81-ctype \
												php81-phar php81-fpm php81-mysqli \
												php81-iconv php81-tokenizer mariadb-client fcgi \
												php81-redis

RUN wget https://wordpress.org/latest.tar.gz \	
	&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& tar -xzvf latest.tar.gz \
	&& rm latest.tar.gz

COPY ./conf/php.ini /etc/php81/

COPY ./conf/www.conf /etc/php81/php-fpm.d

COPY ./tools/wordpress_init.sh /app

CMD [ "/app/wordpress_init.sh" ]
