Feature: Organizations

  Background:
    Given I am a new user
    And there is a test user in the database

  Scenario: Creating a new organization
    When I log in as the test user
    When I navigate to "/organizations"
    And I click the new organization link
    And I fill out the new organization form with name "Test Organization"
    Then I should see a "Success" toast
    When I navigate to "/organizations"
    Then I should see content "Test Organization"
