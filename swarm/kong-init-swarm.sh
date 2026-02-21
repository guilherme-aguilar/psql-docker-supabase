#!/bin/sh
set -e

apk add --no-cache gettext

# Debug: mostra se as variáveis chegaram
echo "KONG_ADMIN_USER=${KONG_ADMIN_USER}"
echo "KONG_ADMIN_PASSWORD=${KONG_ADMIN_PASSWORD}"

if [ -z "$KONG_ADMIN_USER" ] || [ -z "$KONG_ADMIN_PASSWORD" ]; then
  echo "ERRO: KONG_ADMIN_USER ou KONG_ADMIN_PASSWORD não definidos!"
  exit 1
fi

envsubst '${KONG_ADMIN_USER} ${KONG_ADMIN_PASSWORD}' \
  < /tmp/kong-template.yml \
  > /var/lib/kong/kong.yml

echo "kong.yml gerado com sucesso!"
cat /var/lib/kong/kong.yml