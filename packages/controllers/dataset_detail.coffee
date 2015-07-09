if Meteor.isClient
  Template.datasetDetail.onCreated ->
    @subscribe('datasetDetail', @data.datasetId)

  Template.datasetDetail.helpers
    dataset: ->
      Datasets.findOne(@datasetId)

    file: (id) ->
      RawFiles.findOne id

if Meteor.isServer
  Meteor.publish 'datasetDetail', (id) ->
    dataset = Datasets.findOne
      _id: id
      createdById: @userId
    if dataset
      [Datasets.find(dataset._id), RawFiles.find(dataset.file)]
    else
      @ready()