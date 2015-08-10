do ->
  'use strict'

  module.exports = ->

    url = require('url')

    @Before () ->
      @server.call('reset')
      @client.url(url.resolve(process.env.ROOT_URL, '/'))

    _testUser = {email: 'test@example.com', password: 'password'}

    @Given /^there is a test user in the database/, ->
      @server.call('createTestUser', _testUser)

    @When "I log in as the test user", () ->
      @client
        .url(url.resolve(process.env.ROOT_URL, '/'))
        .click('.sign-in', assert.ifError)
        .setValue('#at-field-email', _testUser.email)
        .setValue('#at-field-password', _testUser.password)
        .submitForm('#at-field-email', assert.ifError)
        .waitForExist('.sign-out')

    @When /^I navigate to "([^"]*)"$/, (relativePath) ->
      @client
        .url(url.resolve(process.env.ROOT_URL, relativePath))

    @Then /^I should( not)? see a "([^"]*)" toast$/, (noToast, message) ->
      @browser
        .waitForExist('body *')
        .getHTML '.toast', (error, response) ->
          match = response?.toString().match(message)
          if noToast
            assert.ok(error or not match)
          else
            assert.ifError(error)
            assert.ok(match)
        

    @Then /^I should( not)? see content "([^"]*)"$/, (shouldNot, text) ->
      @client
        .waitForExist('body *')
        .getHTML 'body', (error, response) ->
          match = response.toString().match(text)
          if shouldNot
            assert.notOk(match)
          else
            assert.ok(match)
        
