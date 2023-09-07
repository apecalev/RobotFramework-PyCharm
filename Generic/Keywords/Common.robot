*** Settings ***
Documentation     Common keywords
Library       SeleniumLibrary    timeout=60
Library       BuiltIn
Library       Collections
Library       String
Resource      Homepage.robot
Library       DateTime
Resource      ../resources/testdata.robot
Library       DatabaseLibrary
Resource      ../resources/env.txt
Variables     ../resources/environments.py
Resource      MyAccount.robot
Resource      Checkout.robot
Resource      Cartpage.robot
Resource      PDPScreen.robot
Library       OperatingSystem
Library       ExcelRobot
Library       RequestsLibrary
Resource      ../PageObjects/Common.robot
Library       XML
Library       JSONLibrary
Library       ExternalKeywords.py

*** Keywords ***
Close the Browser
    Run Keyword if    '${TEST_STATUS}'=='FAIL'    CAPTURE PAGE SCREENSHOT    ${BROWSER}-C${TEST_CASEID}.png
    ${SESSIONID}=    Wait Until Keyword Succeeds    6s    2s    Get Cookies    as_dict=True
    ${SESSIONID}=    RUN KEYWORD and IGNORE ERROR    GET FROM DICTIONARY    ${SESSIONID}    JSESSIONID
    Run Keyword And Ignore Error    Log To Console    JSESSIONID: ${SESSIONID}
    Close Browser

Open Firefox
    [Arguments]    ${URL}
    Open Firefox Browser
    Go To    ${URL}    #FIREFOX    FF_PROFILE_DIR=${PROFILE}
    Maximize Browser Window

Open Chrome
    [Arguments]    ${URL}
    ${CHROME_OPTIONS}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${CHROME_OPTIONS}    add_argument    test-type
    Call Method    ${CHROME_OPTIONS}    add_argument    --disable-extensions
    Call Method    ${CHROME_OPTIONS}    add_argument    --disable-gpu
    Call Method    ${CHROME_OPTIONS}    add_argument    --no-sandbox
    Call Method    ${CHROME_OPTIONS}    add_argument    --start-maximized
    Create Webdriver    Chrome    chrome_options=${CHROME_OPTIONS}
    Sleep    1s
    Go To    ${URL}

Open IE
    [Arguments]    ${URL}
    ${IE_OPTIONS}=    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.INTERNETEXPLORER    sys, selenium.webdriver
    Set To Dictionary    ${IE_OPTIONS}    IGNOREPROTECTEDMODESETTINGS    ${TRUE}
    Set To Dictionary    ${IE_OPTIONS}    INTRODUCE_FLAKINESS_BY_IGNORING_SECURITY_DOMAINS    ${TRUE}
    Set To Dictionary    ${IE_OPTIONS}    IE_ENSURE_CLEAN_SESSION    ${TRUE}
    Set To Dictionary    ${IE_OPTIONS}    REQUIREWINDOWFOCUS    ${TRUE}
    #Set To Dictionary    ${IE_OPTIONS}    IE.ENSURECLEANSESSION    ${TRUE}
    Set To Dictionary    ${IE_OPTIONS}    IGNOREZOOMSETTING    ${TRUE}
    Set To Dictionary    ${IE_OPTIONS}    REQUIREWINDOWFOCUS    ${TRUE}
    Create Webdriver    Ie    capabilities=${IE_OPTIONS}
    Sleep    1s
    Go To    ${URL}

Open Edge
    [Arguments]    ${URL}
    ${EDGE_OPTIONS}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys
    Call Method    ${EDGE_OPTIONS}    add_argument    test-type
    Call Method    ${EDGE_OPTIONS}    add_argument    --disable-extensions
    Call Method    ${EDGE_OPTIONS}    add_argument    --disable-gpu
    Call Method    ${EDGE_OPTIONS}    add_argument    --no-sandbox
    Call Method    ${EDGE_OPTIONS}    add_argument    --start-maximized
    Create Webdriver    Edge    capabilities=${EDGE_OPTIONS}
    Sleep    1s
    Go To    ${URL}

Scroll Page to Location
    [Arguments]    ${X_LOCATION}    ${Y_LOCATION}
    Execute JavaScript    window.scrollTo(${X_LOCATION}, ${Y_LOCATION})
    Sleep    1

Generate STRING username
    ${RANUSER}    Generate Random String    10    [LOWER]
    Set Test Variable    ${RANUSER}

Generate Timestamp Username
    ${D}=    Get Current Date    result_format=datetime
    ${RANDOMUSERNAME} =    Evaluate    '${D}'.replace(':','').replace('.','').replace('-','').replace(' ', '')
    ${RANDOMUSERNAME} =    GET SUBSTRING    ${RANDOMUSERNAME}    4
    ${RANDOMUSERNAME} =    Set Variable    TEST${RANDOMUSERNAME}
    Set Test Variable    ${RANDOMUSERNAME}
    Log To Console    Generated timestamp username ${RANDOMUSERNAME}@domain.com

Launch Mobile Browser
    [Arguments]    ${WIDTH}    ${HEIGHT}
    ${DEVICE_METRICS}=    CREATE DICTIONARY    WIDTH=${${WIDTH}}    HEIGHT=${${HEIGHT}}    PIXELRATIO=${3.0}    useragent=Mozilla/5.0 (Linux; Android 7.0; SM-G892A Build/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/60.0.3112.107 Mobile Safari/537.36
    ${MOBILE_EMULATION}=    CREATE DICTIONARY    DEVICEMETRICS=${DEVICE_METRICS}
    ${CHROME OPTIONS}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${CHROME OPTIONS}    ADD_EXPERIMENTAL_OPTION    MOBILEEMULATION    ${MOBILE_EMULATION}
    Create Webdriver    Chrome    chrome_options=${CHROME OPTIONS}
    Maximize Browser Window
    go to    ${URL}

Open Headless Chrome
    [Arguments]    ${URL}
    ${CHROME_OPTIONS}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${CHROME_OPTIONS}    add_argument    test-type
    Call Method    ${CHROME_OPTIONS}    add_argument    --disable-extensions
    Call Method    ${CHROME_OPTIONS}    add_argument    --disable-gpu
    Call Method    ${CHROME_OPTIONS}    add_argument    --no-sandbox
    Call Method    ${CHROME_OPTIONS}    add_argument    --start-maximized
    Call Method    ${CHROME_OPTIONS}    add_argument    --headless
    Call Method    ${CHROME_OPTIONS}    add_argument    --window-size\=1600,900
    Create Webdriver    Chrome    chrome_options=${CHROME_OPTIONS}
    Sleep    1s
    Go To    ${URL}

Open Headless Firefox
    [Arguments]    ${URL}
    Open Headless Firefox Browser
    Sleep    1s
    Go To    ${URL}

Open Headless Edge
    [Arguments]    ${URL}
    Open Headless Edge Browser
    Sleep    1s
    Go To    ${URL}
