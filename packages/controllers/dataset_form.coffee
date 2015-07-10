if Meteor.isClient
  Template.datasetForm.events
    'change .upload': (event, template) ->
      file = new FS.File event.target.files[0]
      file.owner = Meteor.userId()
      RawFiles.insert file, (error, fileObject) ->
        if error
          toastr.error("Error")
        else
          fields = {
            file: fileObject._id
            name: fileObject.original.name
          }
          Meteor.call 'createDataset', fields, (error, datasetId) ->
            if error
              toastr.error("Error")
            else
              toastr.success("Success")
              window.location.pathname = "/datasets/#{datasetId}"


if Meteor.isServer
  Meteor.methods
    createDataset: (fields) ->
      dataset = new Dataset()
      dataset.set(fields)
      dataset.set('createdById', @userId)
      dataset.save()