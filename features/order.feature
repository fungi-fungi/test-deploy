@Ordering
Feature: Ordering

  Background: 
    Given I have account
    And I have 10 items in my inventory
    And I have 2 avaliable configuration

  @javascript
  Scenario: I can see all configurations
    Given I am on my profile page
    When I go to Configuration page
    Then I can see 2 avaliable configurations

  @javascript
  Scenario: I can see all my previous orders
    Given I have 5 previous orders
    And I am on my profile page
    When I go to Orders page
    Then I can see 5 orders