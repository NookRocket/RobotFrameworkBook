*** Settings ***
Library        AppiumLibrary
Resource        ../Resources/android_res.robot


*** Test Cases ***
Conversation
    # Default is 5s but it needs to get more time
    Set Appium Timeout    10s
    Open Chat Application With Device1
    Signin With User    ${USER1-DETAILS}[username]    ${USER1-DETAILS}[password]
    Open Chat Application With Device2
    Signin With User    ${USER2-DETAILS}[username]    ${USER2-DETAILS}[password]
    # Switch to first device
    Switch Application    1
    # Go To Chat Tab
    Create New Conversation    ${USER2-DETAILS}[username]
    Send Message Inside Conversation Window    Hello User2
    
    Switch Application    2
    Wait Until Page Contains Conversation    ${USER1-DETAILS}[username]
    Open Conversation    ${USER1-DETAILS}[username]
    Wait Until Conversation Contain Message    Hello User2
    Send Message Inside Conversation Window    Hello User1

    Switch Application    1
    Wait Until Conversation Contain Message    Hello User1