RawFiles = share.RawFiles

Datasets = new Mongo.Collection("datasets")

Dataset = Astro.Class
  name: 'Dataset'
  collection: Datasets
  transform: true
  fields:
    name: 'string'
    fileId: 'string'
    createdById: 'string'
  events:
    afterinsert: ->
      UserProfiles.update({
        userId: @createdById
      }, {
        $addToSet:
          adminOfDatasets: @_id
          memberOfDatasets: @_id
      })
  methods:
    file: () ->
      RawFiles.findOne(@fileId)
    userIsMember: (userId) ->
      UserProfiles.findOne({userId: userId, memberOfDatasets: @_id})
    userIsAdmin: (userId) ->
      UserProfiles.findOne({userId: userId, memberOfDatasets: @_id})
    addMember: (profileId)->
      UserProfiles.update({_id: profileId}, {
        $addToSet: {memberOfDatasets: @_id}
      })
    addAdmin: (profileId) ->
      profile = UserProfiles.findOne(profileId)
      if @userIsMember(profile.userId)
        UserProfiles.update({_id: profileId}, {
          $addToSet: {adminOfDatasets: @_id}
        })
      else
        throw new Meteor.Error('Only dataset members can be made admins')

if Meteor.isClient
  Dataset.addMethod 'uploadFile', (file, callback) ->
    fileObject = new FS.File file
    fileObject.owner = Meteor.userId()
    RawFiles.insert fileObject, (error, result) =>
      if error
        callback error
      else
        @set('fileId', result._id)
        callback()

if Meteor.isServer
  Dataset.addMethod 'getFileCursor', ->
    RawFiles.find(@fileId)