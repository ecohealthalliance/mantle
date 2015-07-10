if Meteor.isClient
  Template.datasetForm.events
    'submit form': (event, template) ->
      event.preventDefault()
      file = new FS.File event.target.file?.files[0]
      file.owner = Meteor.userId()
      RawFiles.insert file, (error, fileObject) ->
        if error
          toastr.error("Error")
        else
          fields = {
            file: fileObject._id
            name: event.target.name?.value
          }
          Meteor.call 'createDataset', fields, (error, datasetId) ->
            if error
              toastr.error("Error")
            else
              toastr.success("Success")
              go "datasetDetail", {_id: datasetId}


if Meteor.isServer
  Meteor.methods
    createDataset: (fields) ->
      dataset = new Dataset()
      dataset.set(fields)
      dataset.set('createdById', @userId)
      dataset.save()