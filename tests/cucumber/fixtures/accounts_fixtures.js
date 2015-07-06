(function () {

  'use strict';

  Meteor.methods({
    'reset' : function() {
      Meteor.users.remove({});
      UserProfiles.remove({});
    },

    'createProfile' : function(field, value) {
      var profile = new UserProfile();
      profile.set('_id', 'fakeid');
      profile.set(field, value);
      profile.save();
    }
  });

})();
