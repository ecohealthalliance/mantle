Package.describe({
  name: 'mantle:models',
  version: '0.0.1',
  summary: 'Models for mantle',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('coffeescript');
  api.use('jagi:astronomy@0.12.0');
  api.use('accounts-password');
  api.use('useraccounts:core@1.7.0');
  api.use('mongo');
  api.use('cfs:standard-packages');
  api.use('cfs:gridfs');
  api.addFiles('user_profiles.coffee', ['client', 'server']);
  api.addFiles('organizations.coffee', ['client', 'server']);
  api.addFiles('raw_files.coffee', ['client', 'server']);
  api.addFiles('datasets.coffee', ['client', 'server']);
  api.export(['UserProfile', 'UserProfiles'], ['client', 'server']);
  api.export(['Organization', 'Organizations'], ['client', 'server']);
  api.export(['Dataset', 'Datasets'], ['client', 'server']);
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('coffeescript');
  api.use('mantle:models');
  api.use('practicalmeteor:munit');
  api.use('test-helpers');
  api.addFiles('tests/server/user_profiles_test.coffee', 'server');
  api.addFiles('tests/server/organizations_test.coffee', 'server');
  api.addFiles('tests/server/datasets_test.coffee', 'server');
});
