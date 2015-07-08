if Meteor.isClient
  Template.organizations.onCreated ->
    @subscribe('currentUserOrganizations')

  Template.organizations.helpers
    organizations: ->
      Organizations.find({createdById: Meteor.userId()})

if Meteor.isServer
  Meteor.publish 'currentUserOrganizations', ->
    Organizations.find({createdById: this.userId})
