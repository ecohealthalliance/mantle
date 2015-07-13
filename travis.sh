#!/bin/bash

type spacejam || npm install -g spacejam
spacejam test-packages packages/* || touch FAILURE
VELOCITY_CI=1 CHIMP_OPTIONS="" meteor --test || touch FAILURE
cat .meteor/local/log/cucumber.log

