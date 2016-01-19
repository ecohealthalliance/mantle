#!/bin/bash

MONGO_URL=mongodb://localhost:27017/chimp_db meteor --port 3100 &
CUCUMBER_TAIL=1 ./node_modules/.bin/chimp --tags=${TAGS} --ddp=http://localhost:3100 --path=tests/cucumber/features/ --coffee=true --chai=true
kill `lsof -t -i:3100`
