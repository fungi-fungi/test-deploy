Feature: Login

  @jascript
  Scenario: Login
    Given I am on main page
    When I enter correct credentials
    Then I can see my profile