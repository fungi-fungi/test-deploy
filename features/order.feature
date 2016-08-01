
Feature: Order

  Background: 
    Given I have account
    And I have 10 items in my inventory
    And I have 2 avaliable configuration

  @jascript
  Scenario: I can see all configurations
    Given I am on my profile page
    When I go to "Orders" page
    Then I can see 2 avaliable configurations