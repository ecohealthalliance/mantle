Template.signIn.events
  'click #at-signUp' : ->
    FlowRouter.go "/signUp"

Template.signUp.events
  'click #at-signIn' : ->
    FlowRouter.go "/signIn"
