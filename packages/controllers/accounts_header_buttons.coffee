if Meteor.isClient
  Template.accountsHeaderButtons.onCreated ->
    @subscribe('currentUserName', Meteor.userId())

  Template.accountsHeaderButtons.helpers
    currentUserName: ->
      UserProfiles.findOne({userId: Meteor.userId()})?.fullName

  Template.accountsHeaderButtons.events
    'click .sign-out' : (evt, instance) ->
      Meteor.logout()
    'click .sign-in' : (evt, instance) ->
      @state.set("signIn")
      $('.accounts-modal').modal('show')

if Meteor.isServer
  Meteor.publish 'currentUserName', (id) ->
    UserProfiles.find({userId: id}, {fields: {userId: 1, fullName: 1}})
