Organizations = new Mongo.Collection('organizations')
Organization = Astro.Class
  name: 'Organization'
  collection: Organizations
  transform: true
  fields:
    name: 'string'
    description: 'string'
    createdById: 'string'

  events:
    aftersave: ->
      if @createdById
        @addMember(@createdById)
        profile = UserProfiles.findOne({userId: @createdById})
        @addAdmin(profile._id)

  methods:
    addMember: (userId) ->
      UserProfiles.update({userId: userId}, {
        $addToSet: {memberOfOrgs: @_id}
      })
    addAdmin: (profileId) ->
      UserProfiles.update({_id: profileId}, {
        $addToSet: {adminOfOrgs: @_id}
      })
    removeAdmin: (profileId) ->
      UserProfiles.update({_id: profileId}, {
        $pull: {adminOfOrgs: @_id}
      })
    getMemberProfiles: () ->
      UserProfiles.find(memberOfOrgs: @_id)
    getNonAdminProfiles: () ->
      UserProfiles.find({memberOfOrgs: @_id, adminOfOrgs: { $nin: [@_id]}})
    getAdminProfiles: () ->
      UserProfiles.find(adminOfOrgs: @_id)

    truncateDescription: ->
      splitDescription = @description?.split(' ')
      wordCount = 50
      if splitDescription.length > wordCount
        splitDescription.slice(0,wordCount).join(' ')+'...'
      else
        @description
