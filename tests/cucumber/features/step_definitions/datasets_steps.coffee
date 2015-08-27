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

    @Given "there is a test tabular dataset in the database", ->
      @server.call('createDataset', {name: "Test Dataset", _id: 'fakedatasetid'})

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
          @server.call('createDataset', {
            name: name,
            createdById: ret.value
          })
        ))

    @When 'I go to the datasets page', ->
      @browser
        .waitForExist('.my-datasets-link')
        .click('.my-datasets-link')
        .waitForVisible(".my-datasets-header")

    @When '"$name" should be listed under my datasets', (name)->
      @browser
        .waitForVisible(".dataset-link")
        .getText(".dataset-link").should.become(name)

    @When "I navigate to the test dataset detail page", ->
      @client
        .url(url.resolve(process.env.ROOT_URL, '/datasets/fakedatasetid'))

    @Then "I should see the test dataset data in a table", ->
      @client
        .waitForExist('.dataset-table')
        .getHTML '.dataset-table', (error, attr) ->
          assert.ifError error
>>>>>>> 1a95910... Build some dataset file parsing functionality
