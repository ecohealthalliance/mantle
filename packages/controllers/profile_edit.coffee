if Meteor.isClient
  Template.profileEdit.onCreated ->
    @subscribe('currentUserProfile')

  Template.profileEdit.helpers
    userProfile: ->
      UserProfiles.findOne({userId: Meteor.userId()})

  Template.profileEdit.events
    'submit form': (event) ->
      event.preventDefault()
      form = event.target
      fields = {
        firstName: form.firstName?.value
        lastName: form.lastName?.value
        emailAddress: form.emailAddress?.value
        jobTitle: form.jobTitle?.value
        organization: form.organization?.value
        bio: form.bio?.value
        emailHidden: form.emailHidden?.checked
      }
      Meteor.call 'updateProfile', fields, (error, response) ->
        if error
          toastr.error("Error")
        else
          toastr.success("Success")
          FlowRouter.go("/profiles/"+UserProfiles.findOne({userId: Meteor.userId()})._id)

if Meteor.isServer
  Meteor.methods
    updateProfile: (fields) ->
      userProfile = UserProfiles.findOne({userId: @userId})
      userProfile.update(fields)
      Meteor.users.update({_id: @userId}, {$set:{'emails':[{'address':fields.emailAddress}]}})

  Meteor.publish 'currentUserProfile', ->
    UserProfiles.find({userId: @userId})
