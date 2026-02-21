#!/bin/sh
set -e
apk add --no-cache gettext
envsubst '${KONG_ADMIN_USER} ${KONG_ADMIN_PASSWORD}' < /tmp/kong-template.yml > /var/lib/kong/kong.yml
echo "kong.yml gerado com sucesso!"
cat /var/lib/kong/kong.yml
