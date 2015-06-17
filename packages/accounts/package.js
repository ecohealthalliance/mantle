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
  
  api.use('mantle:path');
  api.use('accounts-password');
  api.use('useraccounts:core');
  api.use('useraccounts:bootstrap');
  
  api.addFiles('header_buttons.jade', 'client');
  api.addFiles('header_buttons.coffee', 'client');
  api.addFiles('accounts_modal.jade', 'client');
  api.addFiles('accounts_modal.coffee', 'client');
});