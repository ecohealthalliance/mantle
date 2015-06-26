userProfile = new Mongo.Collection('userProfile')
UserProfile = Astro.Class
  name: 'UserProfile'
  collection: userProfile
  fields: 
    fullName: 'string'
    jobTitle: 'string'
    bio: 'string'
