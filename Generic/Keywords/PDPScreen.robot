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
Resource      ../PageObjects/PLPscreen.robot
Resource      ../Keywords/Common.robot
Resource      ../PageObjects/MyAccountOrders.robot

*** Keywords ***
Add Item to Cart
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${ITEM_PRICE_OTD_PDP}    Item price not visible on PDP
    ${ITEMPRICE}=    Wait Until Keyword Succeeds    30s2s    Get Text    ${ITEM_PRICE_OTD_PDP}
    ${PDPITEMNAME}    Wait Until Keyword Succeeds    30s2s    Get Text    ${PRODUCTNAME}
    Set Test Variable    ${PDPITEMNAME}
    Sleep    1.5s
    Wait Until Keyword Succeeds    20s    2s    Element Should Be Enabled    ${ADDTOCART}
    Sleep    1.5s
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDTOCART}
    sleep    2
    Wait Until Element Is Not Visible    ${LOADING}    30s    
    Wait Until Element Is Visible    ${CHECKOUTBUTTON_XPATH}    60s    Proceed to checkout button not visible
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${OTD_PRODUCT_PRICE_CART}
    Wait Until Keyword Succeeds    30s    2s    Element Should Contain    ${OTD_PRODUCT_PRICE_CART}    ${ITEMPRICE}

Add item as BOPUS to Cart
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${I_LL_PICK_IT_UP_TITLE_SECTION_WIDGET_PDP}    BOPUS widget not loaded on PDP
    ${WIDGET_TEXT}    Run Keyword And Return Status    Wait Until Keyword Succeeds    10S    2s    ELEMENT SHOULD CONTAIN    ${I_LL_PICK_IT_UP_TITLE_SECTION_WIDGET_PDP}
    ...    Free Pickup
    Run Keyword Unless    ${WIDGET_TEXT}    ELEMENT SHOULD CONTAIN    ${I_LL_PICK_IT_UP_TITLE_SECTION_WIDGET_PDP}    Store Pickup & Save
    Wait until element is visible    ${FREEPICKUPCHANGESTOREBTNPDP}    30s    BOPUS widget not loaded on PDP
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${BOPUS_OPTION_PDP}
    ${ISITINSTOCK}    Get Text    ${BOPUS_AVAILABILITY_PDP_WIDGET}
    ${ISITINSTOCK}    Fetch From Left    ${ISITINSTOCK}    at
    ${ISITINSTOCK}    Strip String    ${ISITINSTOCK}    mode=both
    ${BOPUSSTOREDETAIL}    Get Text    ${FREEPICKUPLOCATIONPDP}
    ${BOPUSSTOREDETAIL}    Fetch From Left    ${BOPUSSTOREDETAIL}    ,
    Set Test Variable    ${BOPUSSTOREDETAIL}
    Scroll Page to Location    0    200
    Wait until element is not visible    ${LOADING}    30s    
    Run Keyword If    '${ISITINSTOCK}' == 'AVAILABLE'    Wait Until Keyword Succeeds    40S    3S    ELEMENT SHOULD BE ENABLED    ${ADD_BOPUSTOCART_BUTTON_WIDGET}
    Run Keyword If    '${ISITINSTOCK}' == 'AVAILABLE'    Wait Until Keyword Succeeds    30s2s    Click Element    ${ADD_BOPUSTOCART_BUTTON_WIDGET}
    ...    ELSE    Run Keyword    Change Store
    Wait until element is visible    ${CHECKOUTBUTTON_XPATH}    45s    Proceed to checkout button not visible
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Shopping Cart
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${BOPUS_OPTION_SELECTED_WIDGET_CART}

Change Store
    [Documentation]    Changes store on PDP in BOPUS widget
    Wait until element is visible    ${FREEPICKUPCHANGESTOREBTNPDP}    30s    Change store button not visible on PDP
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${FREEPICKUPCHANGESTOREBTNPDP}
    Wait Until Element Is Visible    ${STORELISTBOPUS}    60s    Store list not visible on PDP
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ENTERZIPCODE_FINDASTOREMODAL}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${ENTERZIPCODE_FINDASTOREMODAL}    ${ZIPCODE_FAVORITESTORE}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${FINDASTOREBTN_PDP}
    Sleep    1s
    Wait Until Element Is Not Visible    ${LOADING}    30s    
    ${LENGTH}    Get Element Count    ${ALLSTORESLIST}
    : FOR    ${X}    IN RANGE    1    ${LENGTH}+1
    \    ${STATUS1}    Get Text    (${ITEMAVAILABILITY_CHANGESTOREMODAL})[${X}]
    \    ${STATUS}    SPLIT STRING    ${STATUS1}
    \    ${STATUS}=    GET FROM LIST    ${STATUS}    0
    \    Continue For Loop If    "${STATUS}" != "Available"
    \    Run Keyword If    '${STATUS}' == 'AVAILABLE'    Wait Until Keyword Succeeds    30s5S    Click Element    (${ALLSTORESLIST})[${X}]
    \    Exit For Loop If    '${STATUS}' == 'Available'
    Wait Until Keyword Succeeds    5s    2s    Element Should Not Be Visible    ${CLOSE_NEARESTSTORE_MODAL_PDP}    Item is not available in any store
    Sleep    2
    ${STORE}=    Get Text    ${STORENAME_BOPUSOPTION}
    Set Test Variable    ${STORE}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDTOCARTBOPUS}

Check Image and Thumbnails
    [Documentation]    Validates the presence of PDP Images - Main product image and thumbnails
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${BREADCRUMBS_ALL}
    Element Should Be Visible    ${PDPIMAGE}    Product Image not found.
    Element Should Be Visible    ${PDPTHUMBNAILS}    Thumbnail row not visible

Validate PDP Info
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${THUMBNAILIMAGES_PDP}    PDP Not loaded properly
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${DESCRIPTIONTAB}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SKUINPDP}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${DELIVER_IT_TO_ME_WIDGET_TITLE_PDP}

Increase Item Quantity
    [Arguments]    ${N}
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Enabled    ${ADDTOCART}
    Sleep    1s
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${QUANTITYINCREASE}
    : FOR    ${X}    IN RANGE    0    ${N}
    \    Click element    ${QUANTITYINCREASE}
    Sleep    3

Decrease Item Quantity
    [Arguments]    ${N}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${QUANTITYDECREASE}
    : FOR    ${X}    IN RANGE    0    ${N}
    \    Click element    ${QUANTITYDECREASE}
    Sleep    5

Add to Wish List
    Wait Until Element Is Visible    ${ADDTOWISHLIST}    15s
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDTOWISHLIST}
    Sleep    2s

Verify added to wishlist message
    Wait Until Keyword Succeeds    60s    2s    Wait Until Element Is Visible    ${MESAGEITEMADDTOWL}
    ${TEXTVERIFY}=    Get Text    ${MESAGEITEMADDTOWL}
    Should Contain    ${TEXTVERIFY}    This item has been added to your list.

Login from PDP
    [Arguments]    ${ARG1}    ${ARG2}
    ${TITLESTATUS}=    Run Keyword And Return Status    Title Should Be    Sign In
    Run Keyword If    ${TITLESTATUS}==False    Title Should Be    Sign in
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EXISTINGEMAIL}    ${ARG1}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EXISTINGPASSWORD}    ${ARG2}
    Wait Until Keyword Succeeds    25    2sClick Element    ${SIGNINBUTTON}

Verify WL Alert when item is already added to WL
    Wait Until Keyword Succeeds    30s    2s    Element Text Should Be    ${MESAGEITEMADDTOWL}    This item has already been added to your wishlist.

Check product description and attributes
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${DESCRIPTIONTAB}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${DESCRIPTIONTAB}
    Wait Until Keyword Succeeds    30s    2s    Element Should Contain    ${DESCRIPTIONTEXT}    SKU
    Scroll Page to Location    0    0
    Sleep    2s
    ${ATTRTAB}=    Run Keyword And Return Status    Element Should Be Visible    ${ATTRIBUTESTAB}
    Run Keyword If    ${ATTRTAB}==True    Click Element    ${ATTRIBUTESTAB}
    Run Keyword If    ${ATTRTAB}==True    Wait Until Keyword Succeeds    30s2s    Element Should Be Visible    ${ATTRIBUTESTEXT}

Check if prices are listed on PDP
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${OFFERPRICE}
    ${PROMOSTATUS}    Run Keyword And Return Status    Element Should Be Visible    ${LISTPRICE}
    Run Keyword If    ${PROMOSTATUS}==True    Element Should Be Visible    ${SAVINGS}
    Run Keyword If    ${PROMOSTATUS}==True    Log To Console    Item is on sale, List Price and Savings are listed on PDP
    Run Keyword If    ${PROMOSTATUS}==False    Log To Console    Item is not on sale

Roll over image to zoom functionality
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PDPIMAGEZOOM}
    ${PREVIOUSZOOM}    GET ELEMENT ATTRIBUTE    ${PDPIMAGEZOOM}    style
    Wait Until Keyword Succeeds    30s    2s    Mouse Over    ${PDPIMAGEZOOM}    #div over the image in PDP
    Wait Until Keyword Succeeds    30s    2s    Mouse Over    ${ADDTOCART}
    ${CURRENTZOOM}    GET ELEMENT ATTRIBUTE    ${PDPIMAGEZOOM}    style
    Should Not Be Equal    ${PREVIOUSZOOM}    ${CURRENTZOOM}

Roll over image to zoom functionality for thumbnails
    ${TOTALTHUMBNAILS}    Get Element Count    ${THUMBNAILX}
    ${PREVIOUSTHUMB}    GET ELEMENT ATTRIBUTE    ${PDPIMAGE}    alt
    Run Keyword If    ${TOTALTHUMBNAILS} > 1    Click Element    (${THUMBNAILX})[2]
    sleep    1s
    Log To Console    Selected 2nd thumbnail
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PDPIMAGEZOOM}
    ${PREVIOUSZOOM}    GET ELEMENT ATTRIBUTE    ${PDPIMAGEZOOM}    style
    Wait Until Keyword Succeeds    30s    2s    Mouse Over    ${PDPIMAGEZOOM}    #div over the image in PDP
    Wait Until Keyword Succeeds    30s    2s    Mouse Over    ${ADDTOCART}
    ${CURRENTZOOM}    GET ELEMENT ATTRIBUTE    ${PDPIMAGEZOOM}    style
    Should Not Be Equal    ${PREVIOUSZOOM}    ${CURRENTZOOM}

Verify Product Attributes
    [Documentation]    verifies quantity box is present, whether 'add to cart' is present under one time delivery and if rd and bopus are available)
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${QUANTITYBOX}
    Sleep    1
    ${BOPUSSTATUS}=    Run Keyword And Return Status    Element Should Be Visible    ${BOPUSELIGIBLE}
    Sleep    1
    ${ISITINSTOCK}=    Run Keyword If    ${BOPUSSTATUS}==True    Get Text    ${BOPUSAVAILABILITY}
    Run Keyword If    ${BOPUSSTATUS}==True and '${ISITINSTOCK}' == 'AVAILABLE'    Element Should Be Visible    ${ADDTOCARTBOPUS}
    ${SIZESTATUS}    Run Keyword And Return Status    Element Should Be Visible    ${SIZESELECTPDP}
    Run Keyword If    ${SIZESTATUS}==True    GET LIST ITEMS    ${SIZESELECTPDP}
    Sleep    0.5
    ${WEIGHTSTATUS}    Run Keyword And Return Status    Element Should Be Visible    ${WEIGHTSELECTPDP}
    Run Keyword If    ${WEIGHTSTATUS}==True    GET LIST ITEMS    ${WEIGHTSELECTPDP}
    Sleep    0.5
    Increase Item Quantity    1
    Decrease Item Quantity    1
    Scroll Page to Location    0    0

Select Item Weight from PDP
    [Arguments]    ${WEIGHT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${WEIGHTITEMPDP}
    Wait Until Keyword Succeeds    30s    2s    Select From List By label    ${WEIGHTITEMPDP}    ${WEIGHT}

Ask a Question on PDP
    Wait Until Keyword Succeeds    30s    3s    Element Should Be Visible    ${ASK_AND_ANSWER}
    Wait Until Keyword Succeeds    30s    3s    Click element    ${ASK_A_QUESTION}
    Wait Until Keyword Succeeds    30s    3s    Element Should Be Visible    ${POST_QUESTION_BTN}
    ${REVIEWNICKNAME}=    Generate Random String    6    [NUMBERS]
    ${REVIEWNICKNAME}=    Set Variable    TESTUSER${REVIEWNICKNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${QUESTION_TEXT_PDP}    How long does this product last?
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${NICKNAME_PDP_QUESTION}    ${REVIEWNICKNAME}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EMAIL_QUESTION_PDP}    ${EMAILACCOUNT}
    Wait Until Keyword Succeeds    25    2sClick Element    ${AGREE_CHECKBOX_PDP}
    Wait Until Keyword Succeeds    25    2sElement Should Be Enabled    ${POST_QUESTION_BTN}
    #Wait Until Keyword Succeeds    30s    3s    Element Should Be Visible    ${QUESTION_SUBMITTED_MODAL}
    #Wait Until Keyword Succeeds    30s    3s    Click element    ${CLOSE_QUESTION_SUBMITTED_BTN}
    #Wait Until Keyword Succeeds    30s    3s    Element Should Be Visible    ${THANKYOU_FORTHEQUESTION}

Verify Review Sorting Options
    Wait Until Keyword Succeeds    30s    2s    Click element    ${RATING_REVIEWS_PDP}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${REVIEWS_SECTION_PDP}
    Sleep    2s
    ${FIRSTREVIEW}=    Get Text    ${FIRST_REVIEW_PDP}
    Sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Mouse over    ${SORTBY_REVIEWS_PDP}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${MOSTHELPFUL_OPTION_SORT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Not Contain    ${FIRST_REVIEW_PDP}    ${FIRSTREVIEW}
    Sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Mouse over    ${SORTBY_REVIEWS_PDP}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${HIGHESTTOLOWESTR_OPTION_SORT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Not Contain    ${FIRST_REVIEW_PDP}    ${FIRSTREVIEW}
    Sleep    2s
    Wait Until Keyword Succeeds    30s    2s    Mouse over    ${SORTBY_REVIEWS_PDP}
    Wait Until Keyword Succeeds    30s    2s    Click element    ${LOWESTTOHIGHESTRATING_OPTION_PDP}
    Wait Until Keyword Succeeds    30s    2s    Element Should Not Contain    ${FIRST_REVIEW_PDP}    ${FIRSTREVIEW}

Write a Review On PDP
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Click element    ${WRITTEAREVIEW_BTN}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${WRITEAREWIEV_MODAL}
    Wait Until Keyword Succeeds    25    2sClick Element    ${RATING_REVIEW_MODAL}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${REVIEW_TITLE}    Remarcable
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${REVIEWCONTENT}    I was very happy to use this product very very very much
    ${NICKNAME1}=    Generate random string
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${REVIEW_NICKNAME}    ${NICKNAME1}
    Wait Until Keyword Succeeds    30s    2s    Input Text    ${EMAIL_REVIEW}    ${NICKNAME1}@domain.com
    Wait Until Keyword Succeeds    30s    2s    Select Checkbox    ${REVIEW_TERMS_ACCEPT}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Enabled    ${POSTAREVIEW_BTN}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${CLOSE_REVIEW_MODAL}
    #Wait Until Keyword Succeeds    30s    2s    Element should contain    ${REVIEW_SUBMMITTED_MODAL}    Your review was submitted!
    #Wait Until Keyword Succeeds    30s    2s    Click element    ${REMOVE_SUBMITT_MODAL_REVIEW}
    Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${WRITTEAREVIEW_BTN}
    #Wait Until Keyword Succeeds    30s    2s    Element should be visible    ${THANKYOU_FOR_REVIEW}


Click Add To Cart
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${ADDTOCART}