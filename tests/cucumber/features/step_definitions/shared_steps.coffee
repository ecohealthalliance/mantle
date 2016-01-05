do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require 'url'

    _test_document =
      _id:   "fakedocumentid"
      title: "Test Document"
      body:  "This is a doc for testing"

    _testUser =
      email:    'test@example.com'
      password: 'password'


    @Before (callback) ->
      @server.call('reset')
      @client.url(url.resolve(process.env.ROOT_URL, '/'))
        .execute (->
          Meteor.logout()
        ), callback

    @Given 'there is a test user in the database', ->
      @server.call('createTestUser', _testUser)

    @Given 'there is a group in the database', ->
      @server.call('createTestGroup')

    @Given 'there is a test document in the database', ->
      @server.call('createTestDocument', _test_document)

    @Given /^there is an annotation with codingKeyword header "([^"]*)", subHeader "([^"]*)" and key "([^"]*)"$/, (header, subHeader, keyword) ->
      that = @
      @server
        .call('createCodingKeyword', header, subHeader, keyword, 1)
        .then (codeId) ->
          that.server.call('createTestAnnotation', {codeId: codeId})
          codeId

    @Given 'there is a group in the database with id "$id"', (id)->
      @server.call('createTestGroup', _id: id)

    @When "I log in as the test user", ->
      @client
        .url(url.resolve(process.env.ROOT_URL, '/'))
        .waitForExist('.sign-in')
        .click('.sign-in')
        .waitForVisible('.page-wrap #at-pwd-form')
        .setValue('.page-wrap #at-field-email', _testUser.email)
        .setValue('.page-wrap #at-field-password', _testUser.password)
        .submitForm('.page-wrap #at-field-email')
        .waitForExist('.sign-out')

    @When "I log in as the non-admin test group user", ->
      @client
        .url(url.resolve(process.env.ROOT_URL, '/'))
        .waitForExist('.sign-in')
        .click('.sign-in')
        .waitForVisible('.page-wrap #at-pwd-form')
        .setValue('#at-field-email', _nonAdminTestUser.email)
        .setValue('#at-field-password', _nonAdminTestUser.password)
        .submitForm('#at-field-email')
        .waitForExist('.sign-out')

    @When /^I navigate to "([^"]*)"$/, (relativePath) ->
      @client
        .url(url.resolve(process.env.ROOT_URL, relativePath))

    @When 'I navigate to the admin page', ->
      @client
        .waitForExist('a[href="/admin"]')
        .click('a[href="/admin"]')

    @Then /^I should see the "([^"]*)" link highlighted in the header$/,
    (linkText) ->
      @client
        .waitForExist('.navbar-nav')
        .getHTML('.navbar-nav .active', (error, response) ->
          match = response?.toString().match(linkText)
          assert.ok(match)
        )

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
