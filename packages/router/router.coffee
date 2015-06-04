FlowRouter.route '/',
  name: 'splashPage'
  action: () ->
    FlowLayout.render 'layout',
      main: 'splashPage'
      params: {}

FlowRouter.route '/signIn',
  name: 'signIn'
  action: () ->
    FlowLayout.render 'layout',
      main: 'signIn'

FlowRouter.route '/signUp',
  name: 'signUp'
  action: () ->
    FlowLayout.render 'layout',
      main: 'signUp'
