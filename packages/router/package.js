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
  api.use('kadira:blaze-layout');
  api.use('kadira:flow-router@2.10.0');
  api.use('mantle:controllers');
  api.addFiles('router.coffee', ['client', 'server']);
  api.addFiles('logged_in_routes.coffee', ['client', 'server']);
});
