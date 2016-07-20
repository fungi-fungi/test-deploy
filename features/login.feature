Feature: Login

  @jascript
  Scenario: Login
    Given I am on main page
    When I enter correct credentials
    Then I can see my profile


  @jascript
  Scenario: Logout
    Given I am logged in
    When I logout
    Then I am logged out