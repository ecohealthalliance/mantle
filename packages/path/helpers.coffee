Template.registerHelper 'path', (kwArgs) ->
  route = kwArgs.hash.route
  params = kwArgs.hash.params
  query = kwArgs.hash.query
  FlowRouter.path route, params, query