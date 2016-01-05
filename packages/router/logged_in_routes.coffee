# Based on the example here:
# https://medium.com/@satyavh/using-flow-router-for-authentication-ba7bb2644f42#.ix98j24rh
loggedIn = FlowRouter.group
  triggersEnter: [ ->
    unless Meteor.loggingIn() or Meteor.userId()
      FlowRouter.go '/'
  ]
