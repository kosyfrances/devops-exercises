Feature: Secure credentials

  Background:
    Given I have a running server
    And I provision it

  Scenario: Install Git-secrets
    When I install git-secrets
    Then it should be successful
    And git-secrets command should be available

  Scenario: Copy script to setup hook on server
    When I copy script to setup hook on server
    Then it should be successful
    And script should exist
