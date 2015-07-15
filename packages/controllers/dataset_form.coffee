if Meteor.isClient
  Template.datasetForm.events
    'submit form': (event, template) ->
      event.preventDefault()
      file = event.target.file?.files[0]
      unless file
        toastr.error("Error")
      else
        dataset = new Dataset()
        dataset.set 'name', event.target.name?.value
        dataset.uploadFile file, (error) ->
          if error
            toastr.error("Error")
          else
            Meteor.call "saveDataset", dataset, (error, datasetId) ->
              if error
                toastr.error("Error")
              else
                toastr.success("Success")
                go "datasetDetail", {_id: datasetId}


if Meteor.isServer
  Meteor.methods
    saveDataset: (dataset) ->
      dataset.set('createdById', @userId)
      dataset.save ->
        dataset._id