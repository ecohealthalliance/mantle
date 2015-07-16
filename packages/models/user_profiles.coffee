UserProfiles = new Mongo.Collection('userProfile')
UserProfile = Astro.Class
  name: 'UserProfile'
  collection: UserProfiles
  transform: true
  fields:
    firstName: 'string'
    lastName: 'string'
    emailAddress: 'string'
    organization: 'string'
    jobTitle: 'string'
    bio: 'string'
    emailHidden: 'boolean'
    userId: 'string'
    emailAddress: 'string'

  methods:
    update: (fields, callback) ->
      filteredFields = _.pick(fields, 'firstName','lastName', 'emailAddress', 'organization', 'jobTitle', 'bio', 'emailHidden')
      this.set(filteredFields)
      this.save ->
        callback?()

if Meteor.isServer
  Accounts.onCreateUser (options, user) ->
    profile = new UserProfile()
    userInfo = _.extend({userId: user._id}, options?.profile)
    profile.set(userInfo)
    profile.save(-> {})
    user
