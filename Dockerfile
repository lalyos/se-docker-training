FROM alpine

RUN apk add -U nginx
RUN apk add curl
CMD nginx -g "daemon off;"
