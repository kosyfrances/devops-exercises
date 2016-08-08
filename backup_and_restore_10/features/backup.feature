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

  Scenario: Copy backup script to server
    When I copy backup script to server
    Then it should be successful
    And backup script should exist in server

  Scenario: Execute cron task
    When I execute cron task
    Then it should be successful
