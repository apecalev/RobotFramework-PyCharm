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
Resource          ../Keywords/SDDKeywords.robot
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
Resource          ../Keywords/MyAccount.robot
Library           DatabaseLibrary
Resource          ../PageObjects/OBO.robot
Resource          ../PageObjects/MyAccountOrders.robot

*** Test Cases ***
Validate whether tax is not getting calculated for the Sales Tax free states
    [Documentation]    Validate whether tax is not being applied for:
    ...    AK;
    ...    DE;
    ...    MT;
    ...    NH;
    ...    OR
    [Tags]    checkout    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Go to my account
    Edit address and set as default    @{STATE_OREGON}
    Search For An Item    ${REGULARSKU}
    Add Item To Cart
    Proceed To Checkout
    Select Shipping Method    ${STANDARDSHIPPING}
    Check Tax Calculation for TAX FREE states
    Return To Cart From Checkout
    Go to my account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK}
    Change Default Address    @{DELAWARE}
    Go To Cart
    Proceed To Checkout
    Check Tax Calculation for TAX FREE states
    Return To Cart From Checkout
    Go to my account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK}
    Change Default Address    @{MONTANA}
    Go To Cart
    Proceed To Checkout
    Check Tax Calculation for TAX FREE states
    Return To Cart From Checkout
    Go to my account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK}
    Change Default Address    @{NEW_HAMPSHIRE}
    Go To Cart
    Proceed To Checkout
    Check Tax Calculation for TAX FREE states
    Return To Cart From Checkout
    Go to my account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK}
    Change Default Address    @{ALASKA}
    Go To Cart
    Proceed To Checkout
    Check Tax Calculation for TAX FREE states
    Return To Cart From Checkout

Test tax is getting calculated for a taxable state
    [Documentation]    Test tax is getting calculated for Arizona. Tax charge should be 8.7% as per tax jar
    [Tags]    checkout    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Select item from PLP    ${SECONDRESULT}
    Add Item to Cart
    Go To My Account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK}
    Change Default Address    @{ARIZONA}
    Go to Cart
    Proceed to Checkout
    Check Tax Calculation on SUBTOTAL    ${AZ_TAX_VALUE}

Test tax for ppparel product is getting calculated for PA state. Tax charge should be 8%
    [Documentation]    Test tax Apparel Product is getting calculated for PENSYLVANIA. Tax charge should be 8 %
    [Tags]    checkout    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Search For An Item    ${APPAREL}
    Add Item to Cart
    Go To My Account
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDRESSBOOK}
    Change Default Address    @{PENSYLVANIA}
    Go to Cart
    Proceed to Checkout
    Check Tax on TOTAL    ${PA_APPAREL_TAX_VALUE}

Verify whether user is able to apply or remove the promo code in shopping cart and checkout
    [Tags]    checkout    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Search For An Item    ${REGULARSKU}
    Add Item to Cart
    Verify Add Promo code availability on Cart Page
    Remove promotion from cart page
    Add Invalid Promo Code on Cart page    ${INVALID_PROMOCODE}
    ${PromotionApplied}=    Add Valid Promo Code on Cart Page    ${VALID_PROMOCODE1}
    Proceed to Checkout
    Select Shipping Method    ${STANDARDSHIPPING}
    Verify applied promocodes are reflected on Checkout    ${PromotionApplied}
    Remove Promocode on Checkout Page
    Enter Invalid Promocode on checkout    ${INVALID_PROMOCODE}
    Enter valid promocode on Checkout    ${VALID_PROMOCODE1}

Verify whether the user is navigated to proper page on updating the PO Box shipping address
    [Documentation]    Verify whether the user is navigated to proper page on updating the PO Box shipping address
    [Tags]    checkout    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Search For An Item    ${REGULARSKU}
    Add Item To Cart
    Proceed to Checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{POBOXPA}
    Verify PO BOX Shipping Message
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{PENSYLVANIA}
    Element Should Not Be Visible    ${POBOXShippingMessageBox}    #PO BOX Shipping warning

Verify if guest user places an order for Normal, Special item using Amex + Promo code(AMOUNT OFF)
    [Documentation]    Verify if guest user places an order for Normal, Rx item using Amex + \ Promo(AMOUNT OFF)
    [Tags]    checkout    regression
    Search For An Item    ${REGULARSKU}
    Add Item to Cart
    Search For An Item    ${SPECIAL_DELIVERY_SKU}
    Add Item to Cart
    Proceed to Checkout
    Continue as a Guest on Checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{PENSYLVANIA}
    Save and Continue on Shipping Method section
    Enter valid promocode on Checkout    ${AMTOFF_PROMOCODE}
    Click Add Credit Card
    Enter Credit Card Details    ${AMEXCARD}    ${CCPin}
    Click Place Order
    Verify Order is Placed

Verify a registered user can place a single line ship-to-store order and verify order details page
    [Tags]    checkout    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Go to my account
    Search For An Item    ${REGULARSKU2}
    Add item as BOPUS to Cart
    Verify BOPUS location on cart page
    Proceed to checkout
    Verify Ship to store info on checkout page
    Enter store pickup person info    ${fname}    ${lname}    ${cphone}
    Click add credit card
    Enter Credit Card Details Store Pickup Order    ${VISA}    ${CCPin}
    Click place order
    Verify Order is Placed
    Click Order history from Order Confirmation page
    Verify order details page

Verify whether a registered user is able to place an order with multiple line items by adding new shipping address using credit card
    [Tags]    checkout    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear cart
    Search For An Item    ${REGULARSKU}
    add item to cart
    Search For An Item    ${REGULARSKU2}
    Add item to cart
    Proceed to checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{STATE_OREGON}
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Add Credit Card
    Enter Credit Card Details    ${VISA}    ${CCPin}
    Click place order
    Verify Order is Placed

Verify the shipping charges when normal items are added and subtotal is less than shipping threshold
    [Tags]    checkout    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear cart
    Go to my account
    Edit address and set as default    @{STATE_OREGON}
    Search For An Item    ${REGULARSKU2}
    Add item to cart
    Proceed to checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{STATE_OREGON}
    Save and Continue on Shipping Method section
    Verify shipping charges for Register user and One time Delivery Option when order less than shipping threshold

Verify that no shipping charges are added to the order when it contains only store pickup item
    [Tags]    checkout    regression
    Search For An Item    ${REGULARSKU2}
    Add item as BOPUS to Cart
    Proceed to Checkout
    Continue as a Guest on Checkout
    Enter Pick Up In Store Details on checkout page
    Click Add Credit Card
    Enter Credit Card Details Store Pickup Order    ${MasterCard}    ${GiftPin}
    Verify no shipping charges for store pickup only order

Verify whether a registered user is able to place an order with single line item by adding new shipping address and Amex card
    [Tags]    checkout    regression
    Go to sign in page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear cart
    Search For An Item    ${REGULARSKU}
    add item to cart
    Proceed to Checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{PENSYLVANIA}
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Add Credit Card
    Enter Credit Card Details    ${AMEXCARD}    ${CCPin}
    Click Place Order
    Verify Order is Placed

Verify whether a registered user is able to place an order with single line item using existing shipping address and Visa card payment
    [Tags]    checkout    regression
    Go to sign in page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear cart
    Search For An Item    ${REGULARSKU}
    Add Item to Cart
    Proceed to checkout
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Add Credit Card
    Enter Credit Card Details    ${VISA}    ${CCPin}
    Click place order
    Verify order is placed

Verify whether a registered user is able to place an order with normal and BOPUS item by adding new shipping address and Discover Card
    [Tags]    checkout    regression
    Go to sign in page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Search For An Item    ${REGULARSKU}
    Add Item to Cart
    Search For An Item    ${REGULARSKU2}
    Add item as BOPUS to Cart
    Verify BOPUS location on cart page
    Proceed to checkout
    Select Shipping Method    ${STANDARDSHIPPING}
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${PICKUPINSTORE_REVIEWORDER}
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${STORE_PICKUPINSTORE}
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${PICKUP_INFO}
    Enter Pick Up In Store Details on checkout page
    Click add credit card
    Enter Credit Card Details    ${DISCOVER}    ${GiftPin}
    Click place order
    Verify BOPUS Order is Placed


Validate Shipping cost for the order when user add PO BOX as shipping address
    [Documentation]    Validate Shipping cost for the order when user add PO BOX as shipping address
    [Tags]    checkout    regression
    Go to sign in page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Search For An Item    ${REGULARSKU}
    Add Item to Cart
    Proceed to Checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{POBOXPA}
    Select Shipping Method    ${STANDARDSHIPPING}
    Verify Shipping Charges for PO BOX Address

Verify Guest user is able to place single line order with Paypal
    [Documentation]    Verify Guest user is able to place OTD Order with Paypal
    [Tags]    checkout    regression
    Search For An Item    ${REGULARSKU}
    Add Item to Cart
    Proceed to Checkout
    Continue as a Guest on Checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{STATE_OREGON}
    Select Shipping Method    ${STANDARDSHIPPING}
    Select PayPal Payment    ${PAYPALEMAIL_VALID}    ${PAYPALPASSWORD_VALID}
    Click Place Order
    Verify Order is Placed

Check whether Gift Card section is displayed in Review Order Page when normal items are in cart
    [Tags]    checkout    regression
    Go to sign in page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear cart
    Search For An Item    ${REGULARSKU}
    add item to cart
    Proceed to Checkout
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Gift Card Toggle
    Remove Gift Card
    Click Gift Card Toggle
    Enter gift card    ${GIFTCARD_1}    ${GiftPin}
    Verify Gift Card applied amount
    Scroll Page to Location    500    0
    Return To Cart From Checkout
    Proceed to checkout
    Click Gift Card Toggle
    Verify Gift Card applied amount

Verify whether a registered user is able to place an order with multiple line items by adding new shipping address using Giftcard and credit card payment
    [Tags]    checkout    regression
    Go to sign in page
    Login as Registered user    ${emailaccount}    ${PASS}
    Search For An Item    ${REGULARSKU}
    Add Item to Cart
    Search For An Item    ${REGULARSKU2}
    Add Item to Cart
    Proceed to Checkout
    Enter Shipping Address    ${fname}    ${lname}    ${cphone}    @{CALIFORNIA}
    Select Shipping Method    ${STANDARDSHIPPING}
    Click Gift Card Toggle
    Remove Gift Card
    Click Gift Card Toggle
    Enter Gift card    ${GIFTCARD_1}    ${GiftPin}
    Verify Gift Card applied amount
    Click Add Credit Card
    Enter Credit Card Details    ${VISA}    ${CCPin}
    Click place order
    Verify Order Confirmation Page Details
    Verify Payment Method    ${GC_PaymentMethod}

Verify whether a registered user is able to place an order with multiple line items using existing shipping address and paypal payment
    [Tags]    checkout    regression
    Go to sign in page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear cart
    Search For An Item    ${REGULARSKU}
    add item to cart
    Search For An Item    ${REGULARSKU2}
    add item to cart
    Proceed to checkout
    Select Shipping Method    ${STANDARDSHIPPING}
    Select PayPal Payment    ${PAYPALEMAIL_VALID}    ${PAYPALPASSWORD_VALID}
    Click Place Order
    Verify order is placed