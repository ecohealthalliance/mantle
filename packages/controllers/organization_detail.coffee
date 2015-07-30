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
      organization = Organizations.findOne(Template.instance().data.organizationId)
      organization.userIsAdmin(Meteor.userId())

    hideButtonsForProfile: (profileId) ->
      @userId == Meteor.userId()

    memberCount: ->
      Organizations.findOne(@organizationId)?.getMemberProfiles().count()
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
