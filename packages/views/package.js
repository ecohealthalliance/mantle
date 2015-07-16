Package.describe({
  name: 'mantle:views',
  version: '0.0.1',
  summary: 'Views for mantle',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('templating');
  api.use('mquandalle:jade@0.4.1');
  api.use('mantle:styles');
  api.use('mantle:path');

  api.addFiles('accounts_modal.jade');
  api.addFiles('accounts_header_buttons.jade')
  api.addFiles('splash_page.jade', 'client');
  api.addFiles('profile_edit.jade', 'client');
  api.addFiles('profile_detail.jade', 'client');
  api.addFiles('organizations.jade', 'client');
  api.addFiles('organization_form.jade', 'client');
  api.addFiles('organization_detail.jade', 'client');
  api.addFiles('header.jade', 'client');
  api.addFiles('footer.jade', 'client');
  api.addFiles('layout.jade', 'client');
});
