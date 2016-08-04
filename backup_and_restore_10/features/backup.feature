Feature: Backup mysql database

  Background:
    Given I have a running server
    And I provision it

  Scenario: Install automysqlbackup
    When I install automysqlbackup
    Then it should be successful

  Scenario: Run backup command
    When I run backup command
    Then it should be successful
    And backup folders should exist

  Scenario: Create test database
    When I create test database
    Then it should be successful

  Scenario: Get latest database backup and load it
    When I load latest database backup to test database
    Then it should be successful

  Scenario: Compare database backup
    When I compare database backup to match
    Then it should be successful
