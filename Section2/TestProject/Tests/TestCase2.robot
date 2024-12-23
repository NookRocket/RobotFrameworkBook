*** Settings ***
Library    OperatingSystem
Resource    ../Resource/resource.robot

*** Test Cases ***
TEST2
    [Tags]    demo2
    Log My Specific Username And Password    ${DICTIONARY2}[username]    ${DICTIONARY2}[password]