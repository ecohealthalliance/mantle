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
          assert.ok(ret.value)
          @server.call('addDataset', {
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
        .waitForVisible(".datasets .dataset-link")
        .getText(".dataset-link").should.become(name)

    @When '"$name" should be listed under my shared datasets', (name)->
      @browser
        .waitForVisible(".shared-datasets .dataset-link")
        .getText(".dataset-link").should.become(name)

    @When 'I click on the "$name" dataset', (name)->
      @browser
        .waitForVisible '.dataset-link[data-name="' + name + '"]'
        .click '.dataset-link[data-name="' + name + '"]'

    @When 'I click the Invite Collaborators button', ->
      @browser
        # The next waitForVisible will timeout if there is no pause here.
        .pause 100
        .waitForVisible '.invite-collaborators'
        .click '.invite-collaborators'

    @When 'I search for "$name"', (name)->
      @browser
        .waitForVisible '.invite-user-table .reactive-table-input'
        .setValue '.invite-user-table .reactive-table-input', name

    @When 'I should see "$name" in the search results', (name)->
      @browser
        .waitForVisible '.invite-user-table tbody tr'
        .getHTML '.invite-user-table tbody tr', (error, response) ->
          assert.ok(response.toString().match(name))

    @When 'I should see "$name" in the list of collaborators', (name)->
      @browser
        .waitForVisible 'tr.member-row'
        .getHTML 'tr.member-row', (error, response) ->
          assert.ok(response.toString().match(name))

    @When 'I click the invite button for "$name"', (name)->
      @browser
        .click '.invite-user-table tbody tr .invite-user'
        # close the modal
        .click '.close'
