Feature: Organizations

  Background:
    Given there is a test user in the database

  @organizations
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
    And I see that "test@example.com" is an admin of the organization

  @organizations
  Scenario: Joining an organization
    Given there is an organization in the database created by the test user
    When I register an account with email address "user@example.com"
    And I navigate to "/organizations"
    And I click on the organization link
    And I click on "Join"
    Then I see that "user@example.com" is a member of the organization

  @dev
  Scenario: Making another member an admin
    Given there is an organization in the database created by the test user
    And there is a profile with full name "Test Name" that belongs to the test organization
    When I log in as the test user
    And I navigate to "/organizations"
    And I click on the organization link
    Then I see that "Test Name" is a member of the organization
    When I make "Test Name" an admin
    Then I see that "Test Name" is an admin of the organization
