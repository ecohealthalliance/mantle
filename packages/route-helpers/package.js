Package.describe({
  name: 'mantle:route-helpers',
  version: '0.0.1',
  summary: 'Utility for generating URL paths and changing the route',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('coffeescript');
  api.use('templating');
  api.use('meteorhacks:flow-router@1.9.0');

  api.addFiles('helpers.coffee', 'client');
  api.export('go', 'client');
});


