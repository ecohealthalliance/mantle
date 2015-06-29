if Meteor.isClient
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
      userProfile.update(fields, ->
        console.log(userProfile)
      )
