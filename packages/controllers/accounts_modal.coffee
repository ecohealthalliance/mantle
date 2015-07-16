AccountsTemplates.configure
  showPlaceholders: false
  onSubmitHook: (err)->
    unless err
      $('.accounts-modal').modal('hide')
      # sign in fields are cleared so they don't remain populated after a logout
      $('.accounts-modal input').val("")

Template.accountsModal.onCreated ->
  @state = Template.currentData()?.state

Template.accountsModal.helpers
  state: -> Template.instance().state.get()

Template.accountsModal.events
  'click #at-signUp' : (evt, instance)->
    instance.state.set("signUp")
  'click #at-signIn' : (evt, instance)->
    instance.state.set("signIn")
