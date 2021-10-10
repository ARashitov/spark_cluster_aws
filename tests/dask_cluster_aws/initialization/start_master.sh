#!/bin/bash

echo "version: \"3.1\"

services:

  master:
    image: daskdev/dask:2021.9.1-py3.8
    network_mode: host
    command: [\"dask-scheduler\"]" > docker-compose.yaml;

sudo docker-compose -f docker-compose.yaml up -d;