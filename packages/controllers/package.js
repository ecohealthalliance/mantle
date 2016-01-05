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
  api.use('mantle:route-helpers');
  api.use('accounts-password');
  api.use('useraccounts:core@1.12.2');
  api.use('chrismbeckett:toastr');

  api.addFiles('toastr.coffee', 'client');
  api.addFiles('header.coffee', 'client');
});

