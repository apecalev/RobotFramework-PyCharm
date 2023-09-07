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
Resource      ../PageObjects/PDPscreen.robot
Resource      ../Keywords/Homepage.robot

*** Keywords ***
Add New Addres in My Account
    [Arguments]    ${DEFAULT_STATUS}    ${ARG_FIRSTNAME}    ${ARG_LASTNAME}    ${ARG_ADDRESS}    ${ARG_CITY}    ${ARG_STATE}
    ...    ${ARG_ZIP}    ${ARG_PHONE}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${ADDNEWADDRESS}
    Wait Until Keyword Succeeds    30s    2s    Wait until element is visible    ${SAVEACCOUNTINFO}
    Wait Until Keyword Succeeds    30s    2s    Title should be    New Address
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUT_FIRSTNAME_NEWADDRESS}    ${ARG_FIRSTNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUT_LASTNAME_NEWADDRESS}    ${ARG_LASTNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUT_ADDRESSLINE_NEWADDRESS}    ${ARG_ADDRESS}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUT_CITY_NEWADDRESS}    ${ARG_CITY}
    Select From List By Value    ${STATE_NEWADDRESS}    ${ARG_STATE}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUT_ZIPCODE_NEWADDRESS}    ${ARG_ZIP}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUT_PHONE_NEWADDRESS}    ${ARG_PHONE}
    Run keyword if    '${DEFAULT_STATUS}'=='YES'    Click Element    ${SETASDEFAULTADDRESS_NEWADDRESS}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${SAVEACCOUNTINFO}
    Sleep    2
    QASCheck
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ADDNEWADDRESS}
    Log To Console    Shipping address added: ${ARG_ADDRESS}, ${ARG_CITY}, ${ARG_STATE}, ${ARG_ZIP}
    Log To Console    ${DEFAULT_STATUS}

Edit address
    [Arguments]    @{ADDRESSDATA}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${EDITADDRESS}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${EDITADDRESS}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${EDITADDRESSLINE}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EDITADDRESSLINE}    @{ADDRESSDATA}[0]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EDITCITY}    @{ADDRESSDATA}[1]
    Select From List By Value    ${SELECTSTATE}    @{ADDRESSDATA}[2]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EDITZIPCODE}    @{ADDRESSDATA}[3]
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SAVEACCOUNTINFO}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SAVEACCOUNTINFO}
    #sleep    2
    #Wait Until Element Is Not Visible    ${LOADING}    30s    
    Log To Console    Successfully changed address to @{ADDRESSDATA}[2]
    Sleep    1
    Wait Until Element Is Visible    ${FOOTER}    30s    

Remove all Addresses in My Account
    ${REMOVEBLE_ADDRESSES}=    Get Element Count    ${REMOVE_ADDRESS_MYACCOUNT_BTN}
    : FOR    ${INDEX}    IN RANGE    1    ${REMOVEBLE_ADDRESSES}+1
    \    Wait Until Keyword Succeeds    30s    2s    Click Element    ${REMOVE_ADDRESS_MYACCOUNT_BTN}

Set addrees to be Default
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SETDEFAULT_ADDRESSBOOK}
    Wait Until Keyword Succeeds    30s    3s    Click Element    ${SETDEFAULT_ADDRESSBOOK}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${DEFAULTADDRESSS_LABEL}

Verify Address Book
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}
    Wait Until Element Is Visible    ${MYACCOUNT}    30s    
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${MYACCOUNT}
    Sleep    1
    Wait Until Keyword Succeeds    30s    2s    Title should be    My Account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ADDNEWADDRESS}
    Element Should Be Visible    ${ADDRESS_ADDRESSBOOK_MYACCOUNT}

Edit Default Address
    [Arguments]    @{ADDRESS_ARG}
    ${X}=    Get Element Count    ${ADDRESS_ADDRESSBOOK_MYACCOUNT}
    : FOR    ${INDEX}    IN RANGE    1    ${X}+1
    \    ${STATUS}=    Run Keyword And Return Status    ELEMENT TEXT SHOULD BE    ${ADDRESS_ADDRESSBOOK_MYACCOUNT}    Default Address
    \    Run keyword if    ${STATUS}==True    EDIT ADDRESS    @{ADDRESS_ARG}

Remove address from address book
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${REMOVE_ADDRESS_MYACCOUNT_BTN}

Edit address and set as default
    [Arguments]    @{ADDRESSDATA}
    Wait until element is visible    ${ADDRESSBOOK_LEFTNAV}    30s    
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK_LEFTNAV}
    Wait until element is visible    ${EDITADDRESS}    30s    
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${EDITADDRESS}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SIGNUPEMAIL_MAIL}
    Change default address    @{ADDRESSDATA}
    Scroll page to location    0    0

Go to Order History Page
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ORDERS_LEFTNAV}
    Wait Until Keyword Succeeds    62s    2s    Title Should Be    My Orders
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ORDERLIST}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${MYORDERSTEXT}
    ${ALLITEMSINORDERHISTORILIST}=    Get Element Count    ${ALLVIEWDETAILS_INORDERHISTORY}
    log    ${ALLITEMSINORDERHISTORILIST}

Register New Customer with invalid password
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${REGISTER}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Register
    Wait Until Keyword Succeeds    30s    2s    Input text    ${FIRSTNAME_REGISTER}    ${FNAME}
    ${LNAMERAND}    Generate Random String    5    [LOWER]
    ${LNAME}=    Set Variable    ${LNAME}${LNAMERAND}
    Set Test Variable    ${LNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${LASTNAME_REGISTER}    ${LNAME}
    Generate Timestamp Username
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EMAIL_REGISTER}    ${RANDOMUSERNAME}@domain.com
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${PASSWORD_REGISTER}    ${INCORECT_PASS}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CONFIRMPASSWORD_REGISTER}    ${INCORECT_PASS}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${ADDRESS_REGISTER}    ${CADDR1}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CITY_REGISTER}    ${CCITY}
    Select From List By Value    ${STATE_REGISTER}    ${CSTATE}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${ZIP_REGISTER}    ${CZIP}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${PHONE_REGISTER}    ${CPHONE}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CREATEACCOUNT_REGISTER}
    Sleep    3
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${INCORECTPASSWORD_REGISTER}
    ${MESSAGE}=    Get Text    ${INCORECTPASSWORD_REGISTER}
    Wait Until Keyword Succeeds    30s    2s    Should Start With    Password must contain 8-20 characters, at least one number and one letter, and at least one capital letter and one lowercase letter.    ${MESSAGE}
    Edit the password field with valid password
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CREATEACCOUNT_REGISTER}

Edit the password field with valid password
    Wait Until Keyword Succeeds    30s    2s    Input text    ${PASSWORD_REGISTER}    ${PASS}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CONFIRMPASSWORD_REGISTER}    ${PASS}
    Sleep    0.5

Click Payment wallet
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    My Account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYMENT_LEFTNAV}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PAYMENTWALLETTEXTVISIBLE}

Enter credit card details set as default
    [Arguments]    ${CREDITCARD}    ${PIN}
    Sleep    1s
    Wait Until Element Is Not Visible    ${LOADING}    60s
    Wait Until Keyword Succeeds    30s    2s    Select Frame    ${ADDNEWCARDWINDOW_XPATH}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${NAMEONCARD_XPATH}    IW
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CARDNUMBER_XPATH}    ${CREDITCARD}
    Select From List By Label    ${EXPIRATION DATE_XPATH}    August
    Select From List By Value    ${EXPIRATIONYEAR_XPATH}    ${CARDYEAR}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CVV_XPATH}    ${PIN}
    Scroll Page to Location    0    200
    Wait Until Keyword Succeeds    60s    5s    Click Element    ${CREDITCARDSAVEBUTTON_XPATH}
    ${CARDNICKNAMESTATUS}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CARDNICKNAMEBUTTON_XPATH}    45
    Run Keyword If    ${CARDNICKNAMESTATUS}==True    Click Element    ${CARDNICKNAMEBUTTON_XPATH}
    Sleep    5
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PAYMENT_METHOD_ADDED_MYACCOUNT}
    Log To Console    Added credit card: ${CREDITCARD}

Click Add New Credit Card in My Wallet Page
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ADDNEWCREDITCARD}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDNEWCREDITCARD}
    Wait Until Keyword Succeeds    90s    2s    Element Should Not Be Visible    ${LOADING}

Enter Credit Card details but dont set as default
    [Arguments]    ${CREDITCARD}    ${PIN}
    Wait Until Keyword Succeeds    30s    2s    Select Frame    ${ADDNEWCARDWINDOW_XPATH}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${NAMEONCARD_XPATH}    IW
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CARDNUMBER_XPATH}    ${CREDITCARD}
    Select From List By Label    ${EXPIRATION DATE_XPATH}    March
    Select From List By Label    ${EXPIRATIONYEAR_XPATH}    ${CARDYEAR}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CVV_XPATH}    ${PIN}
    Scroll Page to Location    0    200
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CREDITCARDSAVEBUTTON_XPATH}
    ${DEFAULTUNCHECK}    Run Keyword And Return Status    Element Should Be Visible    ${UNCHECKDEFAULTBTN}
    Run Keyword If    ${DEFAULTUNCHECK}==True    UNSELECT CHECKBOX    ${UNCHECKDEFAULTBTN}    
    ${CARDNICKNAMESTATUS}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CARDNICKNAMEBUTTON_XPATH}    30s    
    Run Keyword If    ${CARDNICKNAMESTATUS}==True    Click Element    ${CARDNICKNAMEBUTTON_XPATH}    #chrome

Enter credit card with different billing address
    [Arguments]    ${CREDITCARD}    ${PIN}    @{ADDRESSDATA}
    Wait Until Keyword Succeeds    30s    2s    Select Frame    ${ADDNEWCARDWINDOW_XPATH}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${NAMEONCARD_XPATH}    IW
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CARDNUMBER_XPATH}    ${CREDITCARD}
    Select From List By Label    ${EXPIRATION DATE_XPATH}    March
    Select From List By Label    ${EXPIRATIONYEAR_XPATH}    ${CARDYEAR}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CVV_XPATH}    ${PIN}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${UNCHECKBILLINGADDIN_ADDNEWCARD}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${INPUTADDRESS}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUTADDRESS}    @{ADDRESSDATA}[0]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUTCITYBILLING}    @{ADDRESSDATA}[1]
    Select From List By Value    ${SELECTSTATEINBILLINGADDNEWADD}    @{ADDRESSDATA}[2]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUTZIPBILLING}    @{ADDRESSDATA}[3]
    Scroll Page to Location    0    200
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CREDITCARDSAVEBUTTON_XPATH}
    ${CARDNICKNAMESTATUS}=    Run Keyword And Return Status    Element Should Be Visible    ${CARDNICKNAMEBUTTON_XPATH}
    Run Keyword If    ${CARDNICKNAMESTATUS}==True    Click Element    ${CARDNICKNAMEBUTTON_XPATH}
    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible    ${LOADING}

Sign In as Register User
    [Arguments]    ${EMAIL_ARG}    ${PASSWORD_ARG}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${SIGN_IN}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${EXISTINGEMAIL}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Sign in
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${EXISTINGEMAIL}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EXISTINGEMAIL}    ${EMAIL_ARG}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${EXISTINGPASSWORD}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EXISTINGPASSWORD}    ${PASSWORD_ARG}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SIGNINBUTTON}
    Sleep    1s
    Wait Until Element is Not Visible    ${SIGNINBUTTON}    45s

Click Online Profile
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ONLINEPROFILE}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ONLINEPROFILE}

Change new email from Online Profile
    [Arguments]    ${CHANGERANDOMEMAIL}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${FIRSTNAMEUPDATE}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${FIRSTNAMEUPDATE}    QA
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${LASTNAMEUPDATE}    Testovski
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EMAILUPDATE}    ${CHANGERANDOMEMAIL}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SAVEUPDATECHANGES}

Verify All Links on the left Navigation of My Account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${MYACCOUNT_LEFTNAV}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    My Account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${MYLISTS_LEFTNAV}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    My Lists
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ORDERS_LEFTNAV}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    My Orders
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYMENT_LEFTNAV}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Payment Wallet
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK_LEFTNAV}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Shipping Address Book
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${EMAILPREFERENCES_LEFTNAV}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Email Preferences

Go to Email Preferences
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${EMAILPREFERENCES_LEFTNAV}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Email Preferences

Verify my subscriptions
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${MYSUBSCRIPTIONSDIV}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SUBSCRIBEALLMYSUBSCRIPTIONS}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${MYSUBSSAVEBTN}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${MYSUBSMESAGE}

Change Default Address
    [Arguments]    @{ADDRESSDATA}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${EDITADDRESS}
    Wait until element is visible    ${EDITADDRESSLINE}    30s    
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${EDITADDRESSLINE}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EDITADDRESSLINE}    @{ADDRESSDATA}[0]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EDITCITY}    @{ADDRESSDATA}[1]
    Select From List By Value    ${SELECTSTATE}    @{ADDRESSDATA}[2]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EDITZIPCODE}    @{ADDRESSDATA}[3]
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SAVEASDEFAULTADDRESS}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SAVEACCOUNTINFO}
    Wait Until Keyword Succeeds    30s    2s    Set Focus To Element    ${SAVEACCOUNTINFO}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SAVEACCOUNTINFO}
    sleep    2
    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible    ${LOADING}
    Log To Console    Successfully changed address to @{ADDRESSDATA}[2]

Go To Registration page
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ACCOUNT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${REGISTER}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${REGISTER}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Register

QAScheck
    ${QASPRESENT_CHECKOUTPAGE}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${VERIFYADDRESSDIALOG_CHECKOUTPAGE}    6s
    ${SUGGESTED}=    Run Keyword If    ${QASPRESENT_CHECKOUTPAGE}    Run Keyword And Return Status    Element Should Be Visible    ${SUGGESTEDADDRESS_CHECKOUTPAGE}
    Run Keyword If    ${SUGGESTED}==True    Click Element    ${SUGGESTEDADDRESS_CHECKOUTPAGE}
    Run Keyword If    ${SUGGESTED}==False    Click Element    ${ENTEREDADDRESS_CHECKOUTPAGE}
    Sleep    2s
    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible    ${LOADING}
