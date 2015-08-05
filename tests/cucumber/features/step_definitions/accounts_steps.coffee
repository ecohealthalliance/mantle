do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require('url')

    @Given /^there is a profile with ID 'fakeid' where "([^"]*)" is "([^"]*)"$/, (field, value)->
      @server.call('createProfile', field, value, 'fakeid')

    registerAccount = (browser, email) ->
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

    @Given /^I have registered an account$/, () ->
      registerAccount(@browser, "test@user.com")

    @When "I register an account", () ->
      registerAccount(@browser, "test@user.com")

    @When /^I register an account with email address "([^"]*)"$/, (email) ->
      registerAccount(@browser, email)

    @When 'I open the account modal', () ->
      @browser
        .waitForExist('.sign-in')
        .click('.sign-in', assert.ifError)
        .waitForExist('.accounts-modal.modal.in')

    @When 'I fill out the new account form', () ->
      @browser
        .click('#at-signUp')
        .waitForExist('#at-field-password_again')
        .setValue('#at-field-email', 'test@user.com')
        .setValue('#at-field-password', 'testuser')
        .setValue('#at-field-password_again', 'testuser')
        .submitForm('#at-field-email', assert.ifError)
        .waitForExist('.sign-out')

    @When "I hide my email address from my profile", () ->
      @browser
        .url(url.resolve(process.env.ROOT_URL, '/profile/edit'))
        .waitForExist('#edit-profile-form')
        .click("#profile-email-hidden")
        .submitForm('#profile-fullname', assert.ifError)

    @When /^I fill out the profile edit form with fullName "([^"]*)"$/, (fullName) ->
      @browser
        .url(url.resolve(process.env.ROOT_URL, '/profile/edit'))
        .waitForExist('#edit-profile-form')
        .setValue('#profile-fullname', fullName)
        .setValue('#profile-jobtitle', 'User Tester')
        .setValue('#profile-bio', 'I am a test user')
        .click("#profile-email-hidden")
        .submitForm('#profile-fullname', assert.ifError)

    @When /^I view my public profile$/, () ->
      @browser
        .url(url.resolve(process.env.ROOT_URL, '/profile/edit'))
        .waitForExist('#edit-profile-form')
        .click('.profile-detail-link')
        .waitForExist('.profile-detail')

    @Then /I am( not)? logged in/, (amNot) ->
      @browser
        .execute((->
          Meteor.userId()
        ), (err, ret) ->
          assert.ifError(err)
          if amNot
            assert.equal(ret.value, null, 'Authenticated')
          else
            assert(ret.value, 'Not authenticated')
        )
