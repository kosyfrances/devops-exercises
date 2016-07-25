Feature: Provision and install Nagios host

  Background:
    Given I have a running server nagioshost
    And I provision it nagioshost

  Scenario: Install Nagios Plugins and NRPE
    When I install Nagios Plugins and NRPE
    Then It should be successful

  Scenario: Configure allowed hosts and allowed NRPE commands
    When I configure allowed hosts and allowed NRPE commands
    Then it should be successful
    And nagios-nrpe-server should be running on nagioshost
