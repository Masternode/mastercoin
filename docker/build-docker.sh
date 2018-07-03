#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

DOCKER_IMAGE=${DOCKER_IMAGE:-masternode/dashd-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/dashd docker/bin/
cp $BUILD_DIR/src/mastercoin-cli docker/bin/
cp $BUILD_DIR/src/mastercoin-tx docker/bin/
strip docker/bin/dashd
strip docker/bin/mastercoin-cli
strip docker/bin/mastercoin-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
