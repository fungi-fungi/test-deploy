@wip
Feature: Inventory

  Background: 
    Given I have 10 items in my inventory

  @jascript
  Scenario: View my inventory
    Given I am on my profile page
    When I request my inventory
    Then I can see all my inventory