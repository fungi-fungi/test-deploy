Feature: Welcome page

  @javascript
  Scenario: Check welcome controller
    When I am on the homepage
    And I submit new request 
    Then I should see hello world text