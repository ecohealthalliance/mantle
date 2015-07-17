Template.registerHelper 'paragraphs', (text) ->
  text?.split(/\r?\n\n/g)
