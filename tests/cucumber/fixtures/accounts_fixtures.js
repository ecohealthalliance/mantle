(function () {

  'use strict';

  Meteor.methods({
    'reset' : function() {
      Meteor.users.remove({});
    },

    'createProfile' : function() {
      var profile = new UserProfile();
      profile.set('_id', 'fakeid');
      profile.set('fullName', 'Test Name');
      profile.set('jobTitle', 'Test Job');
      profile.set('bio', 'Test Bio');
      profile.set('emailHidden', true);
      profile.save();
    }
  });

})();
