if Meteor.isClient
  Template.datasetForm.onCreated ->
    @fileName = new ReactiveVar('No file selected')
    @hasFile = new ReactiveVar(false)

  Template.datasetForm.helpers
    fileName: ->
      Template.instance().fileName.get()
    hasFile: ->
      if Template.instance().hasFile.get()
        'has-file'

  Template.datasetForm.events
    'change .btn-file': (event, template) ->
      template.fileName.set(event.target.value.replace('C:\\fakepath\\',''))
      template.hasFile.set(true)
    'click .remove': (event, template) ->
      template.hasFile.set(false)
      template.fileName.set('No file selected')
      $('input[type=file]').val('')
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
