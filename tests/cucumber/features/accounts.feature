Feature: Accounts

  Background:
    Given I am a new user

  @dev
  Scenario: Creating a new account
    When I navigate to "/"
    And I open the account modal
    And I fill out the new account form
    Then I am logged in
    And I should see content "Sign Out"
    And I should see content "Profile"
