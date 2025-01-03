*** Settings ***
Library        AppiumLibrary
Resource        ./password.robot


*** Variables ***
#*** Test Variables ***
&{USER1-DETAILS}    username=test-testy    password=${PASSWORD1}
&{USER2-DETAILS}    username=test2-testy    password=${PASSWORD2}


#*** Application Variables ***
${CHAT-APP-ID}    im.vector.app
${CHAT-APP-ACTIVITY}    im.vector.application.features.Alias

${APPIUM-PORT-DEVICE1}        4723
${APPIUM-PORT-DEVICE2}        4725

${APPIUM-ADB-PORT-DEVICE1}    5037
${APPIUM-ADB-PORT-DEVICE2}    5038

${APPIUM-SYSTEM-PORT-DEVICE1}    8201
${APPIUM-SYSTEM-PORT-DEVICE2}    8202

${ANDROID-ALERT-VERIFY-DEVICE}    //android.widget.LinearLayout[@resource-id="${CHAT-APP-ID}:id/llAlertBackground"]//android.widget.TextView[@text="Verify this device"]
${ANDROID-SKIP-VERIFY-DEVICE}    //android.widget.TextView[@text="Skip"]
# ${ANDROID-ALERT-VERIFY-DEVICE}    //android.widget.LinearLayout[@resource-id="${CHAT-APP-ID}:id/llAlertBackground"]

#*** Login Page ***
${SIGNIN-BUTTON}    //android.widget.Button[@resource-id="${CHAT-APP-ID}:id/loginSplashAlreadyHaveAccount"]
${USERNAME-EDITTEXT}    //android.widget.EditText[@resource-id="${CHAT-APP-ID}:id/loginEditText"]
${PASSWORD-EDITTEXT}    //android.widget.EditText[@resource-id="${CHAT-APP-ID}:id/loginPasswordEditText"]
${LOGIN-SUBMIT-BUTTON}    //android.widget.Button[@resource-id="${CHAT-APP-ID}:id/loginSubmit" and @enabled="true"]

#*** Pre-Main Page **
${HELP-IMPROVE-PAGE}    //android.widget.TextView[@text="Help improve Element"]
${NOT-NOW-BUTTON}    //android.widget.Button[@resource-id="${CHAT-APP-ID}:id/later"]

#*** Main Page ***
${PERMISSION-MESSAGE}    //android.widget.TextView[@text="Allow Element to send you notifications?"]
${DENY-PERMISSION-BUTTON}    //android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_deny_button"]


${AVATAR-IMAGE}    //android.widget.ImageView[@resource-id="${CHAT-APP-ID}:id/avatar"]
${GENERAL-PREF-BUTTON}    //android.widget.TextView[@text="General"]
${SIGNOUT-BUTTON}    //android.widget.TextView[@text="Sign out"]

${SETTING-VIEW}    //androidx.recyclerview.widget.RecyclerView[@resource-id="${CHAT-APP-ID}:id/recycler_view"]


#*** New Converstion ***
${START-CHAT-BUTTON}    //android.widget.TextView[@resource-id="${CHAT-APP-ID}:id/start_chat"]
${CONVERSATION-SEARCH-FIELD}    //android.view.ViewGroup[@resource-id="${CHAT-APP-ID}:id/coordinatorLayout"]//android.widget.EditText[@resource-id="${CHAT-APP-ID}:id/userListSearch"]
${CONVERSATION-SEARCH-BUTTON}    //android.view.ViewGroup[@resource-id="${CHAT-APP-ID}:id/coordinatorLayout"]//android.widget.Button[@resource-id="${CHAT-APP-ID}:id/action_create_direct_room" and @text="GO"]

#*** Conversation Window ***
${CONVERSATION-INPUT-FIELD}    //android.widget.EditText[@resource-id="${CHAT-APP-ID}:id/composerEditText"]


*** Keywords ***
Open Chat Application
    [Arguments]    ${APPIUM-PORT}=${APPIUM-PORT-DEVICE1}    ${APPIUM-ADB-PORT}=${APPIUM-ADB-PORT-DEVICE1}    ${APPIUM-SYSTEM-PORT}=${APPIUM-SYSTEM-PORT-DEVICE1}
    Open Application    remote_url=http://localhost:${APPIUM-PORT}    platformName=Android   appPackage=${CHAT-APP-ID}   appActivity=${CHAT-APP-ACTIVITY}    automationName=UiAutomator2    # adbPort=${APPIUM-ADB-PORT}    systemPort=${APPIUM-SYSTEM-PORT}

Open Chat Application With Device1
    Open Chat Application    ${APPIUM-PORT-DEVICE1}   # ${APPIUM-ADB-PORT-DEVICE1}    ${APPIUM-SYSTEM-PORT-DEVICE1}

Open Chat Application With Device2
    Open Chat Application    ${APPIUM-PORT-DEVICE2}    #${APPIUM-ADB-PORT-DEVICE2}    ${APPIUM-SYSTEM-PORT-DEVICE2}

Go To Login Page
    Wait Until Page Contains Element    ${SIGNIN-BUTTON}
    Click Element    ${SIGNIN-BUTTON}
    Wait Until Page Contains Element    ${USERNAME-EDITTEXT}

Signin With User
    [Arguments]    ${USERNAME}    ${PASSWORD}
    Go To Login Page
    Input Text    ${USERNAME-EDITTEXT}    ${USERNAME}
    Input Password    ${PASSWORD-EDITTEXT}    ${PASSWORD}
    Click Element    ${LOGIN-SUBMIT-BUTTON}
    ${ALERT}    Run Keyword And Return Status    Page Should Not Contain Element    ${HELP-IMPROVE-PAGE}
    Run Keyword If    '${ALERT}' == 'True'    Deny Help Improve Page
    ${ALERT}    Run Keyword And Return Status    Page Should Not Contain Element    ${ANDROID-ALERT-VERIFY-DEVICE}
    Run Keyword If    '${ALERT}' == 'True'    Bypass Verify Device Alerts

    Wait Until Page Contains Element    ${AVATAR-IMAGE}

Deny Help Improve Page
    Wait Until Page Contains Element    ${NOT-NOW-BUTTON}
    Click Element    ${NOT-NOW-BUTTON}
    Wait Until Page Contains Element    ${PERMISSION-MESSAGE}
    Deny Permission

Deny Permission
    # Wait Until Page Contains Element    ${DENY-PERMISSION-BUTTON}
    Click Element    ${DENY-PERMISSION-BUTTON}


Bypass Verify Device Alerts
    Wait Until Page Contains Element    ${ANDROID-ALERT-VERIFY-DEVICE}
    Click Element    ${ANDROID-ALERT-VERIFY-DEVICE}
    Wait Until Page Contains Element    ${ANDROID-SKIP-VERIFY-DEVICE}
    Click Element    ${ANDROID-SKIP-VERIFY-DEVICE}

Go To Setting Page
    Click Element    ${AVATAR-IMAGE}
    Wait Until Page Contains Element    ${GENERAL-PREF-BUTTON}
    Click Element    ${GENERAL-PREF-BUTTON}
    Wait Until Page Contains Element    ${SETTING-VIEW}

Scroll Down To Sign Out
    Swipe By Percent    50	90	50	55

Sign Out User
    Go To Setting Page
    Scroll Down To Sign Out
    Wait Until Page Contains Element    //android.widget.LinearLayout[@index="12"]//android.widget.TextView[@resource-id="android:id/title" and @text="Sign out"]
    Click Element   //android.widget.LinearLayout[@index="12"]//android.widget.TextView[@resource-id="android:id/title" and @text="Sign out"]
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="im.vector.app:id/alertTitle" and @text="Sign out"]
    Click Element    //android.widget.Button[@text="SIGN OUT"]


#*** Chat Tab ***
Create New Conversation
    [Arguments]    ${NAME}
    Click Element    //android.widget.ImageButton[@resource-id="${CHAT-APP-ID}:id/newLayoutCreateChatButton"]
    Wait Until Page Contains Element    ${START-CHAT-BUTTON}
    Click Element     ${START-CHAT-BUTTON}
    Search For Contact    @${NAME}:matrix.org
    Click Element    ${CONVERSATION-SEARCH-BUTTON}
    Wait Until Conversation Window Is Open    ${NAME}

Search For Contact
    [Arguments]    ${NAME}
    Wait Until Page Contains Element    //android.widget.TextView[@text="Direct Messages"]
    Input Text    ${CONVERSATION-SEARCH-FIELD}    ${NAME}
    # Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${CHAT-APP-ID}:id/knownUserName",@text="${NAME}"]
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${CHAT-APP-ID}:id/knownUserID" and @text="${NAME}"]

    Click Element    //android.widget.TextView[@resource-id="${CHAT-APP-ID}:id/knownUserID" and @text="${NAME}"]
    Wait Until Page Contains Element    ${CONVERSATION-SEARCH-BUTTON}

Wait Until Page Contains Conversation
    [Arguments]    ${NAME}
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${CHAT-APP-ID}:id/roomNameView" and @text="${NAME}"]
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${CHAT-APP-ID}:id/roomUnreadCounterBadgeView"]


Open Conversation
    [Arguments]    ${NAME}
    Click Element   //android.widget.TextView[@resource-id="${CHAT-APP-ID}:id/roomNameView" and @text="${NAME}"]
    Wait Until Conversation Window Is Open    ${NAME}


Wait Until Conversation Window Is Open
    [Arguments]    ${NAME}
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${CHAT-APP-ID}:id/roomNameTileText" and @text="${NAME}"]

Send Message Inside Conversation Window
    [Arguments]    ${MESSAGE}
    Wait Until Page Contains Element    ${CONVERSATION-INPUT-FIELD}
    Input Text    ${CONVERSATION-INPUT-FIELD}    ${MESSAGE}
    Wait Until Page Contains Element    //android.widget.ImageButton[@resource-id="${CHAT-APP-ID}:id/sendButton"]
    Click Element    //android.widget.ImageButton[@resource-id="${CHAT-APP-ID}:id/sendButton"]
    Wait Until Conversation Contain Message    ${MESSAGE}

Wait Until Conversation Contain Message
    [Arguments]    ${MESSAGE}
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="${CHAT-APP-ID}:id/messageTextView" and @text="${MESSAGE}"]