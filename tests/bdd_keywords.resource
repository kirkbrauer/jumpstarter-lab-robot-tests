*** Settings ***
Resource    keywords.resource


*** Keywords ***
the device is on
    Power Cycle

I login with the username "${username}" and the password "${password}"
    Console Expect    login:    timeout=120
    Console Send    ${username}
    Console Expect    Password:    timeout=10
    Console Send    ${password}

I am on the console
    ${output}=    Console Output
    Should Contain    ${output}    ]#

I should see the console prompt
    Console Expect    ]#

the radio client is running
    Run Radio Client

I send the command "${command}"
    Console Send    ${command}

I press the "${key}" key
    Console Send    ${key}

I press the "${key}" key ${times} times
    Console Send    ${key}    times=${times}

I should see the output "${output}"
    ${output}=    Console Output
    Should Contain    ${output}    localhost/app
