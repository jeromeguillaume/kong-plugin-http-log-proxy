#!/bin/bash

# Create DB
#docker run -d --name kong-database-http-log-proxy \
#  --network=kong-net \
#  -p 6432:6432 \
#  -e "POSTGRES_USER=kong" \
#  -e "POSTGRES_DB=kong" \
#  -e "POSTGRES_PASSWORD=kongpass" \
#  postgres:13

# Migrate DB
#docker run --rm --network=kong-net \
# -e "KONG_DATABASE=postgres" \
# -e "KONG_PG_HOST=kong-database-http-log-proxy" \
# -e "KONG_PG_PORT=5432" \
# -e "KONG_PG_PASSWORD=kongpass" \
# -e "KONG_PASSWORD=test" \
#kong/kong-gateway:3.3.1.0 kong migrations bootstrap

docker rm -f kong-gateway-http-log-proxy

docker run -d --name kong-gateway-http-log-proxy \
 --network=kong-net \
 --mount type=bind,source="$(pwd)"/kong/plugins/http-log-proxy,destination=/usr/local/share/lua/5.1/kong/plugins/http-log-proxy \
 -e "KONG_DATABASE=postgres" \
 -e "KONG_PG_HOST=kong-database-http-log-proxy" \
 -e "KONG_PG_PORT=5432" \
 -e "KONG_PG_USER=kong" \
 -e "KONG_PG_PASSWORD=kongpass" \
 -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
 -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
 -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
 -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
 -e "KONG_PROXY_LISTEN=0.0.0.0:11000" \
 -e "KONG_ADMIN_LISTEN=0.0.0.0:11001" \
 -e "KONG_ADMIN_GUI_LISTEN=0.0.0.0:11002" \
 -e "KONG_ADMIN_GUI_URL=http://localhost:11002" \
 -e "KONG_PLUGINS=bundled,http-log-proxy" \
 -e KONG_LICENSE_DATA \
 -p 11000:11000 \
 -p 11001:11001 \
 -p 11002:11002 \
 kong/kong-gateway:3.3.0.0

 echo 'docker logs -f kong-gateway-http-log-proxy'