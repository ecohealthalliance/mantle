do ->

  'use strict'

  Meteor.methods

    'reset': ->
      Meteor.users.remove({})
