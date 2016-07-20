Feature: Provision and install

  Background:
    Given I have a running server
    And I provision it

  Scenario: Install Apache
    When I install Apache
    Then it should be successful
    And apache should be running
    And it should be accepting connections on port 80
