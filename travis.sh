#!/bin/bash

# Run tinytests ################################################################
type spacejam || npm install -g spacejam
spacejam test-packages packages/* || touch FAILURE

# Run cucumber tests ###########################################################
echo "Run cucumber tests against phantomjs ************************************"
VELOCITY_CI=1 CHIMP_OPTIONS="" meteor --test || touch FAILURE
cat .meteor/local/log/cucumber.log

# Saucelabs #################################################
#echo "Run cucumber tests on saucelabs *****************************************"
#HUB_HOST=ondemand.saucelabs.com
#HUB_PORT=4444
#HUB_USER=$SAUCE_USERNAME
#HUB_KEY=$SAUCE_ACCESS_KEY
#HUB_PLATFORM='Windows 7'
#HUB_VERSION=35
#VELOCITY_CI=1 CHIMP_OPTIONS="" meteor --test

