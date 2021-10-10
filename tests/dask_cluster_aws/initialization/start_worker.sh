#!/bin/bash

echo "version: \"3.1\"

services:

  worker:
    image: daskdev/dask:2021.9.1-py3.8
    network_mode: host
    command: [\"dask-worker\", \"tcp://18.169.93.220:8786\"]" > docker-compose.yaml;
sleep 60;
sudo docker-compose -f docker-compose.yaml up -d;