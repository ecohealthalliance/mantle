Organizations = new Mongo.Collection('organizations')
Organization = Astro.Class
  name: 'Organization'
  collection: Organizations
  transform: true
  fields:
    name: 'string'
    description: 'string'
    createdById: 'string'
    members: 'array'
  methods:
    getMemberProfiles: () ->
      UserProfiles.find({
        userId: {$in: @members or []}
      })
