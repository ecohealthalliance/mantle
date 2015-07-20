if Meteor.isClient
  Template.organizationDetail.onCreated ->
    @subscribe('organizationDetail', @data.organizationId)
  
  Template.organizationDetail.helpers
    organization: ->
      Organizations.findOne(@organizationId)

  Template.organizationDetail.events
    'click .save-name-button': (event) ->
      event.preventDefault()
      Meteor.call 'updateName', $('#organization-name').val(), @organizationId

    'click .save-description-button': (event) ->
      event.preventDefault()
      Meteor.call 'updateDescription', $('#organization-description').val(), @organizationId

if Meteor.isServer
  Meteor.methods
    updateName: (name, id) ->
      organization = Organizations.findOne({_id: id, createdById: this.userId})
      organization.set({name: name})
      organization.save ->
        organization

    updateDescription: (description, id) ->
      organization = Organizations.findOne({_id: id, createdById: this.userId})
      organization.set({description: description})
      organization.save ->
        organization

  Meteor.publish 'organizationDetail', (id) ->
    Organizations.find(id)
