Template.signIn.events
  'click #at-signUp' : ->
    if window.location.pathname == "/signUp"
      # If the signIn template is rendered on the signUp page Path.go will
      # not render the original template, so it is done by a call to render.
      FlowLayout.render 'layout',
        main: 'signUp'
    else
      Path.go "/signUp"

Template.signUp.events
  'click #at-signIn' : ->
    FlowLayout.render 'layout',
      main: 'signIn'
