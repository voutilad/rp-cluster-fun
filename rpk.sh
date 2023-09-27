#!/bin/sh
set -e

. ./config

docker run -i --rm \
       --name "${PREFIX}-rpk" \
       --network "${NET}" \
       --entrypoint rpk \
       "${IMAGE}" \
       -X "brokers=${PREFIX}-1:9092,${PREFIX}-2:9092,${PREFIX}-3:9092" \
       -X "admin.hosts=${PREFIX}-1:9644,${PREFIX}-2:9644,${PREFIX}-3:9644" \
       "$@"
