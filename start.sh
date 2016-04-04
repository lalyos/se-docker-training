#!/bin/bash

echo "${PRESIDENT} for president" > /usr/share/nginx/html/index.html
nginx -g "daemon off;"
