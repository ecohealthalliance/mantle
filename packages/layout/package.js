Package.describe({
  name: 'mantle:layout',
  version: '0.0.1',
  summary: 'Layout for mantle',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('templating');
  api.use('mquandalle:jade@0.4.1');
  api.use('twbs:bootstrap@3.3.4');
  api.use('mantle:accounts');
  api.addFiles('layout.jade', 'client');
  api.addFiles('header.jade', 'client');
  api.addFiles('footer.jade', 'client');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('mantle:layout');
});
