*** Settings ***
Documentation     Testing Website
Test Setup        Open website    ${URL}    ${browser}
Test Teardown     Close the Browser
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/PDPscreen.robot
Resource          ../Keywords/PLPscreen.robot
Resource          ../Keywords/Cartpage.robot
Resource          ../Keywords/Checkout.robot
Resource          ../resources/testdata.robot
Resource          ../PageObjects/Cartpage.robot
Resource          ../PageObjects/Checkout.robot
Resource          ../PageObjects/LogIn.robot
Resource          ../PageObjects/MyAccount.robot
Resource          ../PageObjects/MyAccountOrders.robot
Resource          ../PageObjects/Homepage.robot
Resource          ../PageObjects/PDPscreen.robot
Resource          ../PageObjects/PLPscreen.robot
Library           ../Keywords/ExternalKeywords.py

*** Test Cases ***
Verify Category Navigation, Sorting and pagination in PLP and Search result page
    [Documentation]    Verify Category Navigation, Sorting and pagination in PLP and Search result page
    [Tags]    plp    regression
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Validate PLP
    Sort By    ${MOST POPULAR}
    Verify sorting options
    Verify Results per page and Pagination

Verify search functionalities
    [Documentation]    TC036_Verify search functionalities
    [Tags]    plp    regression
    Search For An Item    ${SKUINSTOCK}    #SKU
    Validate PDP Info
    Search For An Item    Toys    #Item category
    Validate PLP
    Search For An Item    Apple    #Brand
    Validate PLP
    Element Should Be Visible    ${BRANDHEROCAROUSEL}
    Search For An Item    mikrosoft    #product name with typo
    Validate Searched term is displayed on PLP    mikrosoft
    Validate PLP
    Type in Search Bar    product    #search bar suggestions

Verify Navigation, Sorting and pagination in PLP and Search result page in potrait and landscape mode in mobile and tablet
    [Tags]    plp    regression
    [Setup]    
	Launch Mobile Browser    375    667    #portrait
    Shop By Mobile    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Scroll Page to Location    0    50
    Verify sorting options on mobile site
    Verify Results per page and Pagination
    Close Browser
    Launch Mobile Browser    667    375    #landscape
    Shop By Mobile    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Scroll Page to Location    0    50
    Verify sorting options on mobile site
    Verify Results per page and Pagination

Test the Refinements in category PLP and search results page.
    [Tags]    plp    regression
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Validate PLP
    Verify the presence of facets on PLP
    Verify Category Facet    Main products category    #string arg - category name
    Verify the functionality of the Brands Filter    Apple    #brand arg - brand string
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Verify the functionality of the Ratings filter    4    #rating stars - 1-5
    Verify the functionality of the Price Filter
    Verify the functionality of How To Get it Filter


Verify Product image structure in PLP, PDP pages
    [Tags]    regression    plp
    Smoke Setup
    Go To Sign In Page
    Login as Registered user    ${emailaccount}    ${PASS}
    Shop By Category    ${SHOP_BY_MAIN_CATEGORY}    ${SHOP_BY_SUBCATEGORY}
    Scroll Page to Location    0    1000
   	Element Should Be Visible    ${FIRSTRESULT}//img
	Element Should Be Visible    ${SECONDRESULT}//img
	Element Should Be Visible    ${FIFTHRESULT}//img
    Search For An Item    food
    Scroll Page to Location    0    1000
   	Element Should Be Visible    ${FIRSTRESULT}//img
	Element Should Be Visible    ${SECONDRESULT}//img
	Element Should Be Visible    ${FIFTHRESULT}//img
    Search For An Item    ${SKUINSTOCK}
    Scroll Page to Location    0    1000
    Element Should Be Visible    ${PDPImage}