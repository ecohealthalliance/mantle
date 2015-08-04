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
      (Meteor.wrapAsync((callback)->
        dataset.save ->
          fileObject = new FS.File()
          fileObject.name("test")
          fileObject.owner = attributes.createdById
          callback()
          # Inserting the file results in errors like this:
          # "Error: 55ba38ae835506d61cce6500 does not exist"
          # The file is not necessary at the moment, so I commented
          # the code out. I left the code here because it might be useful
          # for future tests.
          #RawFiles.insert fileObject, (error, result) =>
            #if error
              #throw Meteor.Error(error)
            #else
              #dataset.set('fileId', result._id).save()
              #callback()
      )())
