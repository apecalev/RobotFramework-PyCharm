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
Resource      ../Keywords/Common.robot

*** Keywords ***
Enter Shipping Address
    [Arguments]    ${ARG_FIRSTNAME}    ${ARG_LASTNAME}    ${ARG_PHONE}    @{ADDRESSDATA}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Review Order
    ${ADDNEWSTATUS}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ADDNEWADDRESS_CHECKOUTPAGE}    7s
    Run Keyword If    ${ADDNEWSTATUS}==True    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDNEWADDRESS_CHECKOUTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${INPUTFIRSTNAME_CHECKOUTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUTFIRSTNAME_CHECKOUTPAGE}    ${ARG_FIRSTNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUTLASTNAME_CHECKOUTPAGE}    ${ARG_LASTNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUTADDRESS1_CHECKOUTPAGE}    @{ADDRESSDATA}[0]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUTCITY_CHECKOUTPAGE}    @{ADDRESSDATA}[1]
    Wait Until Keyword Succeeds    30s    2s    Select From List By Value    ${INPUTSTATE_CHECKOUTPAGE}    @{ADDRESSDATA}[2]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUTZIP_CHECKOUTPAGE}    @{ADDRESSDATA}[3]
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${INPUTPHONE_CHECKOUTPAGE}    ${ARG_PHONE}
    Sleep    0.5s
    ${ADDRESS_MODAL}    Run Keyword And Return Status    Element Should Be Visible    ${SAVEADDRESSMODAL_CHECKOUTPAGE}
    Run Keyword If    ${ADDRESS_MODAL}    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SAVEADDRESSMODAL_CHECKOUTPAGE}

Click Add Credit Card
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDNEWCARD_BUTTON_XPATH}
    sleep    2s
    Wait Until Element Is Not Visible    ${LOADING}
    sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ADDNEWCARDWINDOW_CHECKOUTPAGE}

Enter Card Details
    [Arguments]    ${CREDITCARD_NUMBER}    ${CVV_NUMBER}
    Sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Select frame    ${ADDNEWCARDWINDOW_CHECKOUTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${NAMEONCARD_XPATH}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${NAMEONCARD_XPATH}    IW
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CARDNUMBER_XPATH}    ${CREDITCARD_NUMBER}
    Select From List By Label    ${EXPIRATION DATE_XPATH}    March
    Select From List By Value    ${EXPIRATIONYEAR_XPATH}    ${CARDYEAR}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${CVV_XPATH}    ${CVV_NUMBER}
    Scroll Page to Location    0    200
    Run Keyword And Ignore Error    Wait Until Keyword Succeeds    30s    2s    Select Checkbox    ${SAMEADDRESSASSHIPPING_NCRCHECKBOX}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CREDITCARDSAVEBUTTON_XPATH}
    Log To Console    Added credit card: ${CREDITCARD_NUMBER}
    Sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${PLACEORDERBUTTON_CHECKOUTPAGE}

Click Gift Card Toggle
    Sleep    0.5s
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Review Order
    ${GC_COLLAPSED}=    Run Keyword And Return Status    Element Should Not Be Visible    ${APPLYGIFTCARD}
    Run Keyword If    ${GC_COLLAPSED}==True    Wait Until Keyword Succeeds    30s    2s    Click Element    ${GIFTCARDSECTION_CHECKOUTPAGE}
    Run Keyword If    ${GC_COLLAPSED}==True    Wait Until Element Is Visible    ${APPLYGIFTCARD}    30s    Gift cart section not properly loaded on checkout page
    Sleep    1s

Enter Gift Card
    [Arguments]    ${GIFTCARDNO}    ${GIFTPIN}
    #    Wait until element is visible    ${GIFTCARDNUMBERFIELD_CHECKOUTPAGE}    30s    
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${GIFTCARDNUMBERFIELD_CHECKOUTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Input text    ${GIFTCARDNUMBERFIELD_CHECKOUTPAGE}    ${GIFTCARDNO}
    Wait Until Keyword Succeeds    30s    2s    Input text    ${GIFTCARDPINFIELD_CHECKOUTPAGE}    ${GIFTPIN}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${APPLYGIFTCARD}
    Sleep    5s
    Wait Until Keyword Succeeds    20s    3s    Element Should Be Visible    ${GIFTCARDAPPLIEDTEXT_CHECKOUTPAGE}
    Log to console    Used ${GIFTCARDNO} GC

Click Place Order
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PLACEORDERBUTTON_CHECKOUTPAGE}
    Scroll Page to Location    0    0
    Sleep    2s

Verify Order is Placed
    Wait Until Element is Visible    ${ORDERNO_ORDERCONFIRMATION_CHECKOUTPAGE}    60s    Order not placed - check screenshot for errors on checkout page
    Wait Until Keyword Succeeds    110s    5s    Element Should Be Visible    ${ORDERNO_ORDERCONFIRMATION_CHECKOUTPAGE}
    Sleep    0.5s
    ${ORDERNO}=    Get Text    ${ORDERNO_ORDERCONFIRMATION_CHECKOUTPAGE}
    ${ORDERNO}=    Strip String    ${ORDERNO}    mode=both
    Log To Console    Placed order: ${ORDERNO}
    Set Test Variable    ${ORDERNO}

Enter store pickup person info
    [Arguments]    ${ARG_FIRSTNAME}    ${ARG_LASTNAME}    ${ARG_PHONE}
    Wait until element is visible    ${BOPUSFIRSTNAME}    30s    
    Wait Until Keyword Succeeds    30s    2s    Page Should Contain    Pick Up
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${BOPUSFIRSTNAME}    ${ARG_FIRSTNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${BOPUSLASTNAME}    ${ARG_LASTNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${BOPUSPHONE}    ${ARG_PHONE}
    Sleep    1s
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${BOPUSSECTION_SAVEANDCONTINUE_CHECKOUTPAGE}

Select Shipping Method
    [Arguments]    ${SHIPPINGMETHOD_ARG}
    Wait until element is visible    ${SHIPPINGMETHOD_ARG}    45s    Shipping method is missing on checkout page
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SHIPPINGMETHOD_ARG}
    Sleep    2
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SAVEANDCONTINUE_SHIPPINGMETHOD_CHECKOUTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element Should Not Be Visible    ${SAVEANDCONTINUE_SHIPPINGMETHOD_CHECKOUTPAGE}

Check Tax Calculation for TAX FREE states
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${TAX_CHECKOUTPAGE}
    ${X}    Get Text    ${TAX_CHECKOUTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Should Be Equal    ${X}    $0.00

Return To Cart From Checkout
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CHECKOUT_LOGO}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${RETURNTOCART}

Select PayPal Payment
    [Arguments]    ${PAYPALEMAIL_ARG}    ${PAYPALPASSW_ARG}
    Wait until element is visible    ${PLACEORDERBUTTON_CHECKOUTPAGE}    30s    Place order button is not visible
    sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SELECTPAYPALPAYMENT}
    sleep    2s
    ${EXISTINGPAYPALSTATUS}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${EXISTINGPAYPALACCOUNT_CHECKOUTPAGE}    10s
    Run Keyword If    ${EXISTINGPAYPALSTATUS}==False    PAYPALSANDBOX    ${PAYPALEMAIL_ARG}    ${PAYPALPASSW_ARG}   #perform actions in Paypal Sandbox
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Review Order
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYMENTSECTION_SAVEANDCONTINUE_CHECKOUTPAGE}
    Sleep    3s
    Wait until element is visible    ${PLACEORDERBUTTON_CHECKOUTPAGE}    30s    Place order button is not visible

Verify Gift Card applied amount
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${GIFTCARDTEXTORDERSUMMARY}
    Wait Until Keyword Succeeds    30s    2s    Element Text Should Be    ${GIFTCARDTEXTORDERSUMMARY}    Gift Card
    ${GCPAIDAMOUNT}=    Get Text    ${GIFTCARDPAIDAMOUNT}
    ${GCPAIDAMOUNT}=    Fetch From Right    ${GCPAIDAMOUNT}    $
    ${ORDERSUMMARYGCAMOUNT}=    Get Text    ${ORDERSUMMARYGIFTCARDAMMOUNTAPPLIED}
    Set Test Variable    ${ORDERSUMMARYGCAMOUNT}
    Should Be Equal As Numbers    ${ORDERSUMMARYGCAMOUNT}    ${GCPAIDAMOUNT}

Verify Payment Method
    [Arguments]    ${PAYMENTMETHOD}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ORDERNO_ORDERCONFIRMATION_CHECKOUTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element Should Contain    ${PAYMENTINFORMACTIONSECTION_ORDERCONFIRMATION}    ${PAYMENTMETHOD}

Remove Gift Card
    ${GIFTCARDSSTATUS}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${REMOVEGIFTCARD}    6s
    Run Keyword If    ${GIFTCARDSSTATUS}==True    Wait Until Keyword Succeeds    30s    2s    Click Element    ${REMOVEGIFTCARD}
    Sleep    1s

Check Tax on TOTAL
    [Arguments]    ${STATETAX}
    [Documentation]    Checks whether calculation for the tax is ok
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PLACEORDER_BUTTON}
    Sleep    3
    ${SUBTOTAL}=    Get Text    ${SUBTOTAL_CHECKOUTPAGE}
    ${SUBTOTAL}=    Fetch From Right    ${SUBTOTAL}    $
    ${SUBTOTAL}=    Convert To Number    ${SUBTOTAL}
    ${SHIPPING_TOTAL}=    Get Text    ${SHIPPING_CHECKOUT}
    ${STAT}=    Run Keyword And Return Status    SHOULD BE EQUAL AS STRINGS    FREE    ${SHIPPING_TOTAL}
    ${SHIPPING}    Set Variable IF    ${STAT}==True    0.00    ${SHIPPING_TOTAL}
    ${SHIPPING}=    Fetch From Right    ${SHIPPING}    $
    ${SHIPPING}=    Convert To Number    ${SHIPPING}
    ${TOTALFORTAX}=    Evaluate    ${SUBTOTAL}+${SHIPPING}
    ${TAX}=    Get Text    ${TAX_CHECKOUTPAGE}
    ${TAX}=    Fetch From Right    ${TAX}    $
    ${TAX}=    Convert To Number    ${TAX}
    ${CALCULATED}=    Evaluate    ${TOTALFORTAX} * ${STATETAX} / 100
    ${CALCULATED0}=    Evaluate    ROUND(${CALCULATED},2)
    ${CALCULATED1}=    Evaluate    ROUND(${CALCULATED0},1)
    ${CALCULATED2}=    Evaluate    ROUND(${TAX},1)
    Should Be Equal    ${CALCULATED1}    ${CALCULATED2}

Verify applied promocodes are reflected on Checkout
    [Arguments]    ${PROMOTIONAMOUNT_CARTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${PROMOTIONAPPLIED_CHECKOUT}
    ${PROMOTION}=    Get Text    ${PROMOTION_ORDER_SUMMARY_CHECKOUTPAGE}
    Should Be Equal    ${PROMOTION}    ${PROMOTIONAMOUNT_CARTPAGE}

Remove Promocode on Checkout Page
    Wait Until Keyword Succeeds    30s    2s    Click element    ${EXPANDPROMOSECTION_CHECKOUT}
    sleep    5s
    Wait Until Element Is Visible    ${APPLYPROMOCODE_BTN_CHECKOUT}    10s
    ${ALLPROMOS}    Get Element Count    ${ALL_PROMOS_XPATH}
    : FOR    ${I}    IN RANGE    1    ${ALLPROMOS}+1
    \    Wait Until Element Is Visible    (${ALL_PROMOS_XPATH})[1]    10s
    \    Wait Until Keyword Succeeds    20s    2s    Click element    (${ALL_PROMOS_XPATH})[1]
    \    Sleep    2s
    \    ${STAT}=    Run keyword and return status    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible
    \    ...    (${ALL_PROMOS_XPATH})[1]
    \    Run Keyword if    ${STAT}==False    Click Element    (${ALL_PROMOS_XPATH})[1]
    \    sleep    3
    Sleep    5s
    Wait Until Keyword Succeeds    30s    2s    Element Should Not Be Visible    ${PROMOTIONAPPLIED_CHECKOUT}

Enter valid promocode on Checkout
    [Arguments]    ${PROMO_ARG}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PLACEORDER_BUTTON}
    ${APPLYPROMO}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PROMOCODE_CHECKOUT}    12s
    Run Keyword If    ${APPLYPROMO}==False    Wait Until Keyword Succeeds    10S    3S    Click Element    ${EXPANDPROMOSECTION_CHECKOUT}
    Wait Until Element Is Visible    ${PROMOCODE_CHECKOUT}    30s    
    ${PROMOSTATUS}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${REMOVEPROMOCODE}    5s
    Run keyword if    ${PROMOSTATUS}==True    Wait Until Keyword Succeeds    10S    3S    Click Element    ${REMOVEPROMOCODE}
    Sleep    0.5s
    Wait Until Keyword Succeeds    30s    2s    Input text    ${PROMOCODE_CHECKOUT}    ${PROMO_ARG}
    Sleep    1s
    Wait Until Element is Not Visible    ${LOADING}    45s
    Wait Until Keyword Succeeds    30s    2s    Click element    ${APPLYPROMOCODE_BTN_CHECKOUT}
    Sleep    2s
    Wait Until Element is Not Visible    ${LOADING}    45s
    Wait Until Element Is Visible    ${PROMOTIONAPPLIED_CHECKOUT}    30s    
    Log to console    ${PROMO_ARG} applied

Enter Invalid Promocode on checkout
    [Arguments]    ${INVALIDPROMO_ARG}
    Wait Until Element Is Visible    ${EXPANDPROMOSECTION_CHECKOUT}    60
    ${APPLYPROMO}=    Run Keyword And Return Status    Element Should Be Visible    ${PROMOCODE_CHECKOUT}
    Run Keyword If    ${APPLYPROMO}==False    Click Element    ${EXPANDPROMOSECTION_CHECKOUT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${APPLYPROMOCODE_BTN_CHECKOUT}
    sleep    1s
    Wait Until Keyword Succeeds    30s    2s    Input text    ${PROMOCODE_CHECKOUT}    ${INVALIDPROMO_ARG}
    Sleep    1
    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible    ${LOADING}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${APPLYPROMOCODE_BTN_CHECKOUT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Contain    ${INVALIDPROMOCODE_ERRORMESSAGE}    The promotion code you have entered is invalid. Please verify the code and try again.

PayPalSandbox
    [Arguments]    ${PAYPALEMAIL_ARG}    ${PAYPALPASSW_ARG}
    ${PAYPALPOPUP_CHECKOUTPAGE}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PAYPALMODAL_CHECKOUTPAGE}    45s
    Run Keyword If    ${PAYPALPOPUP_CHECKOUTPAGE}    Wait Until Keyword Succeeds    30s    2s    ELEMENT SHOULD BE ENABLED    ${PAYPALMODAL_CONTINUE_CHECKOUTPAGE}
    Sleep    12s
    Run Keyword If    ${PAYPALPOPUP_CHECKOUTPAGE}    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYPALMODAL_CONTINUE_CHECKOUTPAGE}
    #PAYPAL SANDBOX
    Sleep    5s
    Wait Until Element Is Not Visible    ${PAYPALLOADING}    90
    Wait Until Keyword Succeeds    90s    2s    Element Should Be Visible    ${PAYPALFOOTER}
    Sleep    2s
    ${PAYPALSTATUS}=    Run Keyword And Return Status    Element Should Be Visible    ${PAYPALLOGINSECTION}
    ${PAYPALSTATUS2}=    Run Keyword And Return Status    Title Should Be    PayPal Checkout
    Run Keyword If    ${PAYPALSTATUS}==True and ${PAYPALSTATUS2}==True    Wait Until Element Is Not Visible    ${PAYPALLOADING}    90
    Run Keyword If    ${PAYPALSTATUS}==True and ${PAYPALSTATUS2}==True    Wait Until Element Is Visible    ${PAYPALLOGINSECTION}    90
    Run Keyword If    ${PAYPALSTATUS}==True and ${PAYPALSTATUS2}==True    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYPALLOGINSECTION}
    Sleep    1
    Wait Until Element Is Not Visible    ${PAYPALLOADING}    90    PayPal Sandbox error
    Wait Until Keyword Succeeds    90s    2s    Element Should Be Visible    ${PAYPALEMAIL}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${PAYPALEMAIL}    ${PAYPALEMAIL_ARG}
    ${PAYPALCOOKIES}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PAYPALACCEPTCOOKIES}    5s
    Run Keyword If    ${PAYPALCOOKIES}==True    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYPALACCEPTCOOKIES}
    ${PAYPALNEXTBUTTON}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PAYPAL}    10s
    Run Keyword If    ${PAYPALNEXTBUTTON}==True    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYPAL}
    Sleep    1
    Wait Until Element Is Not Visible    ${PAYPALLOADING}
    Wait Until Keyword Succeeds    90s    2s    Element Should Be Visible    ${PAYPALPASSWORD}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${PAYPALPASSWORD}    ${PAYPALPASSW_ARG}
    Wait Until Keyword Succeeds    90s    2s    Click Element    ${PAYPALLOGIN}
    Wait Until Element Is Not Visible    ${PAYPALLOADING}    90
    Sleep    2s
    Sleep    2s
    Sleep    2s
    ${PAYPALCOOKIES}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PAYPALACCEPTCOOKIES}    5s
    Run Keyword If    ${PAYPALCOOKIES}==True    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYPALACCEPTCOOKIES}
    Sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYPALCONTINUECREDITCARDSSECTION}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYPALCONFIRMORDER}
    sleep    3

Verify Order Confirmation Page Details
    Wait Until Element is Visible    ${ORDERNO_ORDERCONFIRMATION_CHECKOUTPAGE}    45s
    Sleep    0.5s
    Sleep    1
    ${ORDERNO}=    Get Text    ${ORDERNO_ORDERCONFIRMATION_CHECKOUTPAGE}
    Log To Console    Order number is: ${ORDERNO}
    Set Test Variable    ${ORDERNO}
    Wait Until Keyword Succeeds    30s    2s    Page Should Contain    Payment Information
    Wait Until Keyword Succeeds    30s    2s    Page Should Contain    Shipping Information
    Wait Until Keyword Succeeds    30s    2s    Page Should Contain    Order Summary
    #Wait Until Keyword Succeeds    30s    2s    Page Should Contain    Delivery Method

Verify PO BOX Shipping Message
    ${PO_WARNING}    Run Keyword And Return Status    Wait Until Keyword Succeeds    10S    2s    Element Should Be Visible    ${POBOXSHIPPINGMESSAGEBOX}
    Run Keyword If    ${PO_WARNING}    Wait Until Keyword Succeeds    30s    2s    ELEMENT SHOULD CONTAIN    ${POBOXSHIPPINGMESSAGEBOX}
    ...    ${POBOXSHIPPINGMESSAGEWARNING}
    Run Keyword If    ${PO_WARNING}    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${UPDATESHIPPINGADDRESS_POBOX}

Verify Ship to store info on checkout page
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${PICKUPINSTORE_REVIEWORDER}
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${STORE_PICKUPINSTORE}
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${PICKUP_INFO}
    Wait Until Keyword Succeeds    30s    2s    Element should not be visible    ${SHIPPINGINFORMATIONSECTION_XPATH}

Verify BOPUS Order is Placed
    Wait Until Element Is Not Visible    ${LOADING}    60s
    Wait Until Keyword Succeeds    60s    5    Element Should Be Visible    ${ORDERNO_ORDERCONFIRMATION_CHECKOUTPAGE}
    Sleep    1
    ${ORDERNO}=    Get Text    ${ORDERNO_ORDERCONFIRMATION_CHECKOUTPAGE}
    Log To Console    Order number is: ${ORDERNO}
    Set Test Variable    ${ORDERNO}
    ${PICKUPLOCATION}    Get Text    ${PICKUPINSTORE_ORDERCONFIRMATION}
    Should contain    ${PICKUPLOCATION}    Pick Up Location

Verify shipping charges for Register user and One time Delivery Option when order less than shipping threshold
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SHIPPING_CHECKOUT}
    ${SHIPPINGAMOUNT}=    Get Text    ${SHIPPING_CHECKOUT}
    Sleep    1
    ${TOTAL}=    Get Text    ${SUBTOTAL_CHECKOUTPAGE}
    ${TOTAL_STRING}=    REMOVE STRING    ${TOTAL}    $
    ${TOTAL_INT}=    Convert To Number    ${TOTAL_STRING}
    Run Keyword if    ${TOTAL_INT}>${FREE_SHIPPING_THRESHOLD}    SHOULD BE EQUAL    ${SHIPPINGAMOUNT}    FREE
    ...    ELSE    Should Be Equal    ${SHIPPINGAMOUNT}    ${STANDARDSSHIPPINGCOSTS}

Enter Pick Up In Store Details on checkout page
    Wait Until Keyword Succeeds    30s    2s    Title should be    Review Order
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PICKUPINSTORE_REVIEWORDER}
    ${LNAMERAND}    Generate Random String    5    [LOWER]
    ${LNAME}=    Set Variable    ${LNAME}${LNAMERAND}
    Set Test Variable    ${LNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${FNAME_PICKUPINSTORE_CHECKOUTPAGE}    ${FNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${LNAME_PICKUPINSTORE_CHECKOUTPAGE}    ${LNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${PHONE_PICKUP_CHECKOUTPAGE}    ${CPHONE}
    Wait Until Keyword Succeeds    60s    3s    Element Should Not Be Visible    ${LOADING}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${BOPUSSECTION_SAVEANDCONTINUE_CHECKOUTPAGE}
    Sleep    1s

Verify no shipping charges for store pickup only order
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PICKUPINSTORE_REVIEWORDER}
    Wait Until Keyword Succeeds    30s    2s    Element Should Not Be Visible    ${SHIPPING_CHECKOUT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Not Be Visible    ${MAKEADONATION_SECTION_CHECKOUTPAGE}

Check Tax Calculation on SUBTOTAL
    [Arguments]    ${STATETAX}
    [Documentation]    Checks whether calculation for the tax on subtotal only
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PLACEORDER_BUTTON}
    Sleep    2
    ${SUBTOTAL}=    Get Text    ${SUBTOTAL_CHECKOUTPAGE}
    ${SUBTOTAL}=    Fetch From Right    ${SUBTOTAL}    $
    ${SUBTOTAL}=    Convert To Number    ${SUBTOTAL}
    ${TAX}=    Get Text    ${TAX_CHECKOUTPAGE}
    ${TAX}=    Fetch From Right    ${TAX}    $
    ${TAX}=    Convert To Number    ${TAX}
    ${CALCULATED}=    Evaluate    ${SUBTOTAL} * ${STATETAX} / 100
    ${CALCULATED0}=    Evaluate    ROUND(${CALCULATED},2)
    ${CALCULATED1}=    Evaluate    ROUND(${CALCULATED0},1)
    ${CALCULATED2}=    Evaluate    ROUND(${TAX},1)
    Should Be Equal    ${CALCULATED1}    ${CALCULATED2}

Verify Shipping Charges for PO BOX Address
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SHIPPINGPRICE_CHECKOUTPAGE}
    ${SHIPP}=    Get Text    ${SHIPPINGPRICE_CHECKOUTPAGE}
    ${SHIPP_PO}=    Fetch From Right    ${SHIPP}    $
    ${SHIPP_PO}=    Run Keyword If    '${SHIPP_PO}'=='FREE'    Set Variable    0.00
    ${SHIPP_PO_AMOUNT}=    Convert To Number    ${SHIPP_PO}
    Evaluate    ${SHIPP_PO_AMOUNT}>5.99
    Set Test Variable    ${SHIPP_PO}

Expand Payment Section_CheckoutPage
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PAYMENTSECTION_CHECKOUTPAGE}
    ${EDIT_PAYMENT_CHECKOUTPAGE}=    Run Keyword And Return Status    Wait Until Keyword Succeeds    2s    2s    Element Should Be Visible    ${PAYMENTSECTION_EDIT_CHECKOUTPAGE}
    Run Keyword If    ${EDIT_PAYMENT_CHECKOUTPAGE}    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PAYMENTSECTION_EDIT_CHECKOUTPAGE}

Save and Continue on Shipping Method section
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Review Order
    Sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${SAVEANDCONTINUE_SHIPPINGMETHOD_CHECKOUTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element should not be visible    ${SAVEANDCONTINUE_SHIPPINGMETHOD_CHECKOUTPAGE}