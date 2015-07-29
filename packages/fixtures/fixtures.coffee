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
      UserProfiles.insert(attributes)

    'createTestOrg': ->
      organization = new Organization()
      user = Meteor.users.findOne()
      organization.set
        name: "Test Organization"
        createdById: user._id
        description: "None"
        _id: "fakeorgid"
      organization.save()
