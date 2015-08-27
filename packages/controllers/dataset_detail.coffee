if Meteor.isClient
  Template.datasetDetail.onCreated ->
    @subscribe('datasetDetail', @data.datasetId)
    @parsedFile = Meteor.call('parseCsv', @data.datasetId)

  Template.datasetDetail.helpers
    dataset: ->
      Datasets.findOne(@datasetId)

    fileContents: ->
      Template.instance().parsedFile

if Meteor.isServer
  Meteor.publish 'datasetDetail', (id) ->
    dataset = Datasets.findOne
      _id: id
      createdById: @userId
    if dataset
      [Datasets.find(dataset._id), dataset.getFileCursor()]
    else
      @ready()

  Meteor.methods
    parseCsv: (datasetId) ->
      dataset = Datasets.findOne(datasetId)
      dataset.readFile()
