FROM alpine

RUN apk add -U nginx
RUN apk add curl
RUN echo 'lalyos for president' > /usr/share/nginx/html/index.html
CMD nginx -g "daemon off;"
