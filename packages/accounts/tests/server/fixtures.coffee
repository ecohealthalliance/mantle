Meteor.methods(
  "createTestUser": (email, password) ->
    Accounts.createUser({email: email, password: password})

  "clearUsers": () ->
    Meteor.users.remove({})

)