if Meteor.isClient
  Template.profileEdit.onCreated ->
    instance = this
    subscription = instance.subscribe('userProfile')

  Template.profileEdit.helpers
    userProfile: ->
      UserProfiles.findOne()

  Template.profileEdit.events
    'submit form': (event) ->
      event.preventDefault()
      form = event.target
      fields = {
        fullName: form.fullName?.value
        jobTitle: form.jobTitle?.value
        bio: form.bio?.value
        emailHidden: form.emailHidden?.value
      }
      Meteor.call('updateProfile', fields, -> {})

if Meteor.isServer
  Meteor.methods
    updateProfile: (fields, callback) ->
      userProfile = UserProfiles.findOne({userId: this.userId})
      userProfile.update fields, callback

  Meteor.publish 'userProfile', ->
    UserProfiles.find({userId: this.userId})
