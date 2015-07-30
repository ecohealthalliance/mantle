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

  @ignore
  Scenario: Inviting an user to a dataset
    Given "Marie Curie" is an user
    When I log in as the test user
    And the current user has a dataset called "radioactivity experiments"
    When I navigate to "/datasets"
    Then "radioactivity experiments" should be listed under my datasets
    When I click on the "radioactivity experiments" dataset
    And I click on "Invite collaborators"
    And I search for "Curie"
    Then I should see "Marie Curie" in the search results
    When I click the invite button for "Marie Curie"
    Then I should see "Marie Curie" in the list of collaborators
    When I log out
    And I log in as "Marie Curie"
    And I navigate to "/datasets"
    Then "radioactivity experiments" should be listed under my shared datasets
