#!/bin/bash

NAME='nwipe-latest'
SRC_DIR='/root/nwipe_master'
TIMEZONE=`cat /etc/timezone`

if [ ! "$(docker image ls -q ${NAME})" ]; then
    docker build --build-arg SRC_DIR=${SRC_DIR} -t ${NAME} .
fi

docker run \
    -it \
    -e TZ=${TIMEZONE} \
    -v ${PWD}:${SRC_DIR}/log \
    -w ${SRC_DIR}/log \
    --rm \
    --privileged \
    --name ${NAME} \
    ${NAME} \
    nwipe
