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
Resource      ../Keywords/Checkout.robot

*** Keywords ***
Proceed to Checkout
    Wait Until Element Is Visible    ${CHECKOUTBUTTON_XPATH}    30s    Proceed to checkout button not visible
    Scroll Page to Location    0    0
    Sleep    1
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CHECKOUTBUTTON_XPATH}

Continue as a Guest on Checkout
    Wait until element is visible    ${GUESTEMAILTEXT}    30s    Guest checkout fields not visible
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${GUESTEMAILTEXT}
    Generate Timestamp Username
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${GUESTEMAILTEXT}    ${RANDOMUSERNAME}@domain.com
    ${GUESTMAIL}=    Set Variable    ${RANDOMUSERNAME}@domain.com
    Set test variable    ${GUESTMAIL}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CONTINUEASGUEST_XPATH}
    Sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Review Order
    [Return]    ${GUESTMAIL}

Verify BOPUS item in Cart
    Wait until element is visible    ${CHECKOUTBUTTON_XPATH}    30s    
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${CHECKOUTBUTTON_XPATH}
    ${SHIPPINGCHARGE}    Get Text    ${SHIPPING_CARTPAGE}
    ${SHIPPINGCHARGE}    Strip String    ${SHIPPINGCHARGE}    mode=both
    Should Be Equal    ${SHIPPINGCHARGE}    FREE
    Element Should Be Visible    ${BOPUS_OPTION_SELECTED_WIDGET_CART}
    Wait Until Element Is Visible    ${FOOTER}

Clear Cart
    Scroll Page to Location    0    0
    Sleep    2
    Wait Until Keyword Succeeds    15s    2s    Click Element    ${CART}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Shopping Cart
    #Wait Until Element Is Visible    ${CARTPOPUP}    60s    Mini cart not visible after hovering
    Sleep    0.5
    Wait Until Element Is Not Visible    ${CART_LOADING}    30s    
    Sleep    1
    ${CARTQUANTITYSTATUS}=    Run Keyword And Return Status    Element Should Be Visible    ${EMPTYCARTTEXT}
    Run Keyword If    ${CARTQUANTITYSTATUS}==False    Empty The Cart

Empty The Cart
    Wait Until Element Is Visible    ${REMOVEITEMS}    30s    
    ${X}    GET ELEMENT COUNT    ${REMOVEITEMS}
    : FOR    ${INDEX}    IN RANGE    1    ${X}+1
    \    sleep    1
    \    Wait Until Keyword Succeeds    30s    2s    Click Element    ${REMOVEITEM}
    \    Sleep    1
    \    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible    ${LOADING}
    \    Sleep    2
    Wait Until Keyword Succeeds    30s    2s    Element Should Contain    ${EMPTYCARTTEXT}    Your Cart Is Empty    ignore_case=True
    Log To Console    Emptied the cart!

Undo remove item from cart
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${UNDO_BTN}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${UNDO_BUTTON}
    Wait Until Keyword Succeeds    30s    2s    Element should not be visible    ${EMPTYCARTTEXT}

Verify Subtotal in mini cart
    Reload page
    Sleep    1s
    Wait until element is visible    ${CART}    25s
    Wait Until Keyword Succeeds    30s    2s    Mouse over    ${CART}
    Sleep    2s
    Wait until element is visible    ${SUBTOTAL_AMMOUNT_MINICART}    25s
    ${SUBTOTAL_MINICART}=    Get Text    ${SUBTOTAL_AMMOUNT_MINICART}
    ${PRICE}=    Get Text    ${SUBTOTAL_CARTPAGE}
    Wait Until Keyword Succeeds    6s    2s    Should Be Equal    ${SUBTOTAL_MINICART}    ${PRICE}

Save Item for Later From Cart
    Scroll Page to Location    0    0
    Sleep    3s
    Wait Until Element Is Not Visible    ${LOADING}    45s
    Wait Until Keyword Succeeds    10s    2s    Element Should Be Visible    ${SAVEFORLATER}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${SAVEFORLATER}
    Wait Until Keyword Succeeds    15s    2s    Element Should Be Visible    ${SAVEFORLATER_SECTION}

Increase Item Quantity on CartPage
    [Arguments]    ${N}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${INCREASEQTYCARTPAGE}
    : FOR    ${X}    IN RANGE    0    ${N}
    \    Wait Until Keyword Succeeds    30s    2s    Set Focus To Element    ${INCREASEQTYCARTPAGE}
    \    Wait Until Keyword Succeeds    30s    2s    Click element    ${INCREASEQTYCARTPAGE}
    \    sleep    2s
    \    Wait Until Element Is Not Visible    ${LOADING}    30s    
    Sleep    4s

Decrease Item Quantity on CartPage
    [Arguments]    ${N}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${DECREASEQTYCARTPAGE}
    : FOR    ${X}    IN RANGE    0    ${N}
    \    Set Focus To Element    ${DECREASEQTYCARTPAGE}
    \    Click element    ${DECREASEQTYCARTPAGE}
    Sleep    4s

Increase save for later item quantity
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Click element    ${INCREASEQUANTITY_SAVEFORLATER}
    Sleep    3

Decrease save for later item quantity
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Click element    ${DECREASEQUANTITY_SAVEFORLATER}
    Sleep    3

Move Item from save for later section to cart
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${MOVETOCART_SAVEFORLATERSECTION}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${MOVETOCART_SAVEFORLATERSECTION}
    Wait Until Keyword Succeeds    30s    2s    Element should not be visible    ${EMPTYCARTTEXT}

Remove all items from save for later section
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SAVEFORLATER_SECTION}
    ${X}    GET ELEMENT COUNT    ${SAVE_FOR_LATER_COUNT}
    : FOR    ${INDEX}    IN RANGE    1    ${X}+1
    \    sleep    1s
    \    Click Element    ${DELETE_ITEM_SFL_SECTION}
    \    Sleep    1s
    \    Wait Until Element Is Not Visible    ${LOADING}    30s    
    \    Sleep    1s
    \    Wait Until Element Is Visible    ${EMPTYCARTTEXT}    30s    
    Sleep    2s

Verify Shipping Logic on Cart Page
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Shopping Cart
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SHIPPING_CARTPAGE}
    ${TOTAL}=    Wait Until Keyword Succeeds    30s    S    2S    Get Text    ${SUBTOTAL_CARTPAGE}
    ${TOTAL_STRING}=    REMOVE STRING    ${TOTAL}    $
    ${TOTAL_INT}=    CONVERT TO NUMBER    ${TOTAL_STRING}    0
    Sleep    1
    ${STATUS}=    EVALUATE    ${TOTAL_INT}>${FREE_SHIPPING_THRESHOLD}
    ${SHIPPING}=    Wait Until Keyword Succeeds    30s    S    2S    Get Text    ${SHIPPING_CARTPAGE}
    Run Keyword if    ${STATUS}==TRUE    SHOULD BE EQUAL    ${SHIPPING}    FREE
    ...    ELSE    Should Be Equal    ${SHIPPING}    ${STANDARDSSHIPPINGCOSTS}

Verify Add Promo code availability on Cart Page
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PROMOCODE_CARTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${APPLYPROMOCODE_BTN_CARTPAGE}

Add Valid Promo Code on Cart Page
    [Arguments]    ${PROMO_ARG}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Shopping Cart
    ${TOTALAMMOUNT}=    Get Text    ${ORDERTOTAL_SHOPPINGCARTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${APPLYPROMOCODE_BTN_CARTPAGE}
    Scroll Page to Location    0    500
    Set Focus To Element    ${PROMOCODE_CARTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${PROMOCODE_CARTPAGE}    ${PROMO_ARG}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${APPLYPROMOCODE_BTN_CARTPAGE}
    Sleep    2s
    Wait Until Element Is Not Visible    ${LOADING}    45s
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PROMOTIONAPPLIED_CARTPAGE}
    ${PROMOTIONAMOUNT_CARTPAGE}=    Get Text    ${PROMOTIONAPPLIED_CARTPAGE}
    Set Test Variable    ${PROMOTIONAMOUNT_CARTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Element Text Should Not Be    ${ORDERTOTAL_SHOPPINGCARTPAGE}    ${TOTALAMMOUNT}
    [Return]    ${PROMOTIONAMOUNT_CARTPAGE}

Add Invalid Promo Code on Cart page
    [Arguments]    ${PROMO_ARG}
    Wait Until Element Is Visible    ${APPLYPROMOCODE_BTN_CARTPAGE}    60
    Scroll Page to Location    500    500
    Set Focus To Element    ${APPLYPROMOCODE_BTN_CARTPAGE}
    Wait Until Keyword Succeeds    30s    2s    Input text    ${PROMOCODE_CARTPAGE}    ${PROMO_ARG}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${APPLYPROMOCODE_BTN_CARTPAGE}
    SLeep    1s
    Wait Until Element Is Not visible    ${LOADING}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PROMOTION_ERRORMESSAGE}
    #Wait Until Keyword Succeeds    30s    2s    Element should contain    ${PROMOTION_ERRORMESSAGE}    The promotion code you have entered is invalid. Please verify the code and try again.
    Wait Until Keyword Succeeds    30s    2s    Clear element text    ${PROMOCODE_CARTPAGE}
    sleep    2s

Remove promotion from cart page
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Shopping Cart
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${APPLYPROMOCODE_BTN_CARTPAGE}
    ${PROMOSTATUS}=    Run Keyword And Return Status    Element Should Be Visible    ${REMOVEPROMOCODE_BTN_CARTPAGE}
    Run keyword if    ${PROMOSTATUS}==TRUE    Wait Until Keyword Succeeds    30s    S    2S    CLICK ELEMENT    ${REMOVEPROMOCODE_BTN_CARTPAGE}
    Sleep    2
    Run keyword if    ${PROMOSTATUS}==True    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Shopping Cart

Verify Cart items displayed
    [Arguments]    ${PDPITEMNAME}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${CHECKOUTBUTTON_XPATH}
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${ITEMINSHOPPINGCART}
    Page should contain    ${PDPITEMNAME}
    Log to console    Item ${SKU} is added in cart.

Change store by zip in Find a Store modal
    [Arguments]    ${ZIP}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${FINDASTOREMODAL_PDP}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${ENTERZIPCODE_FINDASTOREMODAL}    ${ZIP}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${FINDASTOREBTN_PDP}
    sleep    2
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${FINDASTOREMODAL_PDP}