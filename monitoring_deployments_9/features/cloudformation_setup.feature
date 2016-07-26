Feature: Set up a cloudformation stack to provision EC2 instances

  Scenario: Launch cloudformation stack
    When I launch cloudformation stack
    Then it should be successful
    And two instances should be created
