*** Settings ***
Library             JumpstarterLibrary.py

Suite Setup         Request Lease    selector=${SELECTOR}    client=${CLIENT}
Suite Teardown      Release Lease


*** Variables ***
${SELECTOR}     "type=virtual"
${CLIENT}       "lab"
${USERNAME}     "root"
${PASSWORD}     "password"


*** Test Cases ***
Test Boot Process
    [Documentation]    Test the boot process of the device.
    Power Cycle
    Login As Root

Test Uname
    [Documentation]    Verify `uname -a` runs successfully.
    Console Send    uname -a
    Expect Prompt
    ${output}=    Console Get Output
    Log    ${output}

Test Podman Images
    [Documentation]    Verify expected image appears in `podman images` list.
    Console Send    podman images
    Expect Prompt
    ${output}=    Console Get Output
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


*** Keywords ***
Expect Prompt
    [Documentation]    Expect the empty root prompt.
    Console Expect    ]#

Login As Root
    [Documentation]    Login as the root user.
    Console Expect    login:    timeout=120
    Console Send    ${USERNAME}
    Console Expect    Password:    timeout=10
    Console Send    ${PASSWORD}
    Console Expect    ]#

Run Radio Client
    [Documentation]    Run the radio-client with Podman.
    Console Send    podman exec -i systemd-radio radio-client
    Console Expect    Connecting to radio service
