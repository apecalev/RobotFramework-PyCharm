*** Settings ***
Documentation     Testing the homepage
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
Test New user is able to access registration page and register an account 
    [Documentation]    New user is able to Register
    [Tags]    homepage    regression
    Register New Customer
    Check Successful Registration

Test the working of all Header Links
    [Documentation]    To verify the header is available in below pages
    [Tags]    homepage    regression
    Verify Header Lists    ${H_HOMEPAGE}
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Verify Header Lists    ${H_PLP}
    Search For An Item    ${SKUINSTOCK}
    Verify Header Lists    ${H_PDP}
    Add Item to Cart
    Verify Header Lists    ${H_CART}
    Proceed to Checkout
    Verify Header Lists    ${H_SIGNIN}
    Login from interstitial page    ${emailaccount}    ${PASS}
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Add Credit Card
    Enter Credit Card Details    ${AMEXCARD}    ${GiftPin}
    Click Place Order
    Verify Order is Placed
    Verify Header Lists    ${H_ORDERCONFIRMATIONPAGE}
    Click Home Logo
    Type in Search Bar    product
    
Test working of all Footer Links
    [Documentation]    Test working of all Footer Links
    [Tags]    homepage    regression
    Verify Footer Is Present    #Homepage
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Verify Footer Is Present    #PLP
    Search For An Item    ${SKUINSTOCK}
    Verify Footer Is Present    #PLP
    Scroll Page to Location    0    0
    Add Item to Cart
    Verify Footer Is Present    #Cart Page
    Proceed to Checkout
    Verify Footer Is Present    #Sign In Interstitial
    Login from interstitial page    ${emailaccount}    ${PASS}
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Add Credit Card
    Enter Credit Card Details    ${ValidCreditCard}    ${GiftPin}
    Click Place Order
    Verify Order is Placed
    Verify Footer Is Present    #Order Confirmation
    Go to My Account
    Verify Footer Is Present    #My Account pages
    Sign Out
    Go to Register an Account
    Verify Footer Is Present    #Register
    Go To Sign In page
    Verify Footer Is Present    #Sign In
    Verify all Footer Links are Working

Search bar  - Verify if user can see trending or top categories and products
    [Tags]    account    regression
    Type in Search Bar    product
    sleep    5s
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${TRENDING_Categories_Search}    #Trending ctegories
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${TRENDING_PRODUCTS_Search}    #Trending products
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${TRENDING_BRANDS_Search}    #Trending brands

Verify promo items in homepage
    [Tags]    homepage    regression
    Scroll Page to Location    0    2000
    Verify Sponsored Recommendations    Homepage
	${rand}    Generate Random String    1    1234
    ${Sponsoredprice}=    Get Text    (${HomepageCarousel_ItemPrice)[${rand}]
    ${Sponsoredprice}=    fetch from right    ${Sponsoredprice}    $
    Wait Until Keyword Succeeds    30s    2s    Click element    (${HomepageCarousel_ItemName})[${rand}]
    ${PDP_price}    get text    ${ItemPrice_PDP}
    ${PDP_price}    fetch from right    ${PDP_price}    $
    Should Be Equal    ${Sponsoredprice}    ${PDP_price}
