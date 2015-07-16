if Meteor.isClient
  Template.organizations.onCreated ->
    @subscribe('currentUserOrganizations')

  Template.organizations.helpers
    organizations: ->
      if Meteor.userId()
        Organizations.find({createdById: Meteor.userId()})
    truncated: (description)->
      description = description.split(' ')
      wordCount = 50
      if description.length > wordCount
        description.slice(0,wordCount).join(' ')+'...'
      else
        description.join(' ')

if Meteor.isServer
  Meteor.publish 'currentUserOrganizations', ->
    Organizations.find({createdById: this.userId})
