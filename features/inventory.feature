@Inventory
Feature: Inventory

  Background:
    Given I have account
    And I have 10 items in my inventory

  @jascript
  Scenario: View my inventory
    Given I am on my profile page
    When I go to Inventory page
    Then I can see 10 items in my inventory