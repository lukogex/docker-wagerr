#!/bin/bash
mkdir -p data
docker run --name wagerr -d --mount type=bind,source="$(pwd)"/data,target=/wgrdata,consistency=delegated -p 55002:55002 pkuijpers/wagerr
