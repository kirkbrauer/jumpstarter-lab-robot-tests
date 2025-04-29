*** Settings ***
Library     JumpstarterLibrary.py
Library     Process
Resource    variables.resource


*** Keywords ***
Connect Jumpstarter
    Request Lease    selector=${SELECTOR}    client=${CLIENT}
    Flash System

Cleanup Jumpstarter
    Power Off
    Release Lease

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

Get Commit Hash
    ${result}=    Run Process    git    rev-parse    HEAD    shell=True
    ${commit_hash}=    Get Process Result    ${result}    stdout
    RETURN    ${commit_hash.strip()}

Get Image URL
    [Arguments]    ${commit_hash}
    ${full_url}=    Catenate    SEPARATOR=    ${IMAGE_URL}    ${commit_hash}_autosd9-qemu.qcow2
    RETURN    ${full_url}

Flash System
    [Documentation]    Flash the latest system image with the latest version.
    ${commit_hash}=    Get Commit Hash
    ${path}=    Get Image URL    ${commit_hash}
    Log    Flashing image ${path}
    Flash Image    ${path}
