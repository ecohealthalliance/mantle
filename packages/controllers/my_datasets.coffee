if Meteor.isClient
  Template.myDatasets.onCreated ->
    @subscribe('myDatasets')
    @subscribe('myProfile')

  Template.myDatasets.helpers
    myDatasetsCollection: ->
      Datasets.find
        createdById: Meteor.userId()

    myDatasetsTableSettings: ->
      noDataTmpl: Template.noDatasets
      showRowCount: true
      fields: [
        {
          key: 'name'
          label: 'Name'
          fn:(val, object) ->
            new Spacebars.SafeString("""
            <a class="dataset-link" href="/datasets/#{object._id}" data-name="#{val}">
            #{val}
            </a>
            """)
        }
      ]

    mySharedDatasetsCollection: ->
      userProfile = UserProfiles.findOne
        userId: Meteor.userId()
      datasetIds = (userProfile?.adminOfDatasets or []).concat(
        userProfile?.memberOfDatasets or []
      )
      Datasets.find
        _id:
          $in: datasetIds
        createdById: { $not: Meteor.userId() }

    mySharedDatasetsTableSettings: ->
      noDataTmpl: Template.noDatasets
      showRowCount: true
      fields: [
        {
          key: 'name'
          label: 'Name'
          fn:(val, object) ->
            new Spacebars.SafeString("""
            <a class="dataset-link" href="/datasets/#{object._id}" data-name="#{val}">
            #{val}
            </a>
            """)
        },
        {
          key: ''
          label: 'Role'
          fn:(val, object) ->
            console.log object
            if object.userIsMember(Meteor.userId())
              "Member"
            else if object.userIsAdmin(Meteor.userId())
              "Admin"
            else
              "Unknown"
        }
      ]

if Meteor.isServer
  Meteor.publish 'myProfile', ->
    UserProfiles.find
      userId: @userId
  Meteor.publish 'myDatasets', ->
    userProfile = UserProfiles.findOne
      userId: @userId
    datasetIds = (userProfile?.adminOfDatasets or []).concat(
      userProfile?.memberOfDatasets or []
    )
    Datasets.find
      $or: [
        _id:
          $in: datasetIds
      ,
        createdById: @userId
      ]
