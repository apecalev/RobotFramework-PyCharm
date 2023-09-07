*** Settings ***
Documentation     Testing Website
Suite Setup       Run Keyword    Wait Until Keyword Succeeds    5x    5s    Smoke Setup
Suite Teardown    Close all the browsers
Test Setup        Open website    ${URL}    ${browser}
Test Teardown     Close the Browser
Library           ../resources/environments.py
Resource          ../resources/env.txt
Resource          ../Keywords/Cartpage.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/Common.robot
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/MyAccount.robot
Resource          ../Keywords/MyAccountOrders.robot
Resource          ../Keywords/PDPscreen.robot
Resource          ../Keywords/PLPscreen.robot
Resource          ../Keywords/Login.robot
Resource          ../resources/testdata.robot
Resource          ../PageObjects/Cartpage.robot
Resource          ../PageObjects/Checkout.robot
Resource          ../PageObjects/LogIn.robot
Resource          ../PageObjects/MyAccount.robot
Resource          ../PageObjects/MyAccountOrders.robot
Resource          ../PageObjects/Homepage.robot
Resource          ../PageObjects/PDPscreen.robot
Resource          ../PageObjects/PLPscreen.robot

*** Test Cases ***
TC001 - Create user and Validate Pals in My account page
    [Documentation]    C17843 - This script validates user can successfully create an user and a Pals is generated
    [Tags]    smoke
    Register New Customer
    Go To My Account

TC002 - Place an order as a Guest with Credit Card
    [Documentation]    This script validates user can successfully place an order as a guest.
    [Tags]    smoke
    Search For An Item    ${REGULARSKU}
    Add item to cart
    Proceed to Checkout
    Continue as a Guest on Checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{STATE_OREGON}
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Add Credit Card
    Enter Credit Card Details    ${VISA}   ${CCPin}
    Click Place Order
    Verify Order is Placed

TC003 - Place an order as a Guest with Gift Card
    [Documentation]    This script validates user can successfully place an order with Gift card as a guest.
    [Tags]    smoke
    Search For An Item    ${REGULARSKU}
    Add item to cart
    Proceed to Checkout
    Continue as a Guest on Checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{STATE_OREGON}
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Gift Card Toggle
    Enter Gift Card    ${GIFTCARD_1}    ${GiftPin}
    Click Add Credit Card
    Enter Credit Card Details    ${VISA}   ${CCPin}
    Click Place Order
    Verify Order is Placed

TC004 - Log in as a Registered user and place an order with Credit Card
    [Documentation]    This script validates user can successfully login as a Registered user and place an order with Credit Card
    [Tags]    smoke
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Search For An Item    ${REGULARSKU}
    Add item to cart
    Proceed to Checkout
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Add Credit Card
    Enter Credit Card Details    ${VISA}   ${CCPin}
    Click Place Order
    Verify Order is Placed

TC005 - Place an BOPUS order with GC
    [Documentation]    This script validates user can successfully place an BOPUS order with GC Card
    [Tags]    smoke
    #3467    these 3 lines are can be uncommented to get registered user place a bopus order
    #Login as Registered user    ${emailaccount}    ${PASS}
    #Clear Cart    if these are uncommented, please comment line 7 and 8
    Search For An Item    ${REGULARSKU2}
    Add item as BOPUS to Cart
    BOPUS in Cart
    Proceed to Checkout
    Continue as a Guest on Checkout
    Enter store pickup person info    ${fname}    ${lname}    ${cphone}
    Click Gift Card Toggle
    Enter Gift Card    ${GIFTCARD_1}    ${GiftPin}
    Click Add Credit Card
    Enter Credit Card Details Store Pickup Order    ${AMEXCARD}    ${CCPin}
    Click Place Order
    Verify Order is Placed


TC006 - Registered user places PayPal order
    [Documentation]    Registered user Place an Paypal order
    [Tags]    smoke
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Search For An Item    ${REGULARSKU}
    Add item to cart
    Proceed to Checkout
    Select Shipping Method    ${STANDARDSHIPPING}
    Select PayPal Payment    ${PAYPALEMAIL_VALID}    ${PAYPALPASSWORD_VALID}
    Click Place Order
    Verify Order is Placed