if Meteor.isClient
  Template.myDatasets.onCreated ->
    @subscribe('myDatasets')
    @subscribe('myProfile')

  Template.myDatasets.helpers
    myDatasetsCollection: ->
      userProfile = UserProfiles.findOne
        userId: Meteor.userId()
      Datasets.find
        _id:
          $in: userProfile?.adminOfDatasets or []

    myDatasetsTableSettings: ->
      noDataTmpl: Template.noDatasets
      showRowCount: true
      fields: [
        {
          key: 'name'
          label: 'Name'
          fn:(val, object) ->
            new Spacebars.SafeString("""
            <a class="dataset-link" href="/datasets/#{object._id}">
            #{val}
            </a>
            """)
        }
      ]

if Meteor.isServer
  Meteor.publish 'myProfile', ->
    UserProfiles.find
      userId: @userId
  Meteor.publish 'myDatasets', ->
    userProfile = UserProfiles.findOne
      userId: @userId
    Datasets.find
      _id:
        $in: userProfile?.adminOfDatasets or []
