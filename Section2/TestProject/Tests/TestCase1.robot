*** Settings ***
Documentation    This is my first test
Library    OperatingSystem
Resource    ../Resource/resource.robot

*** Test Cases ***
TEST
    [Tags]     demo
    Log        ${MY-VARIABLE}
    Log        ${MY-VARIABLE2}
    Log        ${LIST}[2]
    Log        ${LIST}[0]
    Log        ${DICTIONARY}[username]
    Log        ${DICTIONARY}[password]
    Log My Username
    Log My Password
    Log Username And Password 1
    Log Username And Password 2
    Log My Specific Username    ${DICTIONARY}[username]
    Log My Specific Username And Password    ${DICTIONARY2}[username]    ${DICTIONARY2}[password]

