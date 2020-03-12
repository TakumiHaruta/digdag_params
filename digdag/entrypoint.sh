#!/usr/bin/env bash
set -e

set -a && source /etc/digdag/env && set +a
# rendering server.properties
envsubst < /etc/digdag/server.properties >> /etc/digdag/server.fmt
cat /etc/digdag/server.fmt > /etc/digdag/server.properties

# rendering pgpass file
echo "$POSTGRES_HOST:$POSTGRES_PORT:$POSTGRES_DB:$POSTGRES_USER:$POSTGRES_PASSWORD" > ~/.pgpass
chmod 600 ~/.pgpass

cp /etc/digdag/server.properties /output/
cp /etc/digdag/env /output/
cp ~/.pgpass /output/

# wait for postgresup
until psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -p "$POSTGRES_PORT" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 10
done

>&2 echo "Postgres is up - executing command"

exec "$@"