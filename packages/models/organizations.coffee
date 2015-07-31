Organizations = new Mongo.Collection('organizations')
Organizations.allow
  insert: (userId, doc)  ->
    false
  update: (userId, doc, fields, modifier) ->
    false
  remove: (userId, doc) ->
    false
Organization = Astro.Class
  name: 'Organization'
  collection: Organizations
  transform: true
  fields:
    name:
      type: 'string'
      validators: [
        Validators.unique(null, "There is already an organization with that name")
        Validators.string()
      ]
    description:
      type: 'string'
      validators: [
        Validators.string()
      ]
    createdById:
      type: 'string'
      validators: [
        Validators.string()
      ]

  events:
    aftersave: ->
      if @createdById
        profile = UserProfiles.findOne({userId: @createdById})
        @addMember(profile._id)
        @addAdmin(profile._id)

  methods:
    getMemberProfiles: () ->
      UserProfiles.find(memberOfOrgs: @_id)
    getNonAdminProfiles: () ->
      UserProfiles.find({memberOfOrgs: @_id, adminOfOrgs: { $nin: [@_id]}})
    getAdminProfiles: () ->
      UserProfiles.find(adminOfOrgs: @_id)

    userIsAdmin: (userId) ->
      UserProfiles.findOne({userId: userId, adminOfOrgs: @_id})

    truncateDescription: ->
      splitDescription = @description?.split(' ')
      wordCount = 50
      if splitDescription.length > wordCount
        splitDescription.slice(0,wordCount).join(' ')+'...'
      else
        @description

if Meteor.isServer
  Organization.addMethod 'addMember', (profileId)->
    UserProfiles.update({_id: profileId}, {
      $addToSet: {memberOfOrgs: @_id}
    })
  Organization.addMethod 'addAdmin', (profileId) ->
    UserProfiles.update({_id: profileId}, {
      $addToSet: {adminOfOrgs: @_id}
    })
  Organization.addMethod 'removeAdmin', (profileId) ->
    UserProfiles.update({_id: profileId}, {
      $pull: {adminOfOrgs: @_id}
    })
