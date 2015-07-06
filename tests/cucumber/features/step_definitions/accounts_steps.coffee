do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require('url')

    @Given /^I am a new user$/, ->
      @server.call('reset')

    @Given /^there is a profile in the database where "([^"]*)" is "([^"]*)"$/, (field, value)->
      @server.call('createProfile', field, value)

    @When /^I navigate to "([^"]*)"$/, (relativePath, callback) ->
      @client
        .url(url.resolve(process.env.ROOT_URL, relativePath))
        .call(callback)

    @Then /^I should see content "([^"]*)"$/, (text, callback) ->
      @client
        .waitForVisible('body *')
        .getHTML 'header', (error, response) ->
          assert.ok(response.toString().match(text))
        .call(callback)

    @Then /I am( not)? logged in/, (amNot, callback) ->
      @browser
        .execute((->
          Meteor.userId()
        ), (err, ret) ->
          assert.ifError(err)
          if amNot
            assert.equal(ret.value, null, 'Authenticated')
          else
            assert(ret.value, 'Not authenticated')
        ).call(callback)

    @When 'I open the account modal', (callback) ->
      @browser
        .click('.sign-in', assert.ifError)
        .waitForExist('.accounts-modal.modal.in')
        .call(callback)

    @When 'I fill out the new account form', (callback) ->
      @browser
        .click('#at-signUp')
        .waitForExist('#at-field-password_again')
        .setValue('#at-field-email', 'test' + Math.floor(Math.random() * 100) + '@user.com')
        .setValue('#at-field-password', 'testuser')
        .setValue('#at-field-password_again', 'testuser')
        .submitForm('#at-field-email', assert.ifError)
        .waitForExist('.sign-out')
        .call(callback)

    @When 'I register an account', (callback) ->
      @browser
        .url(url.resolve(process.env.ROOT_URL, '/'))
        .click('.sign-in', assert.ifError)
        .waitForExist('.accounts-modal.modal.in')
        .click('#at-signUp')
        .waitForExist('#at-field-password_again')
        .setValue('#at-field-email', 'test@user.com')
        .setValue('#at-field-password', 'testuser')
        .setValue('#at-field-password_again', 'testuser')
        .submitForm('#at-field-email', assert.ifError)
        .waitForExist('.sign-out')
        .call(callback)

    @When 'I fill out the profile edit form', (callback) ->
      @browser
        .url(url.resolve(process.env.ROOT_URL, '/profile/edit'))
        .waitForExist('#profile-edit-form')
        .setValue('#profile-fullname', 'Test User')
        .setValue('#profile-jobtitle', 'User Tester')
        .setValue('#profile-bio', 'I am a test user')
        .click("#profile-email-hidden")
        .submitForm('#profile-fullname', assert.ifError)
        .call(callback)

    @Then "I should see the profile test attributes", (callback) ->
      @browser
        .call(callback)

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
