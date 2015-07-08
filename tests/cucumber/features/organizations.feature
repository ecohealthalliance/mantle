Feature: Organizations

  Background:
    Given I am a new user

  @dev
  Scenario: Creating a new organization
    Given I have registered an account
    When I navigate to "/organizations"
    And I click the new organization link
    And I fill out the new organization form with name "Test Organization"
    Then I should see a "Success" toast
    When I navigate to "/organizations"
    Then I should see content "Test Organization"
