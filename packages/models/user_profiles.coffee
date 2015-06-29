UserProfiles = new Mongo.Collection('userProfile')
UserProfile = Astro.Class
  name: 'UserProfile'
  collection: UserProfiles
  fields: 
    fullName: 'string'
    jobTitle: 'string'
    bio: 'string'
    emailHidden: 'boolean'
    userId: 'string'
