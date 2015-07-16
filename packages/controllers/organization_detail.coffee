if Meteor.isClient
  Template.organizationDetail.onCreated ->
    @subscribe('organizationDetail', @data.organizationId)

  Template.organizationDetail.helpers
    organization: ->
      Organizations.findOne(@organizationId)
    userIsMember: ->
      Organizations.findOne({
        _id: @organizationId
        members: Meteor.userId()
      })
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
    # I think there is a bug here where the user profiles subscription
    # won't update when the user joins the organization because the query
    # goes out of date.
    myMembers = Organizations.findOne(id)?.members or []
    [
      Organizations.find(id)
      UserProfiles.find({
        userId: {$in: myMembers}
      })
    ]
  )

  Meteor.methods
    joinOrganization: (orgId) ->
      Organizations.update(orgId, {
        $addToSet: {members: @userId}
      })
