*** Settings ***
Documentation       A simple Jumpstarter test using the Robot Framework BDD tests feature.

Resource            bdd_keywords.resource

Suite Setup         Connect Jumpstarter
Suite Teardown      Cleanup Jumpstarter


*** Test Cases ***
Login As Root
    [Documentation]    As a User, I want to login as root so I can administer the system.
    Given the device is on
    When I login with the username "${USERNAME}" and the password "${PASSWORD}"
    Then I should see the console prompt

Check App Is Installed
    [Documentation]    As a User, I want the radio client to be pre-installed so I can test the application.
    Given I am on the console
    When I send the command "podman images"
    Then I should see the output "localhost/app"

Increase Volume
    [Documentation]    As a User, I want to increase the volume so I can hear the music better.
    Given I am on the console
    And the radio client is running
    When I press the "+" key 10 times
    Then I should see the output "Volume:${SPACE * 2}\[#####################]"

Decrease Volume
    [Documentation]    As a User, I want to decrease the volume so the sound is lower.
    Given I am on the console
    And the radio client is running
    When I press the "-" key 10 times
    Then I should see the output "Volume:${SPACE * 2}\[${SPACE * 21}]"

Quit Radio Client
    [Documentation]    As a User, I want to quit the radio client so I can use other apps.
    Given I am on the console
    And the radio client is running
    When I press the "q" key
    Then I should see the console prompt
