#!/bin/sh
START=`date +%s`
sudo docker-compose -f docker-compose.omni.yaml up -d && echo execution time was $(expr `date +%s` - $START) s.