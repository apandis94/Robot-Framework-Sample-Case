*** Settings ***
Library      ${CURDIR}/../resource/Helper/keywords.py
Library      RPA.Excel.Files
Library      OTP
Library      Browser
Library      ScreenCapLibrary
Library      Collections
Resource     ${CURDIR}/../Step/saucedemo.robot

*** Test Cases ***
As a user, i want to buy some item but can'y input data user on website saucedemo
    [documentation]  buy item
    [Tags]  Regression dev
    Given open web sauce demo
        And login Web saucedemo
        And add back pack item
        And add bike light item
        And click button cart
        And click button checkout
    When click button continue not input data user
    Then there are message error not input data user
    [Teardown]  close browser