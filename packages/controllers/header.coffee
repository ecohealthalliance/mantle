if Meteor.isClient
  Template.header.onCreated ->
    @accountsState = new ReactiveVar("signIn")

  Template.header.helpers
    accountsState: -> Template.instance().accountsState

