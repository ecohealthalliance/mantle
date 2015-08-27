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
    emailAddress: 'string'
    # Organization membership is tracked in the user profile because it
    # makes it possible to subscribe to all the profiles used by an org
    # using only the org id.
    memberOfOrgs:
      type: 'array'
      'default': []
    adminOfOrgs:
      type: 'array'
      'default': []
    adminOfDatasets:
      type: 'array'
      'default': []

  methods:
    update: (fields, callback) ->
      filteredFields = _.pick(fields, 'fullName', 'jobTitle', 'bio', 'emailHidden')
      this.set(filteredFields)
      this.save ->
        callback?()

if Meteor.isServer
  Accounts.onCreateUser (options, user) ->
    profile = new UserProfile()
    profile.set({userId: user._id, emailAddress: user.emails[0].address})
    profile.save(-> {})
    user
