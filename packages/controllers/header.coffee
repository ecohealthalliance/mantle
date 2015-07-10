Template.header.onCreated ->
  @state = new ReactiveVar("signIn")

Template.header.helpers
  state: -> Template.instance().state
