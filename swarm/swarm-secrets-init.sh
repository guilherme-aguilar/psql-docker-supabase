#!/bin/sh
# Execute este script UMA VEZ no nó manager para criar os secrets no Swarm
# Uso: sh swarm-secrets-init.sh

set -e

# Carrega o .env
if [ ! -f .env ]; then
  echo "Erro: arquivo .env não encontrado!"
  exit 1
fi
export $(grep -v '^#' .env | xargs)

# Cria cada secret no Swarm (falha silenciosamente se já existir)
create_secret() {
  NAME=$1
  VALUE=$2
  echo "$VALUE" | docker secret create "$NAME" - 2>/dev/null && \
    echo "✔ Secret '$NAME' criado" || \
    echo "⚠ Secret '$NAME' já existe, pulando"
}

create_secret postgres_password     "$POSTGRES_PASSWORD"
create_secret jwt_secret            "$JWT_SECRET"
create_secret anon_key              "$ANON_KEY"
create_secret service_role_key      "$SERVICE_ROLE_KEY"
create_secret secret_key_base       "$SECRET_KEY_BASE"
create_secret vault_enc_key         "$VAULT_ENC_KEY"
create_secret kong_admin_user       "$KONG_ADMIN_USER"
create_secret kong_admin_password   "$KONG_ADMIN_PASSWORD"
create_secret supavisor_database_url "ecto://supabase_admin:${POSTGRES_PASSWORD}@db:5432/postgres"

echo ""
echo "Secrets criados! Agora suba a stack com:"
echo "  docker stack deploy -c docker-stack.yml supabase"
