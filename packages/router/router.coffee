if Meteor.isClient
  BlazeLayout.setRoot('body')

FlowRouter.subscriptions = () ->
  @register 'userInfo', Meteor.subscribe 'userInfo'

FlowRouter.route '/',
  name: 'splashPage'
  action: () ->
    BlazeLayout.render 'layout',
      main: 'splashPage'
      params: {}
