Feature: Set up hooks to scan for secure credentials/token before code is checked in to a repo

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

  Scenario: Test that setup hook script exits with 0
    When I create a test repo
    And run script against test repo
    And I add aws secret to the repo
    Then aws secret should not be committed
    And test repo should be deleted
