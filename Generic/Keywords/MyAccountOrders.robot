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
Resource      ../PageObjects/MyAccountOrders.robot

*** Keywords ***
Click on Order Details
    ${ORDERNUMBER_ORDERHISTORY}    Get Text    ${MYORDERS_ORDERHISTORY_ORDERNUMBER}
    ${ORDERNUMBER_ORDERHISTORY} =    Convert To String    ${ORDERNUMBER_ORDERHISTORY}
    ${ORDERNUMBER_ORDERHISTORY} =    Fetch From Right    ${ORDERNUMBER_ORDERHISTORY}    Number
    Set Test Variable    ${ORDERNUMBER_ORDERHISTORY}
    Element Should Contain    ${MYORDERS_ORDERHISTORY_ORDERDETAILS}    view details
    Wait Until Keyword Succeeds    25    2sClick Element    ${MYORDERS_ORDERHISTORY_ORDERDETAILS}
    sleep    2s

Verify order details page
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ORDERHISTORY_SECTION_MYACCOUNT}
    Wait Until Keyword Succeeds    30s    2s    Title should be    My Orders
    Wait Until Keyword Succeeds    30s    2s    Click element    ${ORDERHISTORY_ORDERDETAILS_VIEWDETAILS}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ORDERDETAILS_SECTION}
    Wait Until Keyword Succeeds    30s    2s    Title should be    Order Details
    Element should be visible    ${ORDERPLACED_DATE_ORDERDETAILS}
    Element should be visible    ${ORDERNUMBER_ORDERDETAILS}
    Element should be visible    ${ORDERSTATUS_ORDERDETAILS}
    Element should be visible    ${ORDERTOTAL_ORDERDETAILS}
    Element should be visible    ${PAYMENTMETHOD_ORDERDETAILS}
    Element should be visible    ${ORDERSUMMARY_ORDERDETAILS}

Click Order history from Order Confirmation page
    Wait Until Keyword Succeeds    30s    2s    Click element    ${ORDERHISTORY_ORDERCONFIRMATION_CHECKOUTPAGE}
    Wait Until Keyword Succeeds    45s    2s    Element Should Be Visible    ${ORDERHISTORY_SECTION_MYACCOUNT}
