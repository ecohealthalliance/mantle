Package.describe({
  name: 'mantle:accounts',
  version: '0.0.1',
  summary: 'User accounts for the mantle project'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('templating');
  api.use('coffeescript');
  api.use('underscore');
  api.use('reactive-var');
  api.use('mquandalle:jade@0.4.3');

  api.use('accounts-password');
  api.use('useraccounts:core');
  api.use('useraccounts:bootstrap');

  api.addFiles('header_buttons.jade', 'client');
  api.addFiles('header_buttons.coffee', 'client');
  api.addFiles('accounts_modal.jade', 'client');
  api.addFiles('accounts_modal.coffee', 'client');
});

Package.onTest(function(api) {
  api.use('coffeescript');
  api.use('mantle:accounts');
  api.use('accounts-base');
  api.use('matb33:bootstrap-modals');
  api.use('practicalmeteor:munit');
  api.use('test-helpers');
  api.addFiles('tests/server/fixtures.coffee', 'server');
  api.addFiles('tests/client/accounts_test.coffee', 'client');
});
