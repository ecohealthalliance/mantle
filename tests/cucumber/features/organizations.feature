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

  @new
  Scenario: Joining an organization
    Given there is an organization in the database with name "Test Organization"
    When I log in as the test user
    And I navigate to "/organizations"
    And I click on the organization link
    And I click on "Join"
    Then I see that I am a member of the organization
