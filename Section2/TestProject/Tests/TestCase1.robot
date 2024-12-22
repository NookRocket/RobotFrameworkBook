*** Settings ***
Documentation    This is my first test
Library    OperatingSystem

*** Keywords ***


*** Variables ***
${MY-VARIABLE}     This is my first variable
${MY-VARIABLE2}    This is my second variable 

@{LIST}     test    test2   test3   test4

&{DICTIONARY}     username=testUser     password=demo

*** Test Cases ***
TEST
    [Tags]     demo
    Log        ${MY-VARIABLE}
    Log        ${MY-VARIABLE2}
    Log        ${LIST}[2]
    Log        ${LIST}[0]
    Log        ${DICTIONARY}[username]
    Log        ${DICTIONARY}[password]
