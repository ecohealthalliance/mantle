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
