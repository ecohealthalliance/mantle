if Meteor.isClient
  Template.profileDetail.onCreated ->
    @subscribe('userProfileDetail', this.data.profileId)
  
  Template.profileDetail.helpers
    userProfile: ->
      UserProfiles.findOne()

if Meteor.isServer
  Meteor.publish 'userProfileDetail', (id) ->
    UserProfiles.find({_id: id})
