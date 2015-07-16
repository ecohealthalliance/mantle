if Meteor.isClient
  Template.datasetDetail.onCreated ->
    @subscribe('datasetDetail', @data.datasetId)

  Template.datasetDetail.helpers
    dataset: ->
      Datasets.findOne(@datasetId)

if Meteor.isServer
  Meteor.publish 'datasetDetail', (id) ->
    dataset = Datasets.findOne
      _id: id
      createdById: @userId
    if dataset
      [Datasets.find(dataset._id), dataset.getFileCursor()]
    else
      @ready()