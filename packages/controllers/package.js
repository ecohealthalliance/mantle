Package.describe({
  name: 'mantle:controllers',
  version: '0.0.1',
  summary: 'Controllers for mantle',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('coffeescript');
  api.use('templating');
  api.use('reactive-var');
  api.use('mantle:models');
  api.use('mantle:views');
  api.use('accounts-password');
  api.use('useraccounts:core');

  api.addFiles('accounts_modal.coffee', 'client');
  api.addFiles('accounts_header_buttons.coffee', 'client');
  api.addFiles('profile_edit.coffee', ['client', 'server']);
});

