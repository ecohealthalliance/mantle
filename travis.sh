#!/bin/bash

# Run tinytests ################################################################
type spacejam || npm install -g spacejam
spacejam test-packages packages/* || touch FAILURE

# Run cucumber tests ###########################################################
VELOCITY_CI=1 CHIMP_OPTIONS="" meteor --test || touch FAILURE
cat .meteor/local/log/cucumber.log

# Trigger testing in saucelabs #################################################
curl https://saucelabs.com/rest/v1/frosario/js-tests \
  -X POST \
  -u $SAUCE_USERNAME:$SAUCE_ACCESS_KEY \
  -H 'Content-Type: application/json' \
  --data '{
    "platforms": [
                  ["Linux", "firefox", ""],
                  ["OS X 10.8", "safari", ""],
                  ["Windows 7", "internet explorer", "11"]
                 ],
    "url": "http://localhost:3000",
    "tunnelIdentifier": "$TRAVIS_JOB_NUMBER",
    "name": "https://travis-ci.org/ecohealthalliance/mantle/builds/$TRAVIS_BUILD_ID",
    "framework": "custom"}'

