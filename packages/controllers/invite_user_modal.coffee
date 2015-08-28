if Meteor.isClient
  Template.inviteUserModal.onCreated ->
    @subscribe('usersInMyOrgs')

  Template.inviteUserModal.helpers
    invitableUsers: ->
      userProfile = UserProfiles.findOne(userId: Meteor.userId())
      if userProfile
        myOrgs = Organizations.find
          _id:
            $in: userProfile.memberOfOrgs
        UserProfiles.find({
          memberOfOrgs:
            $in: myOrgs.map((x)-> x._id)
          memberOfDatasets:
            $not: @datasetId
        }, {
          fields:
            emailAddress: false
        })
    invitableUsersTableSettings: ->
      noDataTmpl: Template.noDatasets
      showRowCount: true
      fields: [
        {
          key: 'fullName'
          label: 'Name'
        },
        {
          key: ""
          label: ""
          hideToggle: true
          fn: (val, obj) ->
            new Spacebars.SafeString("""
              <a class="btn btn-success invite-user" data-id="#{obj._id}">
                Invite
              </a>
            """)
        }
      ]

  Template.inviteUserModal.events
    'click .invite-user': (event, template) ->
      userId = $(event.target).data('id')
      datasetId = template.data.datasetId
      Meteor.call 'inviteUser', userId, datasetId, (error, response) ->
        if error
          toastr.error("Error:" + error.message)
        else
          toastr.success("Success")

if Meteor.isServer
  Meteor.methods
    inviteUser: (userId, datasetId) ->
      if @userId
        invitePermission = UserProfiles.findOne(
          userId: @userId
          adminOfDatasets: datasetId
        )
        if not invitePermission
          throw new Meteor.Error("You must be admin to invite an user.")
        Datasets.findOne(datasetId).addMember(userId)
      else
        throw new Meteor.Error("Not logged in")
  Meteor.publish 'usersInMyOrgs', ->
    myOrgs = Organizations.find
      _id:
        $in: UserProfiles.findOne(userId: @userId)?.memberOfOrgs or []
    if not myOrgs
      @ready()
    else
      [
        myOrgs,
        UserProfiles.find({
          memberOfOrgs:
              $in: myOrgs.map((x)-> x._id)
        }, {
          fields:
            emailAddress: false
        })
      ]