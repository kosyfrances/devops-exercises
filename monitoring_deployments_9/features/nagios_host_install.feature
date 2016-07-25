Feature: Provision and install Nagios host

  Background:
    Given I have a running nagios host
    And I provision the nagios host

  Scenario: Install Nagios Plugins and NRPE
    When I install Nagios Plugins and NRPE
    Then It should be successful
