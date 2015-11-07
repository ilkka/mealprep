#!/bin/bash
set -e -o pipefail

SCRIPTDIR=$(cd -P $(dirname $0); pwd)
DOCKERFILE=${SCRIPTDIR}/docker-compose-test.yml

docker-compose -f $DOCKERFILE stop
docker-compose -f $DOCKERFILE rm -f
docker-compose -f $DOCKERFILE up -d

sleep 4

DBPORT=$(docker inspect -f '{{index .NetworkSettings.Ports "5432/tcp" 0 "HostPort"}}' backend_test-db_1)
DBHOST=$(docker-machine ip $(docker-machine active))

source $SCRIPTDIR/test.env
export DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${DBHOST}:${DBPORT}/${POSTGRES_USER}

mix ecto.create
mix ecto.migrate
mix test
