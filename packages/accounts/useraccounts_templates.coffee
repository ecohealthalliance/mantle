Template.signIn.events
  'click #at-signUp' : ->
    Path.go "/signUp"

Template.signUp.events
  'click #at-signIn' : ->
    Path.go "/signIn"
