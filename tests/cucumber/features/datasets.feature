Feature: Datasets

  Background:
    Given there is a test user in the database

  @chrome
  Scenario: Creating a new dataset
    When I log in as the test user
    And I navigate to "/datasets/new"
    And I fill out the dataset form
    And I choose a file
    Then I should see the filename
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

  @chrome
  Scenario: Clear file before submitting
    When I log in as the test user
    And I navigate to "/datasets/new"
    And I fill out the dataset form
    And I choose a file
    And I clear the file
    Then I should not see the filename
    And I submit the dataset form
    Then I should see an "Error" toast

  Scenario: Not logged in
    When I navigate to "/datasets/new"
    Then I should see content "Please log in"

  Scenario: Viewing datasets administered
    When I log in as the test user
    And the current user has a dataset called "Frog data"
    And I go to the datasets page
    Then "Frog data" should be listed under my datasets
