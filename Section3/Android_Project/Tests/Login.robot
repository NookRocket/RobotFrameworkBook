*** Settings ***
Library        AppiumLibrary
Resource        ../Resources/android_res.robot


*** Test Cases ***
Login
    Open Chat Application With Device1
    Go To Login Page
    Signin With User    ${USER1-DETAILS}[username]    ${USER1-DETAILS}[password]
    Go To Setting Page
    # Scroll Down To Sign Out
    # Element Should Be Visible    ${SIGNOUT-BUTTON}
    # Click Element    ${SIGNOUT-BUTTON}

    Open Chat Application With Device2
    Go To Login Page
    Signin With User    ${USER1-DETAILS}[username]    ${USER1-DETAILS}[password]
    Go To Setting Page
    # Scroll Down To Sign Out
    # Element Should Be Visible    ${SIGNOUT-BUTTON}
    # Click Element    ${SIGNOUT-BUTTON}
    
    # Scroll Down        //android.widget.FrameLayout[@index=0]//android.view.ViewGroup[@index=0]//androidx.recyclerview.widget.RecyclerView[@index=2]
    # Scroll Element Into View    //android.widget.FrameLayout[@index=0]//android.view.ViewGroup[@index=0]//androidx.recyclerview.widget.RecyclerView[@index=2]//android.widget.LinearLayout[@index=10]//android.widget.TextView[@text="Sign out"]

    # //android.widget.TextView[@text="User settings"]    
    # Scroll Down        //android.widget.TextView[@text="Sign out"]
    # Scroll    xpath=//android.widget.TextView[@text="User settings"]    xpath=//android.widget.TextView[@text="Sign out"]
    # Scroll    //android.widget.LinearLayout[@index="0"]    //android.widget.LinearLayout[@index="11"]
    # Swipe	100	0  100	100
    # Scroll Element Into View    ${SIGNOUT-BUTTON}
    # Wait Until Page Contains Element    ${SIGNOUT-BUTTON}




