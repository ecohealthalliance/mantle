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

    'createProfile': (field, value, id) ->
      attributes = {}
      attributes[field] = value
      attributes['_id'] = id
      UserProfiles.insert attributes

    'addUserWithProfile': (userAttributes, profileAttributes) ->
      userId = Accounts.createUser
        email: userAttributes.email
        password: userAttributes.password
      UserProfiles.update({'userId': userId}, {$set: profileAttributes})

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
