*** Settings ***
Documentation     Common keywords
Library           SeleniumLibrary    timeout=60
Library           BuiltIn
Library           Collections
Library           String
Resource          Homepage.robot
Library           DateTime
Resource          ../resources/testdata.robot

*** Variables ***
${URL}