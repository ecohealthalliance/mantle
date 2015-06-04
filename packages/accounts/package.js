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
  api.use('mquandalle:jade@0.4.3');
  
  api.use('accounts-password');
  api.use('eha:useraccounts-core');
  api.use('eha:useraccounts-bootstrap');
  
  api.addFiles('user_publication.coffee', 'server');
  api.addFiles('header_buttons.jade', 'client');
  api.addFiles('header_buttons.coffee', 'client');
  api.addFiles('useraccounts_templates.jade', 'client');
  api.addFiles('useraccounts_templates.coffee', 'client');
});