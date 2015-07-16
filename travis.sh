#!/bin/bash

# Run tinytests ################################################################
type spacejam || npm install -g spacejam
spacejam test-packages packages/* || touch FAILURE

# Run cucumber tests ###########################################################
VELOCITY_CI=1 CHIMP_OPTIONS="" meteor --test || touch FAILURE
cat .meteor/local/log/cucumber.log

# Trigger testing in saucelabs #################################################
npm install -g mocha grunt grunt-init grunt-cli
git clone https://github.com/saucelabs/grunt-init-sauce.git ~/.grunt-init/sauce

