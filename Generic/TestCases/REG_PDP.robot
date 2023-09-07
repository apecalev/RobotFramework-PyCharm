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
Resource          ../PageObjects/Login.robot
Resource          ../PageObjects/MyAccount.robot
Resource          ../PageObjects/MyAccountOrders.robot
Resource          ../PageObjects/Homepage.robot
Resource          ../PageObjects/PDPscreen.robot
Resource          ../PageObjects/PLPscreen.robot
Resource          ../Keywords/Login.robot
Resource          ../Keywords/Common.robot

*** Test Cases ***
Verify  the functionalities in PDP for regular items
    [Documentation]    Verify all the functionalities in PDP for regular items
    [Tags]    pdp    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Clear Cart
    Sign Out
    Search For An Item    ${SKUINSTOCK}    #review item - thumbs/videos
    Check Image and Thumbnails
    Roll over image to zoom functionality
    Roll over image to zoom functionality for thumbnails
    Check product description and attributes
    Check if prices are listed on PDP
    Verify Product Attributes
	Add to Wish List
    Login from PDP    ${emailaccount}    ${PASS}
    Verify added to wishlist message
    Add to Wish List
    Verify WL Alert when item is already added to WL
    Verify the presence of sticky header

Verify the ask and answer section in PDP
    [Tags]    pdp    regression
    Search For An Item    ${SKUINSTOCK}
    Scroll page to location    0    500
    Ask a Question on PDP


Verify Flix Media and Webcollage contents are displaying in PDP
    [Tags]    pdp    regression
    Search For An Item    ${WEBCOLAGE_CONTENT_SKU}
    Verify Marketing info displayed on PDP for Web colage content Sku
    Scroll Page to Location    500    0
    Search For An Item    ${FLIXMEDIA_SKU}
    Verify Marketing info displayed on PDP for Flix Media sku

Verify the user is able to review a product from PDP
    [Tags]    pdp    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Wait Until Element Is Visible    ${REVIEWSANDRATINGS_SECONDITEM_PLP}
    ${NumberOfReviews}=    get text    ${REVIEWSANDRATINGS_SECONDITEM_PLP}
    Select item from PLP    ${SECONDRESULT}
    Wait Until Element Is Visible    ${RAITING_REVIEWS_PDP}
    Element Should Contain    ${RAITING_REVIEWS_PDP}    ${NumberOfReviews}
    Search For An Item    ${SKUINSTOCK}
    Verify Review Sorting Options
    Write a Review On PDP
    Sleep    2
    Scroll Page to Location    0    0
    Sign Out
    #Mail should be sent to the user for confirming review
    #Guest
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Wait Until Element Is Visible    ${REVIEWSANDRATINGS_SECONDITEM_PLP}
    ${NumberOfReviews}=    get text    ${REVIEWSANDRATINGS_SECONDITEM_PLP}
    Select item from PLP    ${SECONDRESULT}
    Wait Until Element Is Visible    ${RAITING_REVIEWS_PDP}
    Element Should Contain    ${RAITING_REVIEWS_PDP}    ${NumberOfReviews}
    Search For An Item    ${SKUINSTOCK}
    Verify Review Sorting Options
    Write a Review as a Guest on PDP

Verify user's preferred store is displayed at the top of the list in Find a Store modal on clicking Change Store
    [Tags]    pdp    regression
    Register New Customer
    Go To My Account
    Click element    ${CHANGEMYSTORELINK}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Store Locator
    Change My store - Set New Store    #we can add arguments for zip or store name
    Scroll Page to Location    0    0
    Go To My Account
    Verify Store was changed successfully
    Search For An Item    ${BOPUSINSTOCK}
    Verify Product attributes - Pickup in Store
    Click Element    ${FREEPICKUPCHANGESTOREBTNPDP}
    sleep    2
    Verify Details on Find a store modal
    Change store by zip in Find a Store modal    ${CAZIPCODE}
    Click Element    ${FREEPICKUPCHANGESTOREBTNPDP}
    Verify Details on Find a store modal

Verify the display of Recommendation Widgets in Add to Cart Interstitial Modal for Normal Items
    [Documentation]    Verify New Add To Cart Interstitial Modal is displayed
    [Tags]    pdp    regression
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Search For An Item    ${SKUINSTOCK}
    Click Add To Cart
    ${POPUP_MODAL}=    Run Keyword And Return Status    Verify ATC Modal And Proceed To Checkout
    Run Keyword If    ${POPUP_MODAL}==False    Wait Until Element Is Visible    ${checkoutbutton_xpath}    60s    Proceed to checkout button not visible
    Search For An Item    ${BOPUSINSTOCK}
    Click Add To Cart
    ${POPUP_MODAL}=    Run Keyword And Return Status    Verify ATC Modal And Proceed To Checkout
    Run Keyword If    ${POPUP_MODAL}==False    Wait Until Element Is Visible    ${checkoutbutton_xpath}    60s    Proceed to checkout button not visible