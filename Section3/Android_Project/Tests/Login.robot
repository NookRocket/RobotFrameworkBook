*** Settings ***
Library        AppiumLibrary
Resource        ../Resources/android_res.robot


*** Test Cases ***
Login
    # Default is 5s but it needs to get more time
    Set Appium Timeout    20s
    Open Chat Application With Device1
    Signin With User    ${USER1-DETAILS}[username]    ${USER1-DETAILS}[password]
    Sign Out User
    Signin With User    ${USER2-DETAILS}[username]    ${USER2-DETAILS}[password]
    



