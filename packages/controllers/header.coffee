if Meteor.isClient
  Template.header.onCreated ->
    @subscribe('currentUserProfile')
    @accountsState = new ReactiveVar("signIn")

  Template.header.helpers
    accountsState: -> Template.instance().accountsState
    currentUserProfile: -> UserProfiles.findOne({userId: Meteor.userId()})

if Meteor.isServer
  Meteor.publish 'currentUserProfile', ->
    UserProfiles.findOne({userId: Meteor.userId()})
