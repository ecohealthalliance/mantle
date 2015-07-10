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
  api.addFiles('fixtures.coffee');
});
