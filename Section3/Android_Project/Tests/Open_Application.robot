*** Settings ***
Library        AppiumLibrary

*** Test Cases ***
Open_Application
    Open Application    remote_url=http://localhost:4723    platformName=Android     deviceName=Pixel_8a_Android_15    appPackage=com.android.chrome   appActivity=com.google.android.apps.chrome.Main    automationName=UiAutomator2 

    