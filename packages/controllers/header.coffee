if Meteor.isClient
  Template.header.onCreated ->
    @subscribe('currentUserInfo', Meteor.userId())
    @accountsState = new ReactiveVar("signIn")

  Template.header.helpers
    accountsState: -> Template.instance().accountsState
    currentUserInfo: -> UserProfiles.findOne({userId: Meteor.userId()})

if Meteor.isServer
  Meteor.publish 'currentUserInfo', (id) ->
    profile = UserProfiles.findOne({userId: id})
    if profile.emailHidden
      UserProfiles.find({userId: id}, fields:
        emailAddress: false
      )
    else
      UserProfiles.find({userId: id})
