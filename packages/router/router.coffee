FlowRouter.route '/',
  name: 'splashPage'
  action: () ->
    FlowLayout.render 'layout',
      main: 'splashPage'
      data: {}

FlowRouter.route '/signIn',
  name: 'signIn'
  action: () ->
    FlowLayout.render 'layout',
      main: 'signIn'
      data: {}

FlowRouter.route '/signUp',
  name: 'signUp'
  action: () ->
    FlowLayout.render 'layout',
      main: 'signUp'
      data: {}

FlowRouter.route '/profile',
  name: 'profile'
  action: () ->
    FlowLayout.render 'layout',
      main: 'profile'
      #data: {}

FlowRouter.route '/profile/:id',
  name: 'profile'
  template: 'profile'
  action: () ->
    FlowLayout.render 'layout',
      main: 'profile'
      data: {}
