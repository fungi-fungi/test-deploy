@Ordering
Feature: Ordering

  Background: 
    Given I have account
    And I have 5 previous orders
    And I have 2 avaliable configuration

  @javascript
  Scenario: I can see all configurations
    Given I am on my profile page
    When I go to Configuration page
    Then I can see 2 avaliable configurations

  @javascript
  Scenario: I can see all my previous orders
    Given I am on my profile page
    When I go to Orders page
    Then I can see 5 orders

  @javascript
  Scenario: I can view all elements required for configuration
    Given I am on my profile page
    When I go to Configuration page
    And click on detail for random category
    Then I can see all elements required for configuration