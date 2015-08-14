'use strict';

Package.describe({
  name: 'velocity:core',
  summary: 'Velocity, a Meteor specific test-runner',
  version: '0.9.3',
  git: 'https://github.com/meteor-velocity/velocity.git',
  debugOnly: true
});

Npm.depends({
  'lodash': '2.4.1',
  'fs-extra': '0.18.0',
  'freeport':'1.0.4',
  'mongodb-uri': '0.9.7',
  'colors': '1.0.3',
  'tmp': '0.0.25'
});

Package.on_use(function (api) {

  var SERVER = 'server',
      CLIENT = 'client',
      BOTH = [CLIENT, SERVER];

  api.versionsFrom('METEOR@1.1.0.2');
  api.use('grigio:babel@0.1.6');
  api.use('webapp');
  api.use('mongo');
  api.use('check');
  api.use('underscore'); // Used for the Function.bind polyfill
  api.use('velocity:chokidar@1.0.3_1', 'server');
  api.use('velocity:meteor-internals@1.1.0_7');
  api.use('velocity:source-map-support@0.3.2_1');
  api.use('sanjo:long-running-child-process@1.1.3', 'server');
  api.use('sanjo:meteor-files-helpers@1.1.0_7', 'server');

  api.export('Velocity', BOTH);
  api.export('VelocityTestFiles', BOTH);
  api.export('VelocityFixtureFiles', BOTH);
  api.export('VelocityTestReports', BOTH);
  api.export('VelocityAggregateReports', BOTH);
  api.export('VelocityLogs', BOTH);
  api.export('VelocityMirrors', BOTH);
  api.export('VelocityOptions', BOTH);

  api.add_files('src/source_map_support.es6.js', BOTH);
  api.add_files('src/polyfills.es6.js', BOTH);
  api.add_files('src/globals.es6.js', BOTH);
  api.add_files('src/collections.es6.js', BOTH);
  api.add_files('src/helpers.es6.js', SERVER);

  // Methods
  api.add_files('src/methods/logs/logs_reset.es6.js', SERVER);
  api.add_files('src/methods/logs/logs_submit.es6.js', SERVER);
  api.add_files('src/methods/mirrors/mirror_init.es6.js', SERVER);
  api.add_files('src/methods/mirrors/mirror_register.es6.js', SERVER);
  api.add_files('src/methods/mirrors/mirror_request.es6.js', SERVER);
  api.add_files('src/methods/mirrors/parentHandshake.es6.js', SERVER);
  api.add_files('src/methods/options/getOption.es6.js', BOTH);
  api.add_files('src/methods/options/setOption.es6.js', BOTH);
  api.add_files('src/methods/options/setOptions.es6.js', BOTH);
  api.add_files('src/methods/reports/reports_completed.es6.js', SERVER);
  api.add_files('src/methods/reports/reports_reset.es6.js', SERVER);
  api.add_files('src/methods/reports/reports_submit.es6.js', SERVER);
  api.add_files('src/methods/copySampleTests.es6.js', SERVER);
  api.add_files('src/methods/featureTestDone.es6.js', SERVER);
  api.add_files('src/methods/featureTestFailed.es6.js', SERVER);
  api.add_files('src/methods/isEnabled.es6.js', SERVER);
  api.add_files('src/methods/isMirror.es6.js', SERVER);
  api.add_files('src/methods/register_framework.es6.js', SERVER);
  api.add_files('src/methods/reset.es6.js', SERVER);
  api.add_files('src/methods/returnTODOTestAndMarkItAsDOING.es6.js', SERVER);
  api.add_files('src/methods.es6.js', BOTH);

  api.add_files('src/core.es6.js', SERVER);
  api.add_files('src/core-shared.es6.js', BOTH);
  api.add_files('src/mirrors/mirrorRegistrar.es6.js', SERVER);

});
