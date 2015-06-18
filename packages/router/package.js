Package.describe({
  name: 'mantle:router',
  version: '0.0.1',
  summary: 'Routing for mantle',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('coffeescript');
  api.use('templating');
  api.use('mantle:layout@0.0.1');
  api.use('meteorhacks:flow-layout@1.3.0');
  api.use('meteorhacks:flow-router@1.9.0');
  api.use('mantle:splash-page@0.0.1');
  api.use('mantle:accounts');
  api.addFiles('router.coffee', ['client', 'server']);
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('mantle:router');
});
