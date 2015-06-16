Template.accountsHeaderButtons.events
  'click .sign-out' : () ->
    Meteor.logout()
  'click .sign-in' : () ->
    FlowLayout.render 'layout',
      main: 'signIn'
