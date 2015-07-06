UserProfiles = new Mongo.Collection('userProfile')
UserProfile = Astro.Class
  name: 'UserProfile'
  collection: UserProfiles
  transform: true
  fields: 
    fullName: 'string'
    jobTitle: 'string'
    bio: 'string'
    emailHidden: 'boolean'
    userId: 'string'

  methods:
    update: (fields, callback) ->
      filteredFields = _.pick(fields, 'fullName', 'jobTitle', 'bio', 'emailHidden')
      this.set(filteredFields)
      this.save ->
        callback?()

if Meteor.isServer
  Accounts.onCreateUser (options, user) ->
    profile = new UserProfile()
    profile.set(userId: user._id)
    profile.save(-> {})
    user
