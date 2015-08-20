do ->
  'use strict'

  module.exports = ->

    url = require('url')

    @When "I see the not_found page", (callback) ->
      @browser
        .waitForVisible('h4.not-found ', assert.ifError)
        .call(callback)