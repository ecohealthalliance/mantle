do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require('url')

    @Given /^I am a new user$/, ->
      @server.call('reset')

    @When /^I navigate to "([^"]*)"$/, (relativePath, callback) ->
      @client
        .url(url.resolve(process.env.ROOT_URL, relativePath))
        .call(callback)

    registerAccount = (browser, email, callback) ->
      browser
        .url(url.resolve(process.env.ROOT_URL, '/'))
        .click('.sign-in', assert.ifError)
        .waitForExist('.accounts-modal.modal.in')
        .click('#at-signUp')
        .waitForExist('#at-field-password_again')
        .setValue('#at-field-email', email)
        .setValue('#at-field-password', 'testuser')
        .setValue('#at-field-password_again', 'testuser')
        .submitForm('#at-field-email', assert.ifError)
        .waitForExist('.sign-out')
        .call(callback)

    @Given /^I have registered an account$/, (callback) ->
      registerAccount(@browser, "test@user.com", callback)

    @When "I register an account", (callback) ->
      registerAccount(@browser, "test@user.com", callback)

    @When /^I register an account with email address "([^"]*)"$/, (email, callback) ->
      registerAccount(@browser, email, callback)

    @Then /^I should( not)? see a "([^"]*)" toast$/, (noToast, message, callback) ->
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
