Feature: Datasets

  Background:
    Given there is a test user in the database

  @chrome
  Scenario: Creating a new dataset
    When I log in as the test user
    And I navigate to "/datasets/new"
    And I fill out the dataset form
    And I upload a file
    And I submit the dataset form
    Then I should see a "Success" toast
    And I should see content "Dataset Name"
    And the downloadable file content should be "test"

  Scenario: Creating a new dataset without a file
    When I log in as the test user
    And I navigate to "/datasets/new"
    And I fill out the dataset form
    And I submit the dataset form
    Then I should see an "Error" toast