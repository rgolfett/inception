FROM alpine:3.21

RUN apk update \
&& apk add nginx="1.26.3-r0"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx","-g","daemon off;"]