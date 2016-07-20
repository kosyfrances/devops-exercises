Feature: Provision and install

  Background:
    Given I have a running server
    And I provision it

  Scenario: Install Apache
    When I install Apache
    Then it should be successful
    And apache2 should be running
    And it should be accepting connections on port 80

  Scenario: Install MySQL
    When I install MySQL
    Then it should be successful
    And mysql should be running

  Scenario: Install PHP
    When I install PHP
    Then it should be successful

  Scenario: Create Nagios user and group
    When I create user and group
    Then it should be successful
    And user should exist

  Scenario: Install build dependencies
    When I install build dependencies
    Then it should be successful
