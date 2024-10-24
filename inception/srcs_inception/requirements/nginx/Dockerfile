FROM alpine:3.18

RUN apk --no-cache update && apk --no-cache add nginx openssl openrc && rm -f /var/cache/apk/*

# Generate SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

COPY ./conf/default.conf /etc/nginx/http.d

CMD [ "nginx", "-g", "daemon off;" ]