if Meteor.isClient
  Template.organizationDetail.onCreated ->
    @subscribe('organizationDetail', @data.organizationId)
    @editingName = new ReactiveVar(false)
    @editingDescription = new ReactiveVar(false)

  Template.organizationDetail.helpers
    organization: ->
      Organizations.findOne(@organizationId)
    userIsMember: ->
      organization = Organizations.findOne(Template.instance().data.organizationId)
      organization.userIsMember(Meteor.userId())
    userIsAdmin: ->
      organization = Organizations.findOne(Template.instance().data.organizationId)
      organization.userIsAdmin(Meteor.userId())

    isCurrentUser: ->
      @userId == Meteor.userId()

    memberCount: ->
      Organizations.findOne(@organizationId)?.getMemberProfiles().count()
    members: ->
      Organizations.findOne(@organizationId)?.getNonAdminProfiles()
    admins: ->
      Organizations.findOne(@organizationId)?.getAdminProfiles()

    userCanEdit: ->
      organization = Organizations.findOne(@organizationId)
      Meteor.userId() == organization.createdById

    editingName: ->
      Template.instance().editingName.get()

    editingDescription: ->
      Template.instance().editingDescription.get()


  Template.organizationDetail.events
    'click .join-organization' : (event, instance) ->
      orgId = instance.data.organizationId
      Meteor.call 'joinOrganization', orgId, (error, response) ->
        if error
          toastr.error("Error")
        else
          toastr.success("Success")

    'click .make-admin' : (event, instance) ->
      profileId = event.target.getAttribute('data-profileId')
      Meteor.call 'makeAdmin', instance.data.organizationId, profileId

    'click .remove-admin' : (event, instance) ->
      profileId = event.target.getAttribute('data-profileId')
      Meteor.call 'removeAdmin', instance.data.organizationId, profileId

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
  Meteor.publish('organizationDetail', (id) ->
    [
      Organizations.find(id)
      UserProfiles.find({
        memberOfOrgs: id
      }, {
        fields:
          emailAddress: false
      })
    ]
  )

  Meteor.methods
    joinOrganization: (orgId) ->
      profile = UserProfiles.findOne({userId: @userId})
      Organizations.findOne(orgId).addMember(profile._id)

    makeAdmin: (orgId, profileId) ->
      organization = Organizations.findOne(orgId)
      if organization.userIsAdmin(@userId)
        organization.addAdmin(profileId)

    removeAdmin: (orgId, profileId) ->
      organization = Organizations.findOne(orgId)
      if organization.userIsAdmin(@userId)
        organization.removeAdmin(profileId)

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
