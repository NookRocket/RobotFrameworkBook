*** Settings ***
Library        AppiumLibrary
Resource        ../Resources/password.robot

*** Variables ***
${SIGNIN-BUTTON1}    id=com.android.chrome:id/signin_fre_dismiss_button
${SIGNIN-BUTTON2}    //android.widget.Button[@text="Use without an account"]
${SIGNIN-BUTTON3}    //android.widget.Button[contains(@text,"Use without an account")]
${SIGNIN-BUTTON4}    //android.widget.Button[@resource-id="com.android.chrome:id/signin_fre_dismiss_button"]
${SIGNIN-BUTTON5}    //android.widget.Button[@resource-id="com.android.chrome:id/signin_fre_dismiss_button" and @text="Use without an account"]
${SIGNIN-BUTTON6}    //android.widget.Button[contains(@text,"Use without an account")]
${SIGNIN-BUTTON7}    //android.widget.LinearLayout//android.widget.Button[@text="Use without an account"]

*** Test Cases ***
Open_Application
    Open Application    remote_url=http://localhost:4723    platformName=Android     deviceName=Pixel_8a_Android_15    appPackage=com.android.chrome   appActivity=com.google.android.apps.chrome.Main    automationName=UiAutomator2 
    Wait Until Page Contains Element    ${SIGNIN-BUTTON1}
    Wait Until Page Contains Element    ${SIGNIN-BUTTON2}
    Wait Until Page Contains Element    ${SIGNIN-BUTTON3}
    Wait Until Page Contains Element    ${SIGNIN-BUTTON4}
    Wait Until Page Contains Element    ${SIGNIN-BUTTON5}
    Wait Until Page Contains Element    ${SIGNIN-BUTTON6}
    Wait Until Page Contains Element    ${SIGNIN-BUTTON7}

    