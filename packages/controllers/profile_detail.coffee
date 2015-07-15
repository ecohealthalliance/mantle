if Meteor.isClient
  Template.profileDetail.onCreated ->
    @subscribe('userProfileDetail', @data.profileId)

  Template.profileDetail.helpers
    userProfile: ->
      UserProfiles.findOne(@profileId)
    bioParagraphs: (bio) ->
      bio.split(/\r?\n\n/g)
    editProfile: ->
      UserProfiles.findOne(@profileId)?.userId is Meteor.userId()


if Meteor.isServer
  Meteor.publish 'userProfileDetail', (id) ->
    profile = UserProfiles.findOne(id)
    if profile.emailHidden
      UserProfiles.find(id, fields:
        emailAddress: false
      )
    else
      UserProfiles.find(id)
