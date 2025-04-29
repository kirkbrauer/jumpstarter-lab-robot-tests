*** Settings ***
Documentation       A simple Jumpstarter test suite using the Robot Framework.

Resource            keywords.resource

Suite Setup         Connect Jumpstarter
Suite Teardown      Cleanup Jumpstarter


*** Test Cases ***
Test Boot Process
    [Documentation]    Test the boot process of the device.
    Power Cycle
    Login As Root

Test Uname
    [Documentation]    Verify `uname -a` runs successfully.
    Console Send    uname -a
    Expect Prompt
    ${output}=    Console Output
    Log    ${output}

Test Podman Images
    [Documentation]    Verify expected image appears in `podman images` list.
    Console Send    podman images
    Expect Prompt
    ${output}=    Console Output
    Should Contain    ${output}    localhost/app

Test Radio Service
    [Documentation]    Check the status of `radio.service`.
    Console Send    systemctl status --no-pager radio.service
    Expect Prompt

Test Radio Service Interaction
    [Documentation]    Test interacting with the radio service.
    Run Radio Client
    Console Send    +    times=10
    Console Expect    Volume:${SPACE * 2}\[#####################]
    Console Send    -    times=10
    Console Expect    Volume:${SPACE * 2}\[${SPACE * 21}]
    Console Send    +    times=5
    Console Expect    Volume:${SPACE * 2}\[##########${SPACE * 11}]
    Console Send    q
    Expect Prompt

Test RH Summit Radio
    [Documentation]    Test switching to RH Summit Radio station.
    Run Radio Client
    Console Send    " "    times=2
    Console Expect    Station: Red Hat Summit Radio
    Console Send    q
    Expect Prompt
