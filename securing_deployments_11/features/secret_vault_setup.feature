Feature: Ensure credentials for production systems are stored in a secure vault and restrict access to it

  Background:
    Given I have a running server
    And I provision it

  Scenario: Install Vault and Consul
    When I install Vault and Consul
    Then it should be successful
    And vault command should be available
    And consul command should be available
