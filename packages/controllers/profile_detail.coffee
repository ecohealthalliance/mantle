if Meteor.isClient
  Template.profileDetail.onCreated ->
    @subscribe('userProfileDetail', @data.profileId)

  Template.profileDetail.helpers
    userProfile: ->
      UserProfiles.findOne(@profileId)

if Meteor.isServer
  Meteor.publish 'userProfileDetail', (id) ->
    profile = UserProfiles.findOne(id)
    if profile.emailHidden
      UserProfiles.find(id, fields:
        emailAddress: false
      )
    else
      UserProfiles.find(id)
