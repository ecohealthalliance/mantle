if Meteor.isClient
  Template.inviteUserModal.onCreated ->
    @invitableUsers = new ReactiveVar([])
    @selectedUser = new ReactiveVar()

  Template.inviteUserModal.helpers
    selectedUser: ->
      Template.instance().selectedUser.get()
    invitableUsers: ->
      Template.instance().invitableUsers.get()

  Template.inviteUserModal.events
    'click .invite-user': (event, instance) ->
      user = instance.selectedUser.get()
      if not user
        return
      datasetId = instance.data.datasetId
      Meteor.call 'inviteUser', user._id, datasetId, (error, response) ->
        if error
          toastr.error("Error:" + error.message)
        else
          toastr.success("Success")
          $('#invite-collaborators-modal').modal('hide')
    'click .invitable-user': (event, instance) ->
      instance.selectedUser.set
        _id: $(event.target).data('id')
        fullName: $(event.target).data('fullname')
      instance.$('.invite-user-input').val($(event.target).data('fullname'))
    'keyup .invite-user-input': _.throttle((event, instance) ->
      instance.selectedUser.set null
      partialName = instance.$('.invite-user-input').val()
      filter = null
      if instance.data.datasetId
        filter = {
          memberOfDatasets:
            $ne: instance.data.datasetId
        }
      Meteor.call 'usernameAutocomplete', partialName, filter, (error, response) ->
        if error
          toastr.error("Error:" + error.message)
        else
          instance.invitableUsers.set(response)
    )
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
    usernameAutocomplete: (partialName, filter) ->
      if not filter
        filter = {}
      # Based on bobince's regex escape function.
      # source: http://stackoverflow.com/questions/3561493/is-there-a-regexp-escape-function-in-javascript/3561711#3561711
      regexEscape = (s)->
        s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&')
      if @userId
        UserProfiles.find(_.extend({
          fullName:
            $regex: regexEscape(partialName)
            $options: "i"
        }, filter), {
          limit: 5
          fields:
            emailAddress: false
        }).fetch()
      else
        throw new Meteor.Error("Not logged in")
