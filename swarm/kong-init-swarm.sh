#!/bin/sh
set -e

apk add --no-cache gettext

# No Swarm, secrets ficam em /run/secrets/<nome>
export KONG_ADMIN_USER=$(cat /run/secrets/kong_admin_user)
export KONG_ADMIN_PASSWORD=$(cat /run/secrets/kong_admin_password)

envsubst '${KONG_ADMIN_USER} ${KONG_ADMIN_PASSWORD}' \
  < /tmp/kong-template.yml \
  > /var/lib/kong/kong.yml

echo "kong.yml gerado com sucesso!"
cat /var/lib/kong/kong.yml
