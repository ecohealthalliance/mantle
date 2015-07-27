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

    'createProfile': (attributes) ->
      UserProfiles.insert attributes

    'createTestOrg': ->
      Organizations.insert
        name: "Test Organization"
        createdById: "fakeid"
        description: "None"
        _id: 'fakeorgid'
