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
    name: 'string'
    description: 'string'
    createdById: 'string'
  methods:
    getMemberProfiles: () ->
      UserProfiles.find(memberOfOrgs: @_id)
    truncateDescription: ->
      splitDescription = @description?.split(' ')
      wordCount = 50
      if splitDescription.length > wordCount
        splitDescription.slice(0,wordCount).join(' ')+'...'
      else
        @description

if Meteor.isServer
  Organization.addMethod 'addMember', (userId)->
    UserProfiles.update({userId: userId}, {
      $addToSet: {memberOfOrgs: @_id}
    })