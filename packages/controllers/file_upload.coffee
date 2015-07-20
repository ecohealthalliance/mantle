Template.fileUpload.onCreated ->
  @fileName = new ReactiveVar('No file selected')
  @hasFile = new ReactiveVar(false)

Template.fileUpload.helpers
  fileName: ->
    Template.instance().fileName.get()
  hasFile: ->
    if Template.instance().hasFile.get()
      'has-file'

Template.fileUpload.events
  'change .btn-file': (event, template) ->
    template.fileName.set(event.target.value.replace('C:\\fakepath\\',''))
    template.hasFile.set(true)
  'click .remove': (event, template) ->
    template.hasFile.set(false)
    template.fileName.set('No file selected')
    $('input[type=file]').val('')
