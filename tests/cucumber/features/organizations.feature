Feature: Organizations

  Background:
    Given there is a test user in the database

  Scenario: Creating a new organization
    When I log in as the test user
    When I navigate to "/organizations"
    And I click the new organization link
    And I fill out the new organization form with name "Test Organization"
    Then I should see a "Success" toast
    When I navigate to "/organizations"
    Then I should see content "Test Organization"
    When I click on the organization link
    Then I should be on the "Test Organization" detail page
    And I should see content "Test Organization"

  Scenario: Editing an organization
    When I log in as the test user
    And I create an organization with name "Test Organization"
    And I navigate to "/organizations"
    Then I should not see content "Better Name"
    And I should not see content "Better Description"

    When I click on the organization link
    And I change the organization name to "Better Name"
    And I change the organization description to "Better Description"
    And I navigate to "/organizations"
    Then I should see content "Better Name"
    And I should see content "Better Description"
    And I should not see content "Test Organization"
