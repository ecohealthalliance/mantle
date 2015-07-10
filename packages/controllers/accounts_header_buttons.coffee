Template.accountsHeaderButtons.events
  'click .sign-out' : (evt, instance) ->
    Meteor.logout()
  'click .sign-in' : (evt, instance) ->
    @state.set("signIn")
    $('.accounts-modal').modal('show')
