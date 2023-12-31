*** Settings ***
Documentation     MyAccount locators
Library           SeleniumLibrary    timeout=60
Library           BuiltIn
Library           Collections
Library           String

*** Variables ***
${ALLRIGHTLIST_HEADER}
${ALLLEFTLIST_HEADER}
${EDITPHONENUMBER}
${EDITCITY}
${EDITADDRESSLINE}
${SAVEACCOUNTINFO}
${VERIFYADDRESSDIALOG}
${ENTEREDADDRESS}
${EDITNAME}
${EDITLASTNAME}
${MYACCOUNT_LEFTNAV}
${MYLISTS_LEFTNAV}
${ORDERS_LEFTNAV}
${PAYMENT_LEFTNAV}
${ADDRESSBOOK_LEFTNAV}
${EMAILPREFERENCES_LEFTNAV}
${EDITONLINEPROFILE}
${MYWISHLIST}
${MYPURCHASELIST}
${PRINTMYWISHLIST}
${ADDNEWCREDITCARD}
${ADDNEWADDRESS}
${EDITADDRESS}
${MYSUBSCRIPTIONS1}
${MYSUBSCRIPTIONS2}
${MYSUBSCRIPTIONS3}
${MYSUBSCRIPTIONS4}
${SUBSCRIBEALL}
${UNSUBSCRIBEALL}
${SAVESUBSCRIPTIONS}
${EDITPROFILE_FIRSTNAME}
${EDITPROFILE_LASTNAME}
${EDITPROFILE_EMAIL}
${EDITPROFILE_CHANGEMYPASS}
${EDITPROFILE_SAVE}
${EDITPROFILE_CANCEL}
${MY_WL_TEXT}
${ADDRESSBOOK}
${SELECTSTATE}
${EDITZIPCODE}
${MY_WL_TEXT}
${ALL_ADDTOCART_WL}
${REMOVEBUTTON}
${CART_NUMBERITEMS}
${CART_ITEMS}
${SUGGESTEDADDRESS}
${WL_ITEMS}
${INPUT_FIRSTNAME_NEWADDRESS}
${INPUT_LASTNAME_NEWADDRESS}
${INPUT_ADDRESSLINE_NEWADDRESS}
${INPUT_CITY_NEWADDRESS}
${STATE_NEWADDRESS}
${INPUT_ZIPCODE_NEWADDRESS}
${INPUT_PHONE_NEWADDRESS}
${SETASDEFAULTADDRESS_NEWADDRESS}
${DEFAULT_ADDRESS}
${REMOVE_ADDRESS_MYACCOUNT_BTN}
${SETDEFAULT_ADDRESSBOOK}
${DEFAULTADDRESSS_LABEL}
${ADDRESS_ADDRESSBOOK_MYACCOUNT}
${REMOVE_DEFAULTADDRESS_MODAL}
${REMOVEADDRESSANDSETNEWDEFAULT}
${EDIT_WISHLIST_NAME_MYLISTS}
${WISHLIST_NAME_EDIT}
${SAVEWISHLISTNAME_BTN}
${WISHLIST_NAME_MYLISTS}
${SHAREWITH_BTN_MYLISTS}
${FACEBOOK_SHAREWITH_MYLISTS}
${TWEETER_SHAREWITH_MYLISTS}
${MAIL_SHAREWITH_MYLISTS}
${EMAIL_WISHLIST_MODAL}
${SEND_EMAIL_WL}
${RECEIPIENT_EMAIL_WL}
${PRIVATE_WISHLIST}
${SAVEASDEFAULTADDRESS}
${MYORDERSTEXT}
${ALLVIEWDETAILS_INORDERHISTORY}
${NAVIGATIONDIV_ORDERH}
${VIEWDETAILS_ORDERH}
${ORDERDATE_ORDERH}
${ORDERNUBER_ORDERH}
${ORDERTOTAL_ORDERH}
${CREDITCARD_ORDERH}
${RETURNRECEIPT_ORDERH}
${PRINT_ORDERH}
${ORDERDATERETURN_ORDERH}
${ORDERNUBRETURN_ORDERH}
${ORDERTOTALRETURN_ORDERH}
${ADDRESSRETURN_ORDERH}
${CREDITCARDRETURN_ORDERH}
${ADDRESS_ORDERH}
${REGISTER_ACCOUNT}
${FIRSTNAME_REGISTER}
${LASTNAME_REGISTER}
${EMAIL_REGISTER}
${PASSWORD_REGISTER}
${CONFIRMPASSWORD_REGISTER}
${ADDRESS_REGISTER}
${CITY_REGISTER}
${STATE_REGISTER}
${ZIP_REGISTER}
${PHONE_REGISTER}
${CREATEACCOUNT_REGISTER}
${INCORECTPASSWORD_REGISTER}
${PAYMENTWALLETTEXTVISIBLE}
${ALLCARD'SIN_PWALLET}
${SELECTCHECKBOX_DEFAULTCARD}
${THIRDADDRESS}
${SECONDADDRESS}
${MYLISTS_WISHLIST}
${WISHLISH_TOTALITEMS}
${INPUTADDRESS}
${SIGNIN_HEADER}
${ONLINEPROFILE}
${FIRSTNAMEUPDATE}
${LASTNAMEUPDATE}
${EMAILUPDATE}
${SAVEUPDATECHANGES}
${MYSUBSCRIPTIONSDIV}
${TRACKORDER_MYACCOUNT}
${MYACCOUNT_INFO}
${ERROR_PHONE_MESSAGE_EDIT_ACCOUNT}
${ERROR_PHONE_MESSAGE_SHIPPING_SPC}
${ERROR_PHONE_NUMBER_MESSAGE}