do ->

  'use strict'

  Meteor.methods

    'reset': ->
      Meteor.users.remove({})
      UserProfiles.remove({})
      Organizations.remove({})

    'createTestUser': (attributes) ->
      Meteor.users.remove({})
      Accounts.createUser
        email: attributes.email
        password: attributes.password

    'createProfile': (field, value, id) ->
      attributes = {}
      attributes[field] = value
      attributes['_id'] = id
      UserProfiles.insert attributes
