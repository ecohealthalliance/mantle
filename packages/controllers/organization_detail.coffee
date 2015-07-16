if Meteor.isClient
  Template.organizationDetail.onCreated ->
    @subscribe('organizationDetail', @data.organizationId)

  Template.organizationDetail.helpers
    organization: ->
      Organizations.findOne(@organizationId)
    format: (description)->
      description?.split(/\r?\n\n/g)

if Meteor.isServer
  Meteor.publish 'organizationDetail', (id) ->
    Organizations.find(id)
