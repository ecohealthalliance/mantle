do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require('url')

    @When "I click the new organization link", (callback) ->
      @browser
        .waitForExist('.organizations-table')
        .click('.new-organization-link', assert.ifError)
        .waitForExist('#new-organization-form')
        .call(callback)

    @When /^I fill out the new organization form with name "([^"]*)"$/, (name, callback) ->
      @browser
        .waitForExist('#new-organization-form')
        .setValue('#organization-name', name)
        .setValue('#organization-description', 'This is an organization.')
        .submitForm('#new-organization-form', assert.ifError)
        .call(callback)

    @When /^I click on the organization link$/, (callback) ->
      @browser
        .waitForVisible('.organizations-table', assert.ifError)
        .click(".organizations-table a", assert.ifError)
        .waitForVisible('.organization-detail', assert.ifError)
        .call(callback)

    @Then /^I should be on the "([^"]*)" detail page$/, (name, callback) ->
      @browser
        .waitForVisible('.organization-detail', assert.ifError)
        .call(callback)

    @Then /^I see that I am a member of the organization$/, (callback) ->
      @browser
        .waitForVisible('td.name', 4000, assert.ifError)
        .getHTML 'td.name', (error, response) ->
          assert.ifError(error)
          match = response.toString().match("Micky Mouse")
          assert.ok(match)
        .call(callback)

    @Given 'there is an organization in the database with name "$name"', (name) ->
      @server.call('createTestOrg', name)

    @When 'I click on "Join"', (callback) ->
      @browser
        .waitForVisible('.join-organization', assert.ifError)
        .click('.join-organization', assert.ifError)
        .call(callback)