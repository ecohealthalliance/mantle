do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require('url')

    @When /^I create an organization with name "([^"]*)"$/, (name, callback) ->
      @browser
        .url(url.resolve(process.env.ROOT_URL, '/organizations/new'))
        .waitForExist('#new-organization-form')
        .setValue('#organization-name', name)
        .setValue('#organization-description', 'This is an organization.')
        .submitForm('#new-organization-form', assert.ifError)
        .call(callback)

    @When /^I change the organization name to "([^"]*)"$/, (name, callback) ->
      @browser
        .waitForExist('.organization-detail', assert.ifError)
        .click(".edit-name-button", assert.ifError)
        .setValue('#organization-name', name)
        .click(".save-name-button", assert.ifError)
        .call(callback)

    @When /^I change the organization description to "([^"]*)"$/, (description, callback) ->
      @browser
        .waitForExist('.organization-detail', assert.ifError)
        .click(".edit-description-button", assert.ifError)
        .setValue('#organization-description', description)
        .click(".save-description-button", assert.ifError)
        .call(callback)

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

    @Then /^I see that "([^"]*)" is a member of the organization$/, (emailOrName, callback) ->
      @browser
        .pause(1000)
        .waitForVisible('td.name', assert.ifError)
        .getHTML 'tr.member-row', (error, response) ->
          assert.ok(response?.match(emailOrName))
        .call(callback)

    @Then /^I see that "([^"]*)" is an admin of the organization$/, (emailOrName, callback) ->
      @browser
        .pause(1000)
        .waitForVisible('td.name', assert.ifError)
        .getHTML 'tr.admin-row', (error, response) ->
          assert.ok(response?.toString().match(emailOrName))
        .call(callback)

    @Given 'there is an organization in the database created by the test user', ->
      @server.call('createTestOrg')

    @Given /^there is a profile with full name "([^"]*)" that belongs to the test organization$/, (fullName) ->
      @server.call('createProfile', {fullName: fullName, memberOfOrgs: ['fakeorgid']})

    @When 'I click on "Join"', (callback) ->
      @browser
        .waitForVisible('.join-organization', assert.ifError)
        .click('.join-organization', assert.ifError)
        .call(callback)

    @When 'I make $name an admin', (name, callback) ->
      @browser
        .waitForVisible('td.name', assert.ifError)
        .click('tr .make-admin', assert.ifError)
        .call(callback)

    @When 'I remove $name from the admin role', (name, callback) ->
      @browser
        .waitForVisible('td.name', assert.ifError)
        .click('tr .remove-admin', assert.ifError)
        .call(callback)
