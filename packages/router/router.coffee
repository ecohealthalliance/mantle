FlowRouter.route '/',
  name: 'splashPage'
  action: () ->
    FlowLayout.render 'layout',
      main: 'splashPage'
      params: {}

FlowRouter.route '/profile/:id/edit',
  name: 'profileEdit'
  action: () ->
    FlowLayout.render 'layout',
      main: 'profileEdit'
      params: {}
