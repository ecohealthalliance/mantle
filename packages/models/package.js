Package.describe({
  name: 'mantle:models',
  version: '0.0.1',
  summary: 'Models for mantle',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('coffeescript');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('mantle:models');
});
