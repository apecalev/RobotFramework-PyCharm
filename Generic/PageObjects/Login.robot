*** Settings ***
Documentation     LogIn page locators
Library           SeleniumLibrary    timeout=60
Library           BuiltIn
Library           Collections
Library           String

*** Variables ***
${FIRSTNAME}
${LASTNAME}
${NEWEMAIL}
${ENTERPASSWORD}
${CONFIRMPASSWORD}
${ADDRESSLINE1}
${CITY}
${STATESELECT}
${ZIPCODE}
${PHONE}
${CREATEACCOUNT}
${SIGNIN}
${EXISTINGEMAIL}
${EXISTINGPASSWORD}
${SIGNINBUTTON}
${CREATEACC_FROM_SIGNIN_PAGE}
${LOGINERROR}
