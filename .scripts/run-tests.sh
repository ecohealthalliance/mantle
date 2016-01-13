#!/bin/bash

MONGO_URL=mongodb://localhost:27017/chimp_db meteor --port 3100 &
tail -f testoutput.txt &
CUCUMBER_TAIL=1 ./node_modules/.bin/chimp --tags=${TAGS} --ddp=http://localhost:3100 --path=tests/cucumber/features/ --coffee=true --chai=true --sync=false > testoutput.txt
kill `lsof -t -i:3100`
if grep -q "failed steps" testoutput.txt
then
  echo "Tests Failed"
  exit 1  
fi
echo "Tests Passed"
exit 0
