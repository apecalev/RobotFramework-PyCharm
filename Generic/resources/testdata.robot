*** Settings ***
Documentation     Test Data
Library           SeleniumLibrary    timeout=60
Library           BuiltIn
Library           Collections
Library           String

*** Variables ***
#SKU
${SKUINSTOCK}     1055542    #1055615    #2323401    #2323428 | #1055542 | #2323428 | #2189927
${BOPUSINSTOCK}    1530771    #1356038    #2983119 | #1356038 | # 2668821
#Gift Card Values
${GiftPin}        123
${GIFTCARD1}      
${GIFTCARD2}      
#Promo Values
${100PERCENTOFF}    
${FREESHIP}       
${INVALID_PROMOCODE}    
${VALID_PROMOCODE}    
#Credit Cards
${ValidCreditCard}    
${VISA}           
${VISA2}          
${MasterCard}     
${MasterCard2}    
${AMEXCARD}       
${CardYear}       2024
${ExpCardYear}    2018
${Month_DATA}     May
${Year_DATA}      2024
${fname}          TestFirst
${lname}          TestLast
${cphone}         8586179326
#Addresses
@{DELAWARE}       422 Delaware Ave    Wilmington    DE    19801
@{MONTANA}        6510 Us Highway 93 S    Whitefish    MT    59937
@{NEW_HAMPSHIRE}    588 Wentworth Rd    New Castle    NH    03854
@{STATE_OREGON}    1900 Clackamette Dr    Oregon City    OR    97045
@{POBOXPA}        PO Box 1    Aaronsburg    PA    16820
@{ARIZONA}        585 E. WETMORE ROAD    Tucson    AZ    85705
@{PENSYLVANIA}    3300 ARAMINGO AVE    Philadelphia    PA    19134
@{TEXAS}          4325 LOVERS LANE    Dallas    TX    75225
@{DC}             5245 Loughboro Rd NW    Washington    DC    20016
@{VIRGINISLANDS}    5400 Veterans Dr    St. Thomas    U.S. Virgin Islands    00802
@{ZeroTaxState}    555 Sawdust Rd 23    Woodlands    TX    77380
@{Guam}           185 Gun Beach R    Barrigada    GU    96913
@{PuertoRico}     Av. Nativo Alers    Aguada    PR    00602
@{Alabama}        653 Ryan Lane    Montgomery    AL    36109
@{Arkansas}       4527 Green Hill Road    Fort Smith    AR    72901
@{Colorado}       493 Clearview Drive    Denver    CO    80205
@{Connecticut}    574 S. Thorne Ave.    Hartford    CT    06106
@{Florida}        9465 San Juan St.    Panama City    FL    32404
@{Georgia}        135 Glenwood St.    Jonesboro    GA    30236
@{Idaho}          3552 Young Road    Rupert    ID    83350
@{Illinois}       11 Buckingham St.    Carpentersville    IL    60110
@{Indiana}        677 Swanson Street    Granger    IN    46530
@{Iowa}           884 Arnold St.    Urbandale    IA    50322
@{Kansas}         119 Newport Drive    Emporia    KS    66801
@{Kentucky}       4830 North Bend River Road    Lexington    KY    40505
@{Louisiana}      82 Trout St.    New Orleans    LA    70115
@{Maine}          723 Fantages Way    South Portland    ME    04106
@{Maryland}       8693 Smith Store Ave.    Owings Mills    MD    21117
@{Massachusetts}    8406 SE. Lakewood Street    New Bedford    MA    02740
@{Michigan}       7246 Rocky River Drive    Holland    MI    49423
@{Minnesota}      738 Green Lane    Burnsville    MN    55337
@{Mississippi}    9404 Franklin Drive    Vicksburg    MS    39180
@{Missouri}       8531 Orchard Court    Saint Louis    MO    63109
@{Nebraska}       48 E. 10th Street    Omaha    NE    68107
@{Nevada}         65 Hickory Ridge Drive    Las Vegas    NV    89104
@{New_Jersey}     8964 Fulton St.    Nutley    NJ    07110
@{New_Mexico}     517 Cooks Mine Road    Taos    NM    87571
@{New_York}       78 Lookout St.    Albany    NY    12203
@{North_Carolina}    85 Studebaker Ave.    Wilson    NC    27893
@{North_Dakota}    598 Courtright Street    Lankin    ND    58250
@{Ohio}           78C Pumpkin Hill St.    Willoughby    OH    44094
@{Oklahoma}       39 W. Indian Spring Ave.    Norman    OK    73072
@{Oregon}         1900 Clackamette Dr    Oregon City    OR    97045
@{Rhode_Island}    52 Jackson Ave.    Warwick    RI    02886
@{South_Carolina}    9276 Goldfield Ave.    Aiken    SC    29803
@{South_Dakota}    9085 West Golden Star St.    Sioux Falls    SD    57103
@{Tennessee}      942 Ketch Harbour Circle    Clarksville    TN    37040
@{Utah}           8386 Lakeshore Dr.    Salt Lake City    UT    84119
@{Vermont}        4850 Hardman Road    South Burlington    VT    05403
@{Virginia}       4 SE. Greenview Drive    Roanoke    VA    24012
@{Washington}     5245 Loughboro Rd NW    Washington    WA    20016
@{West_Virginia}    151 Homestead Street    Parkersburg    WV    26101
@{Wisconsin}      990 Garfield Lane    Kaukauna    WI    54130
@{Wyoming}        1370 Thorn Street    Green River    WY    82935
#Accounts
${PAYPALEMAIL_VALID}    
${PAYPALPASSWORD_VALID}    
${GuestEmail}     
${PASS}           
${INCORECT_PASS}