(function () {

  'use strict';

  Meteor.methods({
    'reset' : function() {
      Meteor.users.remove({});
      UserProfiles.remove({});
      Organizations.remove({});
    },

    'createProfile' : function(field, value, id) {
      var attributes = {};
      attributes[field] = value;
      attributes['_id'] = id;
      UserProfiles.insert(attributes);
    }
  });

})();
