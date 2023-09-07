*** Settings ***
Documentation     Suite description
Library       SeleniumLibrary    timeout=60
Library       BuiltIn
Library       Collections
Library       String
Resource      ../resources/testdata.robot
Resource      ../PageObjects/Cartpage.robot
Resource      ../PageObjects/Checkout.robot
Resource      ../PageObjects/LogIn.robot
Resource      ../PageObjects/MyAccount.robot
Resource      ../PageObjects/Homepage.robot
Resource      ../PageObjects/PLPscreen.robot
Resource      ../Keywords/Common.robot
Resource      MyAccount.robot

*** Keywords ***
Search For An Item
    [Arguments]    ${SEARCHSKU}
    Scroll Page to Location    0    0
    Wait Until Element Is Visible    ${SEARCHTEXTBOX_XPATH}    30s    Search bar not visible - check if header is displayed
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SEARCHTEXTBOX_XPATH}
    Sleep    0.5s
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${SEARCHTEXTBOX_XPATH}    ${SEARCHSKU}
    Sleep    1s
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SEARCHICON_XPATH}

Go To My Account
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}     #Use 'Mouse Over' for hovering popup
    Sleep    0.5
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${MYACCOUNT}

Go To Sign In Page
    Scroll Page To Location    0    0
    Wait Until Element Is Visible    ${ACCOUNT}    30s    Account icon not visible - check if header is displayed
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}
    Sleep    0.5
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SIGN_IN}

Register New Customer
    Wait Until Element Is Visible    ${ACCOUNT}    30s    Account icon not visible in header - check if header is displayed
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}
    Sleep    1
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${REGISTER}
    Wait until element is visible    ${CREATEACCOUNT}    60s
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Register
	Generate Timestamp Username
    ${FNAMERAND}    Generate Random String    8    [LOWER]
    ${FNAME}=    Set Variable    ${FNAME}${FNAMERAND}
    Set Test Variable    ${FNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${FIRSTNAME}    ${FNAME}
    ${LNAMERAND}    Generate Random String    8    [LOWER]
    ${LNAME}=    Set Variable    ${LNAME}${LNAMERAND}
    Set Test Variable    ${LNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${LASTNAME}    ${LNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${NEWEMAIL}    ${RANDOMUSERNAME}@domain.com
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${ENTERPASSWORD}    ${PASS}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CONFIRMPASSWORD}    ${PASS}
    ${ADDRESSRAND}    Generate Random String    2s[NUMBERS]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${ADDRESSLINE1}    10${ADDRESSRAND} Clackamette Dr
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CITY}    Oregon City
    Select From List By Value    ${STATESELECT}    OR
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${ZIPCODE}    97045
    ${PHONERAND}=    Generate Random String    7    [NUMBERS]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${PHONE}    888${PHONERAND}
    Click Element    ${CREATEACCOUNT}
    Sleep    2s
    Wait Until Keyword Succeeds    60s    2s    Title Should Be    Registration Confirmation
    Log To Console    Registered new customer with email ${RANDOMUSERNAME}@domain.com

Go to Cart
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CART}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Shopping Cart

Login as Registered user
    [Arguments]    ${USERNAME_ARG}    ${PASSWORD_ARG}
    Wait until element is visible    ${SIGNINBUTTON}    60s    Sign In button not visible
    Wait Until Keyword Succeeds    60s    2s    Title Should Be    Sign in
    Scroll Page To Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Click element    ${EXISTINGEMAIL}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EXISTINGEMAIL}    ${USERNAME_ARG}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${EXISTINGPASSWORD}
    Sleep    1s
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EXISTINGPASSWORD}    ${PASSWORD_ARG}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SIGNINBUTTON}
    Sleep    1s
    Wait Until Keyword Succeeds    30s    2s    Wait Until Element is Not Visible    ${SIGNINBUTTON}
    Wait until element is visible    ${ACCOUNT}    30s    
    Sleep    1s
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SIGN_OUT}    User was not logged in
    Log to console    Successfully logged in as an existing user - ${USERNAME_ARG}

Sign Out
    Scroll Page to Location    0    0
    Sleep    2
    Wait Until Element Is Visible    ${ACCOUNT}    20s
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${MYACCOUNT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SIGN_OUT}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SIGN_OUT}

Validate Header Logo
    Wait Until Element is Visible    ${HEADER_LOGO}    45s
    ${LOGOALT} =    Wait Until Keyword Succeeds    30s2s    GET ELEMENT ATTRIBUTE    ${HEADER_LOGO}    alt
    log    ${LOGOALT}

Shop By Category
    [Arguments]    ${SHOPBYCATEGORY}    ${SUBCATEGORY}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${HAMBURGERMENUBUTTON}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${HAMBURGERMENUBUTTON}
    Wait Until Element Is Visible    ${SHOPBYCATEGORY}    60
    ${MAINCATEGORYTEXT}=    Get Text    ${SHOPBYCATEGORY}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SHOPBYCATEGORY}
    Sleep    2
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SUBCATEGORY}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SUBCATEGORY}
    Sleep    2
    Element Should Contain    ${BREADCRUMBS_ALL}    ${MAINCATEGORYTEXT}

Select item from PLP
    [Arguments]    ${RESULT}
    Sleep    2
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${RESULT}
    ${ITEMNAME}=    Wait Until Keyword Succeeds    30s2s    Get Text    ${RESULT}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${RESULT}
    Wait Until Keyword Succeeds    90s    2s    Element Should Be Visible    ${ADDTOCART}
    [Return]    ${ITEMNAME}

Go to Register an Account
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ACCOUNT}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${REGISTER}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${REGISTER}

Go to Homepage
    Scroll Page To Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${HEADER_LOGO}
    Sleep    2
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${HOMEPAGEHEROCAROUSEL}

Shop By Mobile
    [Arguments]    ${MAINCATEGORY}    ${SUBCATEGORY}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${HAMBURGERMENUBUTTON}
    Sleep    3
    Click Element    ${MAINCATEGORY}
    Sleep    3
    Click Element    ${SUBCATEGORY}
