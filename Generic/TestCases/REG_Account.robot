*** Settings ***
Documentation     Testing Website
Test Setup        Open website    ${URL}    ${browser}
Test Teardown     Close the Browser
Library           ../resources/environments.py
Resource          ../Keywords/Cartpage.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/MyAccount.robot
Resource          ../Keywords/MyAccountOrders.robot
Resource          ../Keywords/PDPscreen.robot
Resource          ../Keywords/PLPscreen.robot
Resource          ../Keywords/Login.robot
Resource          ../Keywords/Common.robot
Resource          ../resources/testdata.robot
Resource          ../PageObjects/Cartpage.robot
Resource          ../PageObjects/Checkout.robot
Resource          ../PageObjects/LogIn.robot
Resource          ../PageObjects/MyAccount.robot
Resource          ../PageObjects/MyAccountOrders.robot
Resource          ../PageObjects/Homepage.robot
Resource          ../PageObjects/PDPscreen.robot
Resource          ../PageObjects/PLPscreen.robot
Resource          ../Keywords/Homepage.robot

*** Test Cases ***
Verify user is able to view, add, edit, remove addresses and set/remove a default address in Address Book page
    [Documentation]    Verify if registered user is
    ...    - able to view the already saved addresses in Address book
    ...    - able to add new address as default
    ...    - able to edit an address
    ...    - able to remove an address 
    ...    - able to set an address to default
    [Tags]    account    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Go To My Account
    Verify address book
    #Remove all Addresses in My Account
    Add New Addres in My Account    Default    ${fname}    ${lname}    ${caddr1}    ${ccity}    ${cstate}    ${czip}    ${cphone}
    Add New Addres in My Account    Not Default    ${fname}    ${lname}    ${ohaddr1}    ${ohcity}    ${ohstate}    ${ohzip}    ${cphone}
    Edit address    @{ALASKA}
    Edit Default address    @{HAWAII}
    Remove address from address book
    Set addrees to be Default
    Remove default address
    Remove all Addresses in My Account

Verify user is able to sign from different pages
    [Tags]    account    regression
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Sign In as Register User    ${emailaccount}    ${PASS}
    Sign Out
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Select item from PLP    ${FIRSTRESULT}
    Search For An Item    ${SKUINSTOCK}
    Sign In as Register User    ${emailaccount}    ${PASS}
    Sign Out
    Search For An Item    ${SKUINSTOCK}
    Add Item to Cart
    Sign In as Register User    ${emailaccount}    ${PASS}
    Sign Out
    Sign In as Register User    ${emailaccount}    ${PASS}
    Sign Out

Verify user able to change logon email from my account page
    [Tags]    account    regression
    Register New Customer
    Go To My Account
    Click Online Profile
    Generate STRING username    #produces RANUSER variable
    Change new email from Online Profile    ${RANUSER}@iw.com
    Page Should Contain    ${RANUSER}@iw.com
    Sign Out
    Go To Sign In Page
    Login as Registered user    ${RANUSER}@iw.com    ${PASS}
    Go To My Account
    Page Should Contain    ${RANUSER}@iw.com

Verify user is able to view and edit details in My Account page
    [Documentation]    To verify if user is able to perform below actions in My Account
    ...    * edit My Account and save the changes.
    ...    * able to set preferred store in change my store.
    ...    * check Store hours under My Account - My Store.
    ...    * check Member since date is displaying in My Account.
    ...    * access the Left Navigation links in My Account page
    [Tags]    account    regression
    Go To Sign In Page
    Login as Registered user    ${palsaccount}    ${PASS}
    Go To My Account
	Verify Member Since is Visible and Contains Date
    Check Online Profile in My Account
    Click Change My Store
    Change My store - Set New Store
    Go To My Account
    Verify Store was changed successfully
    Go to Homepage
    Go To My Account
    Verify All Links on the left Navigation of My Account

Verify user is able to access all the links in Email preferences in My Account page - Check subscribe/unsubscribe functionality
    [Documentation]    Verify if user is able to do below in the account
    ...    * set email preferences
    ...    * save interests
    [Tags]    account    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Go To My Account
    Go to Email Preferences
    Verify my subscriptions
    Verify product interest subscriptions

Verify user is able to go to register page from different pages
    [Tags]    account    regression
    Register New Customer
    Sign Out
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
	Register New Customer
    Sign out
    Search For An Item    ${SKUINSTOCK}
    Register New Customer
    Sign out
    Search For An Item    ${SKUINSTOCK}
    Add item to cart
    Register New Customer
    Sign Out

Verify user can add or modify payment methods in My Account page
    [Documentation]    Verify user able to access all the links in Payment wallet in My Account page
    [Tags]    account    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Go to My Account
    Search For An Item    ${SKUINSTOCK}
    Add Item To Cart
    Proceed to Checkout
    Select Shipping Method    ${STANDARDSHIPPING}
	Click Add Credit Card
    Enter Credit Card Details    ${VISA}    ${GiftPin}
    Click Place Order
    Verify Order is Placed
    Go to My Account
    Click Payment wallet
    Click Add New Credit Card in My Wallet Page
    Enter credit card details set as default    ${VISA2}    ${GiftPin}
    Click Add New Credit Card in My Wallet Page
    Enter credit card details set as default    ${DISCOVER}    ${GiftPin}
    Remove default card and set a new default
    Click Add New Credit Card in My Wallet Page
    Enter Credit Card details but dont set as default    ${VISA2}    ${GiftPin}
    Click Add New Credit Card in My Wallet Page
    Enter credit card with different billing address    ${MasterCard}    ${GiftPin}    @{CALIFORNIA}
    Remove default Credit Card

Test user is able to access all the links in My Orders in My Account page
    [Documentation]    To verify if user is able to access all the links in My Orders in My Account page
    [Tags]    account    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Go to My Account
    Go to Order History Page
    Check Page Navigation in Order History
    Check Order History Item Details

User Registration - Register New Customer with invalid password
    [Tags]    account    regression
    Register New Customer with invalid password