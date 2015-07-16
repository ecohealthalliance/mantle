if Meteor.isClient
  FlowLayout.setRoot('body');

FlowRouter.route '/',
  name: 'splashPage'
  action: () ->
    FlowLayout.render 'layout',
      main: 'splashPage'
      params: {}

FlowRouter.route '/profile/edit',
  name: 'profileEdit'
  action: () ->
    FlowLayout.render 'layout',
      main: 'profileEdit'

FlowRouter.route '/profiles/:_id',
  name: 'profileDetail'
  action: (params) ->
    FlowLayout.render 'layout',
      main: 'profileDetail'
      params: {"profileId": params._id}

FlowRouter.route '/organizations',
  name: 'organizations'
  action: () ->
    FlowLayout.render 'layout',
      main: 'organizations'

FlowRouter.route '/organizations/new',
  name: 'newOrganization'
  action: () ->
    FlowLayout.render 'layout',
      main: 'organizationForm'
