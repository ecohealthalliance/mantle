Feature: Accounts

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
    When I fill out the profile edit form with fullName "Test Name"
    Then I should see a "Success" toast
    When I view my public profile
    And I should see content "Test Name"

  Scenario: Viewing a public profile
    Given there is a profile with ID 'fakeid' where "fullName" is "Test Title"
    When I navigate to "/profiles/fakeid"
    Then I should see content "Test Title"

  Scenario: Hiding/displaying email address on profile page
    When I register an account with email address "test@example.com"
    And I view my public profile
    Then I should see content "test@example.com"
    When I hide my email address from my profile
    And I view my public profile
    Then I should not see content "test@example.com"
