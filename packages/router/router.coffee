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

FlowRouter.route '/organizations/:_id',
  name: 'organizationDetail'
  action: (params) ->
    FlowLayout.render 'layout',
      main: 'organizationDetail'
      params: {"organizationId": params._id}

FlowRouter.route '/myDatasets',
  name: 'myDatasets'
  action: (params) ->
    FlowLayout.render 'layout',
      main: 'myDatasets'

FlowRouter.route '/datasets/new',
  name: 'newDataset'
  action: () ->
    FlowLayout.render 'layout',
      main: 'datasetForm'

FlowRouter.route '/datasets/:_id',
  name: 'datasetDetail'
  action: (params) ->
    FlowLayout.render 'layout',
      main: 'datasetDetail'
      params: {"datasetId": params._id}

FlowRouter.notFound =
  name: 'notFound'
  action: () ->
    FlowLayout.render 'layout',
      main: 'pageNotFound'




