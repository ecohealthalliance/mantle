#!/bin/bash

type spacejam || npm install -g spacejam
spacejam test-packages packages/* || touch FAILURE
VELOCITY_CI=1 CHIMP_OPTIONS="" CUCUMBER_TAGS=~@chrome meteor --test || touch FAILURE
cat .meteor/local/log/cucumber.log

