*** Settings ***
Documentation     Testing Website
Suite Setup       Run Keyword    Wait Until Keyword Succeeds    5x    5s    Smoke Setup
Test Setup        Open website    ${URL}    ${browser}
Test Teardown     Close the Browser
Library           ../resources/environments.py
Resource          ../resources/env.txt
Resource          ../Keywords/Cartpage.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/MyAccount.robot
Resource          ../Keywords/MyAccountOrders.robot
Resource          ../Keywords/PDPscreen.robot
Resource          ../Keywords/PLPscreen.robot
Resource          ../resources/testdata.robot
Resource          ../PageObjects/Cartpage.robot
Resource          ../PageObjects/Checkout.robot
Resource          ../PageObjects/LogIn.robot
Resource          ../PageObjects/MyAccount.robot
Resource          ../PageObjects/MyAccountOrders.robot
Resource          ../PageObjects/Homepage.robot
Resource          ../PageObjects/PDPscreen.robot
Resource          ../PageObjects/PLPscreen.robot
Library           DatabaseLibrary
Resource          ../resources/testdata.robot

*** Test Cases ***
Verify the Mini Cart, CLP(Cart Landing Page) and the shopping cart
    [Documentation]    To verify the Mini Cart, CLP(Cart Landing Page) and the shopping cart.
    [Tags]    cart    regression
    Register new customer
    Search For An Item    ${REGULARSKU}
    Validate PDP Info
    Add Item To Cart
    Mini cart Verification
    Clear cart
    Undo remove item from cart
    Get Items in cart count
    Verify Subtotal in mini cart
    Increase Item Quantity on CartPage    1
    Decrease Item Quantity on CartPage    1
    Verify Subtotal in mini cart
    Save Item for Later From Cart
    Increase save for later item quantity
    Decrease save for later item quantity
    Move Item from save for later section to cart
    Save Item for Later From Cart
    Remove all items from save for later section

Verify Shipping charge is calculated for orders less than $XX.XX
    [Tags]    cart    regression
    Register new customer
    Search For An Item    ${REGULARSKU2}
    Add item to cart
    Verify Shipping Logic on Cart Page

Verify product recommendations are getting displayed on cart page
    [Documentation]    To Verify product recommendations are getting displayed on cart page (eg Recently Viewed Items, Recommended for you ..)
    [Tags]    cart    regression
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Select item from PLP    ${SECONDRESULT}
    Check product description and attributes
    Check if prices are listed on PDP
    Search For An Item    ${REGULARSKU}
    Verify Recommendation Widgets are visible at PDP
    Add Item To Cart
    Title should be    Shopping Cart
    Verify Recommendation Widgets are visible on cart page
    Verify Recently Viewed Items Is Displayed
    ${recentlyviewedno}=    Evaluate    0<${countproducts}<6
    Run Keyword If    ${recentlyviewedno}==False    Fail    No Recently Viewed Items Displayed

To Verify that cart items are retained after guest users signs in
    [Tags]    cart    regression
    Go to sign in page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Search For An Item    ${REGULARSKU}
    Add Item To Cart
    Sign Out
    Search For An Item    ${REGULARSKU2}
    Add Item To Cart
    Proceed to Checkout
    Login from interstitial page    ${emailaccount}    ${PASS}
    Return To Cart From Checkout
    Verify Cart items displayed    ${REGULARSKU}
    Verify Cart items displayed    ${REGULARSKU2}

Verify the user can apply and remove applied promo code in cart page
    [Documentation]    Verify the user can apply and remove applied promo code in cart page
    [Tags]    cart    regression
    Search For An Item    ${REGULARSKU}
    Add Item to Cart
    Add Valid Promo Code on Cart Page    ${VALID_PROMO_CODE}
    Remove promotion from cart page

Verify item can be moved to save for later and back to cart and item can be deleted from the cart
    [Tags]    cart    regression
    Go to sign in page
    Login as Registered user    ${emailaccount}    ${PASS}
    Search For An Item    ${REGULARSKU}
    Add Item to Cart
    Save Item for Later From Cart
    Move Item From Save For Later Section To Cart
    Clear Cart
    Undo Remove Item From Cart
