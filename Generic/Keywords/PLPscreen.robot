*** Settings ***
Documentation     Suite description
Library       SeleniumLibrary    timeout=60
Library       BuiltIn
Library       Collections
Library       String
Library       DatabaseLibrary
Resource      ../resources/testdata.robot
Resource      ../PageObjects/Cartpage.robot
Resource      ../PageObjects/Checkout.robot
Resource      ../PageObjects/LogIn.robot
Resource      ../PageObjects/MyAccount.robot
Resource      ../PageObjects/Homepage.robot
Resource      ../PageObjects/PLPscreen.robot
Resource      ../PageObjects/PDPscreen.robot
Resource      ../Keywords/Common.robot

*** Keywords ***
Validate PLP
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PRICE_CONTAINER}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${BRAND_CONTAINER}
    ${RATINGSSTATUS}    Run Keyword And Return Status    Element Should Be Visible    ${RATING_CONTAINER}
    Run Keyword If    ${RATINGSSTATUS}==False    Log    RATINGS not visible
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SORTBY_PLP}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PAGERESULTS}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${TOTALRESULTS}
    ${RESULTSTEMP}    Get Text    ${TOTALRESULTS}
    ${RESULTSFINAL}    Fetch From Left    ${RESULTSTEMP}    results
    Run Keyword If    ${RESULTSFINAL} > 48    Element Should Be Visible    ${NEXTPAGE_PLP}

Verify Results Per Page and Pagination
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PAGERESULTS}
    Element Should Be Visible    ${TOTALRESULTS}
    ${RESULTSTEMP}    Get Text    ${TOTALRESULTS}
    ${RESULTSFINAL}    Fetch From Left    ${RESULTSTEMP}    results
    Run Keyword If    ${RESULTSFINAL} > 48    Run Keywords    Check Pagination Buttons    Navigate to Next Page
    Sleep    5
    Run Keyword If    ${RESULTSFINAL} > 48    Run Keyword    Scroll page to location    0    1000
    Run Keyword If    ${RESULTSFINAL} > 48    Run Keywords    Check Pagination Buttons    Navigate to Previous Page

Navigate to Next Page
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${NEXTPAGE_PLP}
    Scroll Page to Location    0    1000
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${NEXTPAGE_PLP}
    Sleep    2s

Navigate to Previous Page
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PREVIOUSPAGE_PLP}
    Scroll Page to Location    0    1000
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PREVIOUSPAGE_PLP}
    Sleep    2s

Check Pagination Buttons
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${NEXTPAGE_PLP}
    ${CURRENTPAGE}=    Get Text    ${CURRENTPAGE_PLP}
    ${PREVPAGE}=    Get Text    ${PREVIOUSPAGE_PLP}
    ${NEXTPAGE}=    Get Text    ${NEXTPAGE_PLP}
    Run Keyword If    ${CURRENTPAGE}==1    Wait Until Keyword Succeeds    30s2s    Element Should Not Be Visible    ${PREVIOUSPAGE_PLP}
    ...    ELSE IF    ${CURRENTPAGE} > 1    Element Should Be Visible    ${PREVIOUSPAGE_PLP}
    Run Keyword If    ${CURRENTPAGE} < ${NEXTPAGE}    Element Should Be Visible    ${NEXTPAGE_PLP}

Verify sorting options
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SORTBY_PLP}
    ${BEFORESORT}    Get Text    ${FIRSTRESULT}
    ${OLDSORT}    Get Text    ${DEFAULTSORT}
    : FOR    ${SORTOPTION}    IN    @{SORTINGOPTIONS}
    \    Sort By    ${SORTOPTION}
    \    Sleep    3
    \    Wait Until Element Is Not Visible    ${LOADING}    30s    
    \    Wait Until Element Is Visible    ${FIRSTRESULT}    30s    
    \    ${AFTERSORT}    Get Text    ${FIRSTRESULT}
    \    Run Keyword If    '${OLDSORT}' != '${SORTOPTION}'    SHOULD NOT BE EQUAL    ${BEFORESORT}    ${AFTERSORT}
    \    Run Keyword If    '${OLDSORT}' == '${SORTOPTION}'    SHOULD BE EQUAL    ${BEFORESORT}    ${AFTERSORT}
    Sort By    ${MOST_POPULAR}

Sort By
    [Arguments]    ${SORTBY_ARG}
    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible    ${LOADING}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${SORTBY_PLP}
    Wait Until Keyword Succeeds    30s    2s    Select From List By Label    ${SORTBY_PLP}    ${SORTBY_ARG}
    sleep    2s
    Wait Until Element Is Not Visible    ${LOADING}    45s

Validate Searched term is displayed on PLP
    [Arguments]    ${SEARCHEDTERM_ARG}
    Wait Until Keyword Succeeds    30s    2s    Title Should Be    Search Results
    Wait Until Keyword Succeeds    30s    2s    Element Should Contain    ${TOTALRESULTS}    results
    Wait Until Keyword Succeeds    30s    2s    Element Should Contain    ${PLPSEARCHEDTEXTCONTAINER}    ${SEARCHEDTERM_ARG}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${FIRSTRESULT}

Verify the presence of facets on PLP
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${CATEGORYFACET}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PRICEFACET}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${BRANDFACET}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${HOWTOGETITFACET}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${RATINGFACET+}

Verify Category Facet
    [Arguments]    ${CATEGORY_LINKTEXT_ARG}
    ${CATEGORIESTOTAL}=    Get Element Count    ${ALLCATEGORIESPLP}
    Should Be True    ${CATEGORIESTOTAL} > 0
    Element Should Contain    ${CATEGORYFACET}    ${CATEGORY_LINKTEXT_ARG}

Verify the functionality of the Price Filter
    Wait Until Keyword Succeeds    30s    3s    Element Should Not Be Visible    ${LOADING}
    ${FACETCOLAPSED}=    Run Keyword And Return Status    Wait Until Keyword Succeeds    2s    3S    Element Should Not Be Visible    ${50TO100}
    Run Keyword If    ${FACETCOLAPSED}==True    Click Element    ${PRICEFACET+}
    Wait Until Keyword Succeeds    30s    2s    Set focus to element    ${50TO100}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${50TO100}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${PRICEFILTERAPPLIED}
    Sleep    3s
    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible    ${LOADING}
    ${FIRSTITEMPRICE}=    Get Text    ${FIRSTRESULTPRICE}
    ${FIRSTITEMPRICE}=    Fetch From Right    ${FIRSTITEMPRICE}    $
    ${FIRSTITEMPRICE}=    Convert To Number    ${FIRSTITEMPRICE}
    Should Be True    10 < ${FIRSTITEMPRICE} < 25
    Scroll Page to Location    0    0
    scroll page to location    0    0
    Wait Until Keyword Succeeds    30s    2s    Set focus to element    ${PRICEFILTERAPPLIED}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${PRICEFILTERAPPLIED}
    Wait Until Keyword Succeeds    30s    2s    Element Should Not Be Visible    ${PRICEFILTERAPPLIED}
    Sleep    2s
    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible    ${LOADING}

Verify the functionality of How To Get it Filter
    Wait Until Keyword Succeeds    30s    3s    Element Should Not Be Visible    ${LOADING}
    ${FACETCOLAPSED}=    Run Keyword And Return Status    Wait Until Keyword Succeeds    2s    3S    Element Should Not Be Visible    ${HOWTOGETIT_RD}
    Run Keyword If    ${FACETCOLAPSED}==True    Click Element    ${HOWTOGETIT+}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${HOWTOGETIT_OTD}
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${HOWTOGETIT_PUS}
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${HOWTOGETIT_RD}
    Scroll page to location    0    0
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${HOWTOGETIT_RD_APPLIED}
    Sleep    5s
    ${RDFACETNO}=    Get Text    ${HOWTOGETIT_RD_ITEMS}
    ${TOTALRESULTSNO}=    Get Text    ${TOTALRESULTS}
    ${TOTALRESULTSNO}=    Fetch From Left    ${TOTALRESULTSNO}    results
    Should Be Equal As Numbers    ${RDFACETNO}    ${TOTALRESULTSNO}
    Scroll Page to Location    0    0
    Wait Until Keyword Succeeds    30s    2s    Click Element    ${HOWTOGETIT_RD}
    Wait Until Keyword Succeeds    30s    2s    Element Should Not Be Visible    ${HOWTOGETIT_RD_APPLIED}
    Sleep    2s
    Wait Until Keyword Succeeds    45s    2s    Element Should Not Be Visible    ${LOADING}