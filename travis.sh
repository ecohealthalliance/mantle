#!/bin/bash

mkdir -p tests/jasmine/server/integration/ tests/jasmine/client/integration/ tests/jasmine/client/unit/ tests/jasmine/server/unit/

for FILE in `find packages/|grep tests|grep .js`; do
  ls $FILE| grep server| grep integration
  if [[ $? -eq 0 ]]; then cp $FILE tests/jasmine/server/integration/; fi

  ls $FILE| grep client| grep integration
  if [[ $? -eq 0 ]]; then cp $FILE tests/jasmine/client/integration/; fi

  ls $FILE| grep server| grep unit
  if [[ $? -eq 0 ]]; then cp $FILE tests/jasmine/server/unit/; fi

  ls $FILE| grep client| grep unit
  if [[ $? -eq 0 ]]; then cp $FILE tests/jasmine/client/unit/; fi
done

DEBUG=1 JASMINE_DEBUG=1 VELOCITY_DEBUG=1 VELOCITY_DEBUG_MIRROR=1 JASMINE_BROWSER=Firefox meteor --test
