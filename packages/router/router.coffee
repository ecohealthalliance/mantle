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

FlowRouter.route '/profile',
  name: 'profile'
  action: () ->
    FlowLayout.render 'layout',
      main: 'profile'

FlowRouter.route '/profile/:id',
  name: 'profile'
  template: 'profile'
  action: () ->
    FlowLayout.render 'layout',
      main: 'profile'
