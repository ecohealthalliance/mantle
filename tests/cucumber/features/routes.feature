Feature: Routes
  
  Scenario: Navigate to non-existant path
    When I log in as the test user
    And I navigate to "/the-cow-jumped-over-the-moon"
    Then I see the not_found page
