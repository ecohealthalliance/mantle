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

    'addUserWithProfile': (userAttributes, profileAttributes) ->
      userId = Accounts.createUser
        email: userAttributes.email
        password: userAttributes.password
      UserProfiles.update({'userId': userId}, {$set: profileAttributes})

    'addDataset': (attributes)->
      dataset = new Dataset(attributes)
      Meteor.wrapAsync((callback)->
        dataset.save ->
          fileObject = new FS.File()
          fileObject.owner = attributes.userId
          RawFiles.insert fileObject, (error, result) =>
            if error
              throw Meteor.Error(error)
            else
              dataset.set('fileId', result._id).save()
              callback()
      )