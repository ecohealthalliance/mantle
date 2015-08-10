#!/bin/bash

# Run tinytests ################################################################
echo "Run tinytests ************************************************************"
type spacejam || npm install -g spacejam
spacejam test-packages packages/* || touch FAILURE

# Run cucumber tests ###########################################################
#echo "Run cucumber tests locally against phantomjs ****************************"
#VELOCITY_CI=1 CHIMP_OPTIONS="" meteor --test || touch FAILURE
#cat .meteor/local/log/cucumber.log

# Saucelabs #################################################
echo "Run cucumber tests on saucelabs ******************************************"
export HUB_HOST=ondemand.saucelabs.com
export HUB_PORT=4444
export HUB_USER=$SAUCE_USERNAME
export HUB_KEY=$SAUCE_ACCESS_KEY
export HUB_PLATFORM='Linux'
#export HUB_VERSION='35'
export VELOCITY_CI=1
export CUCUMBER_TAIL=1

meteor --test || touch FAILURE

