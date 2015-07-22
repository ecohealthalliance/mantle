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

    'createTestUserWithProfile': (attributes, profileAttributes) ->
      Meteor.users.remove({})
      UserProfiles.remove({})
      userId = Accounts.createUser
        email: attributes.email
        password: attributes.password
      UserProfiles.update({'userId': userId}, {$set: profileAttributes})

    'createProfile': (field, value, id) ->
      attributes = {}
      attributes[field] = value
      attributes['_id'] = id
      UserProfiles.insert attributes

    'createTestOrg': (name) ->
      Organizations.insert
        name: name
        createdById: "fakeid"
        description: "None"
