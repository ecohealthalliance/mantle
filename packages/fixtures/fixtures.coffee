do ->

  'use strict'

  Meteor.methods

    'reset': ->
      Meteor.users.remove({})
      UserProfiles.remove({})
      Organizations.remove({})
      Datasets.remove({})

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

    'createOrg': (attributes) ->
      Organizations.insert attributes

    'addDataset': (attributes)->
      dataset = new Dataset()
      dataset.set(attributes)
      dataset.save()

    'addUserToOrg': (fullName, orgName)->
      UserProfiles.update({
        'fullName': fullName
      }, {
        $addToSet:
          memberOfOrgs: Organizations.findOne(name: orgName)._id
      })
