Template.fileInput.onCreated ->
  @fileName = new ReactiveVar()

Template.fileInput.helpers
  fileName: ->
    Template.instance().fileName.get()

Template.fileInput.events
  'change .btn-file': (event, template) ->
    template.fileName.set(event.target.value.replace('C:\\fakepath\\','')) # Remove path automatically added by browser
  'click .remove': (event, template) ->
    template.fileName.set('')
    $('.upload').val('')
