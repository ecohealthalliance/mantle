Organizations = new Mongo.Collection('organizations')
Organization = Astro.Class
  name: 'Organization'
  collection: Organizations
  transform: true
  fields:
    name: 'string'
    description: 'string'
    createdById: 'string'
  methods:
    addMember: (userId) ->
      UserProfiles.update({userId: userId}, {
        $addToSet: {memberOfOrgs: @_id}
      })
    getMemberProfiles: () ->
      UserProfiles.find(memberOfOrgs: @_id)
