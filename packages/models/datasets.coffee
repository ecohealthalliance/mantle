Datasets = new Mongo.Collection("datasets")

Dataset = Astro.Class
  name: 'Dataset'
  collection: Datasets
  transform: true
  fields:
    name: 'string'
    fileId: 'string'
    createdById: 'string'

  methods:
    file: () ->
      RawFiles.findOne(@fileId)


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