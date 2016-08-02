Feature: Backup mysql database

  Background:
    Given I have a running server

  Scenario: Install automysqlbackup
    When I install automysqlbackup
    Then it should be successful

  Scenario: Run backup command
    When I run backup command
    Then it should be successful
