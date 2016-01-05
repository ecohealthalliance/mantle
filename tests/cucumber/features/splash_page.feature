Feature: Splash Page

  @splashPage
  Scenario: Visiting splash page
    When I navigate to "/"
    Then I should see content "Mantle"
