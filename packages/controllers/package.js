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
  api.use('underscore');
  api.use('mantle:models');
  api.use('mantle:views');
  api.use('mantle:route-helpers');
  api.use('accounts-password');
  api.use('useraccounts:core@1.12.2');
  api.use('chrismbeckett:toastr');

  api.addFiles('toastr.coffee', 'client');
  api.addFiles('file_input.coffee', 'client');
  api.addFiles('header.coffee', 'client');
  api.addFiles('accounts_modal.coffee', 'client');
  api.addFiles('accounts_header_buttons.coffee', ['client', 'server']);
  api.addFiles('profile_edit.coffee', ['client', 'server']);
  api.addFiles('profile_detail.coffee', ['client', 'server']);
  api.addFiles('organizations.coffee', ['client', 'server']);
  api.addFiles('organization_form.coffee', ['client', 'server']);
  api.addFiles('organization_detail.coffee', ['client', 'server']);
  api.addFiles('dataset_form.coffee', ['client', 'server']);
  api.addFiles('dataset_detail.coffee', ['client', 'server']);
  api.addFiles('paragraph_text.coffee', 'client');
  api.addFiles('my_datasets.coffee');
  api.addFiles('invite_user_modal.coffee', ['client', 'server']);
});

