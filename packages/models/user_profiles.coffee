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
      this.set(fields)
      this.save ->
        callback()
