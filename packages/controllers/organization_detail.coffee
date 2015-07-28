if Meteor.isClient
  Template.organizationDetail.onCreated ->
    @subscribe('organizationDetail', @data.organizationId)

  Template.organizationDetail.helpers
    organization: ->
      Organizations.findOne(@organizationId)
    userIsMember: ->
      UserProfiles.findOne({
        userId: Meteor.userId(),
        memberOfOrgs: @organizationId
      })
    userIsAdmin: ->
      UserProfiles.findOne({
        userId: Meteor.userId(),
        adminOfOrgs: @organizationId
      })
    members: ->
      Organizations.findOne(@organizationId)?.getNonAdminProfiles()
    admins: ->
      Organizations.findOne(@organizationId)?.getAdminProfiles()

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

if Meteor.isServer

  Meteor.publish('organizationDetail', (id) ->
    [
      Organizations.find(id)
      UserProfiles.find({
        memberOfOrgs: id
      })
    ]
  )

  Meteor.methods
    joinOrganization: (orgId) ->
      Organizations.findOne(orgId).addMember(@userId)

    makeAdmin: (orgId, profileId) ->
      Organizations.findOne(orgId).addAdmin(profileId)

    removeAdmin: (orgId, profileId) ->
      Organizations.findOne(orgId).removeAdmin(profileId)
