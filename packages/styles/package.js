Package.describe({
  name: 'mantle:styles',
  version: '0.0.1',
  summary: 'Styles for mantle',
  git: ''
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('twbs:bootstrap@3.3.4');
  api.use('useraccounts:bootstrap');
  api.use('mquandalle:stylus');
  api.use('fortawesome:fontawesome');

  api.addFiles('variables.import.styl');
  api.addFiles('mixins.import.styl');
  api.addFiles('extends.import.styl');
  api.addFiles('globals.import.styl');

  api.addFiles('accounts.import.styl');

  api.addFiles('main.styl');
});
