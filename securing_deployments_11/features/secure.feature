Feature: Secure credentials

  Background:
    Given I have a running server
    And I provision it

  Scenario: Install Git-secrets
    When I install git-secrets
    Then it should be successful
    And git-secrets command should be available
