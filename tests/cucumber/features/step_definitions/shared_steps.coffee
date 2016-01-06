do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require 'url'

    @Before (callback) ->
      @server.call('reset')
      @client.url(url.resolve(process.env.ROOT_URL, '/'))
      @client.execute (->
          Meteor.logout()
        ), callback

    @When /^I navigate to "([^"]*)"$/, (relativePath) ->
      @client
        .url(url.resolve(process.env.ROOT_URL, relativePath))

    @Then /^I should( not)? see a "([^"]*)" toast$/, (noToast, message) ->
      @browser
        .waitForVisible('.toast')
        # This causes a warning if no toast is visible
        .getHTML('.toast', (error, response) ->
          match = response?.toString().match(message)
          if noToast
            assert.ok(error or not match)
          else
            assert.ifError(error)
            assert.ok(match)
        )

    @Then 'I should see an error toast', ->
      @browser
        .waitForVisible '.toast-error'

    @Then /^I should( not)? see content "([^"]*)"$/, (shouldNot, text) ->
      @client
        .pause 8000 # Give Meteor enough time to populate the <body>
        .getHTML 'body', (error, html) ->
          match = html?.toString().match(text)
          if shouldNot
            assert.notOk(match)
          else
            assert.ok(match)
