
*** Keywords ***
Log My Username
    Log        ${DICTIONARY}[username]

Log My Password
    Log        ${DICTIONARY}[password]

Log Username And Password 1
    Log        ${DICTIONARY}[username]
    Log        ${DICTIONARY}[password]

Log Username And Password 2
    Log My Username
    Log My Password

Log My Specific Username
    [Arguments]    ${USERNAME}
    Log            ${USERNAME}

Log My Specific Username And Password
    [Arguments]                   ${USERNAME}    ${PASSWORD}
    Log My Specific Username      ${USERNAME}
    Log                           ${PASSWORD}

*** Variables ***
${MY-VARIABLE}     This is my first variable
${MY-VARIABLE2}    This is my second variable 

@{LIST}     test    test2   test3   test4

&{DICTIONARY}      username=testUser      password=demo
&{DICTIONARY2}     username=testUser2     password=demo2

