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
    memberCount: ->
      Organizations.findOne(@organizationId)?.getMemberProfiles().count()
    members: ->
      Organizations.findOne(@organizationId)?.getMemberProfiles()

  Template.organizationDetail.events
    'click .join-organization' : (event, instance) ->
      orgId = instance.data.organizationId
      Meteor.call 'joinOrganization', orgId, (error, response) ->
        if error
          toastr.error("Error")
        else
          toastr.success("Success")

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
      Organizations.findOne(orgId).addMember(@userId)
