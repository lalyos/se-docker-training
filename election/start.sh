#!/bin/bash


cat > /usr/share/nginx/html/index.html <<EOF
<html>
<body bgcolor="${COLOR:=gray}">
<h1>${PRESIDENT:=nobody} for president !</h1>
${CUSTOM_BODY}
</body>
</html>
EOF

nginx -g "daemon off;"
