if Meteor.isClient
  Template.profileEdit.onCreated ->
    instance = this
    subscription = instance.subscribe('userProfile')

    if subscription.ready()
      console.log("Ready")
    else
      console.log("Not ready")

  Template.profileEdit.helpers
    userProfile: ->
      UserProfiles.findOne()

  Template.profileEdit.events
    'submit form': (event) ->
      event.preventDefault()
      form = event.target
      fields = {
        bio: form.bio.value
      }
      Meteor.call('updateProfile', form.profileId.value, fields, -> {})

if Meteor.isServer
  Meteor.methods
    updateProfile: (profileId, fields, callback) ->
      userProfile = UserProfiles.findOne({_id: profileId})
      userProfile.update fields, ->
        console.log(userProfile)

  Meteor.publish 'userProfile', ->
    UserProfiles.find({userId: this.userId})
