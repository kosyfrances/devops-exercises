Feature: Set up New Relic on host

  Background:
    Given I have a running server nagioshost
    And I provision it nagioshost

  Scenario: Install newrelic
    When I install newrelic
    Then It should be successful

  Scenario: Edit newrelic file
    When I edit newrelic file
    Then it should be successful
