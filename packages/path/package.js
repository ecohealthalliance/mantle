Package.describe({
  name: 'mantle:path',
  version: '0.0.1',
  summary: 'Utility for generating URL paths',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('coffeescript');
  api.use('templating');
  api.use('meteorhacks:flow-router@1.9.0');
  
  api.addFiles('helpers.coffee', 'client');
  api.addFiles('path.coffee', 'client');
  
  api.export('Path', 'client');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('mantle:router');
});
