if Meteor.isClient
  Template.datasetDetail.onCreated ->
    @subscribe('datasetDetail', @data.datasetId)

  Template.datasetDetail.helpers
    dataset: ->
      Datasets.findOne(@datasetId)
    members: ->
      UserProfiles.find(memberOfDatasets: @datasetId).map((member)=>
        if @datasetId in member.adminOfDatasets
          member.role = "Admin"
        else if @datasetId in member.memberOfDatasets
          member.role = "Member"
        else
          member.role = "Unknown"
        member
      )
    userIsAdmin: ->
      UserProfiles.findOne(
        adminOfDatasets: @datasetId
        userId: Meteor.userId()
      )
    
if Meteor.isServer
  Meteor.publish 'datasetDetail', (id) ->
    dataset = Datasets.findOne
      _id: id
    if dataset
      userCanAccessDataset = UserProfiles.findOne
        userId: @userId
        memberOfDatasets: dataset._id
      if userCanAccessDataset
        [
          Datasets.find(dataset._id),
          dataset.getFileCursor(),
          UserProfiles.find({
            memberOfDatasets: id
          }, {
            fields:
              emailAddress: false
          })
        ]
      else
        @ready()
    else
      @ready()
