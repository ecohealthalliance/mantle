do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require('url')

    @Before (callback) ->
      @server.call('reset')
      @client.url(url.resolve(process.env.ROOT_URL, '/'), callback)

    _testUser = {email: 'test@example.com', password: 'password'}

    @Given /^there is a test user in the database/, ->
      @server.call('createUserWithProfile', _testUser, {fullName: 'Test User'})

    @Given '"$name" is an user', (name)->
      @server.call('createUserWithProfile', {
        email: name.split(" ").join(".").toLocaleLowerCase() + "@email"
        password: name.toLocaleLowerCase()
      }, {
        fullName: name
      })

    @When "I log in as the test user", (callback) ->
      @client
        .url(url.resolve(process.env.ROOT_URL, '/'))
        .waitForExist('.sign-in')
        .click('.sign-in', assert.ifError)
        .setValue('#at-field-email', _testUser.email)
        .setValue('#at-field-password', _testUser.password)
        .submitForm('#at-field-email', assert.ifError)
        .waitForExist('.sign-out', assert.ifError)
        .call(callback)

    @When /^I navigate to "([^"]*)"$/, (relativePath, callback) ->
      @client
        .url(url.resolve(process.env.ROOT_URL, relativePath))
        .call(callback)

    @Then /^I should( not)? see an? "([^"]*)" toast$/, (noToast, message, callback) ->
      @browser
        .waitForVisible('body *')
        .getHTML('.toast', (error, response) ->
          match = response?.toString().match(message)
          if noToast
            assert.ok(error or not match)
          else
            assert.ifError(error)
            assert.ok(match)
        ).call(callback)

    @Then /^I should( not)? see content "([^"]*)"$/, (shouldNot, text, callback) ->
      @client
        .waitForVisible('body *')
        .getHTML 'body', (error, response) ->
          match = response.toString().match(text)
          if shouldNot
            assert.notOk(match)
          else
            assert.ok(match)
        .call(callback)

    @When 'I log out', ->
      @client
        .waitForVisible('.admin-settings')
        .click('.admin-settings')
        .waitForVisible('.sign-out')
        .click('.sign-out')

    @When 'I log in as "$name"', (name) ->
      @client
        .url(url.resolve(process.env.ROOT_URL, '/'))
        .waitForExist('.sign-in')
        .click('.sign-in')
        .setValue('#at-field-email', name.split(" ").join(".").toLocaleLowerCase() + "@email")
        .setValue('#at-field-password', name.toLocaleLowerCase())
        .submitForm('#at-field-email')
        # The next waitForVisible will timeout if there is no pause here.
        .pause(100)
        .waitForVisible('.my-datasets-link')

    @Given '"$name" is in the "$org" organization', (name, org)->
      @server.call('addUserToOrg', name, org)
