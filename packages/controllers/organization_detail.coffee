if Meteor.isClient
  Template.organizationDetail.onCreated ->
    @subscribe('organizationDetail', @data.organizationId)
    @editingName = new ReactiveVar(false)
    @editingDescription = new ReactiveVar(false)

  Template.organizationDetail.helpers
    organization: ->
      Organizations.findOne(@organizationId)

    userCanEdit: ->
      organization = Organizations.findOne(@organizationId)
      Meteor.userId() == organization.createdById

    editingName: ->
      Template.instance().editingName.get()

    editingDescription: ->
      Template.instance().editingDescription.get()

  Template.organizationDetail.events
    'click .edit-name-button': (event, instance) ->
      event.preventDefault()
      instance.editingName.set(true)

    'click .cancel-name-button': (event, instance)->
      instance.editingName.set(false)

    'submit .edit-name': (event, instance) ->
      event.preventDefault()
      Meteor.call 'updateName', $('#organization-name').val(), @organizationId, ->
        instance.editingName.set(false)

    'click .edit-description-button': (event, instance) ->
      event.preventDefault()
      instance.editingDescription.set(true)

    'click .cancel-description-button': (event, instance)->
      instance.editingDescription.set(false)

    'click .save-description-button': (event, instance) ->
      event.preventDefault()
      Meteor.call 'updateDescription', $('#organization-description').val(), @organizationId, ->
        instance.editingDescription.set(false)

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
