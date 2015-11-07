#!/bin/bash
set -e -o pipefail

SCRIPTDIR=$(cd -P $(dirname $0); pwd)

DOCKERFILE=${SCRIPTDIR}/docker-compose-dev.yml
docker-compose -f $DOCKERFILE stop
docker-compose -f $DOCKERFILE rm -f
docker-compose -f $DOCKERFILE up -d

sleep 4

DBPORT=$(docker inspect -f '{{index .NetworkSettings.Ports "5432/tcp" 0 "HostPort"}}' backend_dev-db_1)
DBHOST=$(docker-machine ip $(docker-machine active))

source $SCRIPTDIR/development.env
export DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${DBHOST}:${DBPORT}/${POSTGRES_USER}

mix ecto.setup
