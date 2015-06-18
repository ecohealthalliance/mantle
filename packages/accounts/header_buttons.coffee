Template.accountsHeaderButtons.onCreated ->
  @state = new ReactiveVar("signIn")

Template.accountsHeaderButtons.helpers
  state: -> Template.instance().state

Template.accountsHeaderButtons.events
  'click .sign-out' : (evt, instance) ->
    Meteor.logout()
  'click .sign-in' : (evt, instance) ->
    instance.state.set("signIn")
    $('.accounts-modal').modal('show')
