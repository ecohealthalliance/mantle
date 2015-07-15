if Meteor.isClient
  Template.header.onCreated ->
    @subscribe('currentUserName', Meteor.userId())
    @accountsState = new ReactiveVar("signIn")

  Template.header.helpers
    accountsState: -> Template.instance().accountsState
    currentUserName: -> UserProfiles.findOne({userId: Meteor.userId()})

if Meteor.isServer
  Meteor.publish 'currentUserName', (id) ->
    UserProfiles.find({userId: id}, {fields: {userId: 1, fullName: 1}})

