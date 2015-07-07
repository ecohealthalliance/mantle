if Meteor.isClient
  Template.profileDetail.onCreated ->
    @subscribe('userProfileDetail', @data.profileId)
  
  Template.profileDetail.helpers
    userProfile: ->
      UserProfiles.findOne(@profileId)

if Meteor.isServer
  Meteor.publish 'userProfileDetail', (id) ->
    profile = UserProfiles.findOne(id)
    UserProfiles.find(id,
      fields:
        emailAddress: !(profile?.emailHidden)
    )
