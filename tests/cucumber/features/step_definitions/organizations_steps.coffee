do ->
  'use strict'

  _ = require('underscore')

  module.exports = ->

    url = require('url')

    @When "I click the new organization link", () ->
      @browser
        .waitForExist('.organizations-table')
        .click('.new-organization-link', assert.ifError)
        .waitForExist('#new-organization-form')

    @When /^I fill out the new organization form with name "([^"]*)"$/, (name) ->
      @browser
        .waitForExist('#new-organization-form')
        .setValue('#organization-name', name)
        .setValue('#organization-description', 'This is an organization.')
        .submitForm('#new-organization-form', assert.ifError)

    @When /^I click on the organization link$/, () ->
      @browser
        .waitForVisible('.organizations-table', assert.ifError)
        .click(".organizations-table a", assert.ifError)
        .waitForVisible('.organization-detail', assert.ifError)

    @Then /^I should be on the "([^"]*)" detail page$/, (name) ->
      @browser
        .waitForVisible('.organization-detail', assert.ifError)
