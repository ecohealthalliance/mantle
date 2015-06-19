Package.describe({
  name: 'mantle:style',
  version: '0.0.1',
  summary: 'Styles for the mantle project',

});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('twbs:bootstrap@3.3.4');
});

