
Feature: Welcome page

  @javascript
  Scenario: Check weclome controller
    When I am on the homepage
    Then I should see hello world text