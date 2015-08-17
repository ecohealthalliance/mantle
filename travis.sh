#!/bin/bash

type spacejam || npm install -g spacejam
spacejam test-packages packages/* || touch FAILURE

export CHIMP_OPTIONS="--browser=phantomjs"
export VELOCITY_CI=1
export CUCUMBER_TAGS=~@chrome
export VELOCITY_DEBUG=1
export CUCUMBER_TAIL=1
meteor --test || touch FAILURE

cat .meteor/local/log/cucumber.log

