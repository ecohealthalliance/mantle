do ->
  'use strict'

  path = require('path')
  http = require('http')
  url = require('url')

  module.exports = ->

    @When "I fill out the dataset form", (callback) ->
      @browser
        .waitForExist('input[name="name"]')
        .setValue('input[name="name"]', 'Dataset Name')
        .call(callback)

    @When "I choose a file", (callback) ->
      @browser
        .chooseFile('input[name="file"]', path.join(process.cwd(), "files", "testfile"))
        .call(callback)

    @Then /^I should( not)? see the filename$/, (shouldNot, callback) ->
      @browser
        .getValue '.file-name', (err, value) ->
          if shouldNot
            assert.equal value, ''
          else
            assert.equal value, 'testfile'
          callback()

    @When "I submit the dataset form", (callback) ->
      @browser
        .submitForm('form')
        .call(callback)

    @Then /^the downloadable file content should be "([^"]*)"$/, (content, callback) ->
      @browser
        .waitForExist('.btn')
        .getAttribute '.btn', 'href', (error, attr) ->
          assert.ifError error
          http.get attr, (response) ->
            assert.equal response.statusCode, 200
            data = ''
            response.on 'data', (chunk) ->
              data += chunk
            response.on 'end', ->
              assert.equal data, content
              callback()

    @When "I clear the file", (callback) ->
      @browser
        .waitForExist('.remove')
        .click('.remove', assert.ifError)
        .call(callback)

    @When 'the current user has a dataset called "$name"', (name)->
      @browser
        .execute((->
          Meteor.userId()
        ), ((err, ret) =>
          assert.ifError(err)
          @server.call('addDataset', {
            name: name,
            userId: ret.value
          })
        ))
