Package.describe({
  name: 'mantle:splash-page',
  version: '0.0.1',
  summary: 'Splash page for mantle',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('templating');
  api.use('mquandalle:jade@0.4.1');
  api.addFiles('splash_page.jade', 'client');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('mantle:splash-page');
});