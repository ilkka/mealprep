#!/bin/bash
set -e -o pipefail

SCRIPTDIR=$(cd -P $(dirname $0); pwd)

docker-compose -f ${SCRIPTDIR}/docker-compose-dev.yml up -d
DBPORT=$(docker inspect -f '{{index .NetworkSettings.Ports "5432/tcp" 0 "HostPort"}}' backend_db_1)
DBHOST=$(docker-machine ip $(docker-machine active))

source $SCRIPTDIR/development.env
export DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${DBHOST}:${DBPORT}/${POSTGRES_USER}

mix ecto.create
mix ecto.migrate
iex -S mix phoenix.server
