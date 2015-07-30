Package.describe({
  name: 'mantle:fixtures',
  version: '0.0.1',
  debugOnly: true,
  summary: '',
  git: '',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('accounts-base');
  api.use('coffeescript');
  api.use('cfs:standard-packages');
  api.use('cfs:gridfs');
  api.addFiles('fixtures.coffee');
});
