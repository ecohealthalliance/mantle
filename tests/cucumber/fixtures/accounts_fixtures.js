(function () {

  'use strict';

  Meteor.methods({
    'reset' : function() {
      Meteor.users.remove({});
      UserProfiles.remove({});
    },

    'createProfile' : function(field, value) {
      var attributes = {};
      attributes[field] = value;
      attributes['_id'] = 'fakeid';
      UserProfiles.insert(attributes);
    }
  });

})();
