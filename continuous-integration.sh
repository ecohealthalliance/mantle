#!/bin/bash

#Ensure all dependencies are downloaded
meteor build throw-away --debug
rm -fr throw-away

echo "Unit Tests *******************************************************************************"
type spacejam || npm install -g spacejam
spacejam test-packages packages/* || touch FAILURE


echo "Integration Tests ************************************************************************"
export VELOCITY_CI=1
export CUCUMBER_TAIL=1

echo "Running against PhantomJS..."
export CUCUMBER_TAGS="~@chrome"
meteor --test || touch FAILURE

echo "Running against Chrome..."
export CHIMP_OPTIONS="--browser=chrome"
export CUCUMBER_TAGS=""
meteor --test || touch FAILURE

echo "Running against Firefox..."
export CHIMP_OPTIONS="--browser=firefox"
export CUCUMBER_TAGS=""
meteor --test || touch FAILURE

echo "Finished running integration tests..."
if [[ -e FAILURE ]];then
  echo "One of the tests failed somewhere :("
  exit 1;
fi
