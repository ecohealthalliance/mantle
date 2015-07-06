Feature: Accounts

  Background:
    Given I am a new user

  Scenario: Creating a new account
    When I navigate to "/"
    And I open the account modal
    And I fill out the new account form
    Then I am logged in
    And I should see content "Sign Out"
    And I should see content "Profile"

  Scenario: Editing my profile
    When I register an account
    And I navigate to "/profile/edit"
    Then I should not see a "Success" toast
    When I fill out the profile edit form
    Then I should see a "Success" toast

  @dev
  Scenario: Viewing a public profile
    Given there is a profile in the database where "fullName" is "Test Title"
    When I navigate to "/profiles/fakeid"
    Then I should see content "Test Title"

  Scenario: Viewing a public profile
