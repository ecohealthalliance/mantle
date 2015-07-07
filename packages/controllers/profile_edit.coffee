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
        fullName: form.fullName?.value
        jobTitle: form.jobTitle?.value
        bio: form.bio?.value
        emailHidden: form.emailHidden?.checked
      }
      Meteor.call 'updateProfile', fields, (error, response) ->
        if error
          toastr.error("Error")
        else
          toastr.success("Success")

if Meteor.isServer
  Meteor.methods
    updateProfile: (fields) ->
      userProfile = UserProfiles.findOne({userId: this.userId})
      userProfile.update(fields)

  Meteor.publish 'currentUserProfile', ->
    UserProfiles.find({userId: this.userId})
