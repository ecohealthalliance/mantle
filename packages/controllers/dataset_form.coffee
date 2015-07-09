if Meteor.isClient
  Template.datasetForm.events
    'change .upload': (event, template) ->
      file = event.target.files[0]
      RawFiles.insert file, (error, fileObject) ->
        console.log fileObject
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