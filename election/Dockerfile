FROM alpine

RUN apk add -U nginx
RUN apk add curl bash

ADD start.sh /bin/

ENV COLOR lightblue
ENV PRESIDENT nobody

EXPOSE 80
CMD /bin/start.sh
