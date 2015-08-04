if Meteor.isClient
  Template.organizations.onCreated ->
    @subscribe('organizations')

  Template.organizations.helpers
    organizations: ->
      if Meteor.userId()
        Organizations.find()

if Meteor.isServer
  Meteor.publish 'organizations', ->
    Organizations.find()
