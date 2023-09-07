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
Resource      ../PageObjects/Homepage.robot

*** Keywords ***
Check Successful Registration
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${CONTINUESHOPPING_REGPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${MYACCOUNT_REGPAGE}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CONTINUESHOPPING_REGPAGE}
    Sleep    5s
    Go Back
    Sleep    5s
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Registration Confirmation
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${CONTINUESHOPPING_REGPAGE}
    Element Should Be Visible    ${MYACCOUNT_REGPAGE}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${MYACCOUNT_REGPAGE}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    My Account
    Sleep    5s
    Go Back
    Sleep    5s
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Registration Confirmation
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${CONTINUESHOPPING_REGPAGE}
    Element Should Be Visible    ${MYACCOUNT_REGPAGE}