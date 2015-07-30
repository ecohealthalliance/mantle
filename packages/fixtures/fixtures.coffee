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
      Organizations.remove({})
      organization = new Organization()
      user = Meteor.users.findOne()
      organization.set
        name: "Test Organization"
        description: "Test Description"
        createdById: user._id
      organization.save()

    'createUserWithProfile': (attributes, profileAttributes) ->
      userId = Accounts.createUser
        email: attributes.email
        password: attributes.password
      UserProfiles.update({'userId': userId}, {$set: profileAttributes})

    'createUserInTestOrg': (attributes, profileAttributes) ->
      testOrg = Organizations.findOne()
      profileAttributes['memberOfOrgs'] = testOrg._id
      userId = Accounts.createUser
        email: attributes.email
        password: attributes.password
      UserProfiles.update({'userId': userId}, {$set: profileAttributes})
