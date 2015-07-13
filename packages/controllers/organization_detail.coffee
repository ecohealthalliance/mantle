if Meteor.isClient
  Template.organizationDetail.onCreated ->
    @subscribe('organizationDetail', @data.organizationId)
  
  Template.organizationDetail.helpers
    organization: ->
      Organizations.findOne(@organizationId)
  
if Meteor.isServer
  Meteor.publish 'organizationDetail', (id) ->
    organization = Organizations.findOne(id)
    Organizations.find(id)
