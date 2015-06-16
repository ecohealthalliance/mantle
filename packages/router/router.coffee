FlowRouter.route '/',
  name: 'splashPage'
  action: () ->
    FlowLayout.render 'layout',
      main: 'splashPage'
      params: {}

FlowRouter.route '/signUp',
  name: 'signUp'
  action: () ->
    FlowLayout.render 'layout',
      main: 'signUp'
