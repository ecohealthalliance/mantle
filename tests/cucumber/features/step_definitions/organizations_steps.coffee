do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require('url')

    @Given "there is a user with full name $name who belongs to the test organization", (name) ->
      @server.call('createProfile', {fullName: name})

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
        .pause(1000)
        .waitForVisible('.organizations-table', assert.ifError)
        .click(".organizations-table a", assert.ifError)
        .waitForVisible('.organization-detail', assert.ifError)
        .call(callback)

    @Then /^I should be on the "([^"]*)" detail page$/, (name, callback) ->
      @browser
        .waitForVisible('.organization-detail', assert.ifError)
        .call(callback)

    checkMembership = (browser, emailOrName, role, callback) ->
      browser
        .pause(1000)
        .waitForVisible('td.name', assert.ifError)
        .getHTML 'tr', (error, response) ->
          assert.ifError(error)
          match = _.any response, (row) =>
            identifierMatch = row.toString().match(emailOrName)
            roleMatch = row.toString().match(role)
            identifierMatch and roleMatch
          assert.ok(match)
        .call(callback)

    @Then /^I see that "([^"]*)" is a member of the organization$/, (emailOrName, callback) ->
      checkMembership(@browser, emailOrName, "Member", callback)

    @Then /^I see that "([^"]*)" is an admin of the organization$/, (emailOrName, callback) ->
      checkMembership(@browser, emailOrName, "Admin", callback)

    @Given 'there is an organization in the database created by the test user', ->
      @server.call('createTestOrg')

    @Given /^there is a profile with full name "([^"]*)" that belongs to the test organization$/, (fullName) ->
      @server.call('createProfile', {fullName: fullName, memberOfOrgs: ['fakeorgid']})

    @When 'I click on "Join"', (callback) ->
      @browser
        .waitForVisible('.join-organization', assert.ifError)
        .click('.join-organization', assert.ifError)
        .call(callback)
