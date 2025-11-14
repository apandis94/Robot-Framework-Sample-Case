*** Settings ***
Library      ${CURDIR}/../resource/Helper/keywords.py
Library      RPA.Excel.Files
Library      OTP
Library      Browser
Library      ScreenCapLibrary
Library      Collections
Resource     ${CURDIR}/../Step/saucedemo.robot

*** Test Cases ***
As a user, i want to buy some item on website saucedemo
    [documentation]  buy item
    [Tags]  Regression dev
    Given open web sauce demo
        And login Web saucedemo
    When buy some item on saude demo web 
    Then all item finish buy on saucedemo web
    [Teardown]  close browser

As a user, i want to buy one item on website saucedemo
    [documentation]  buy item
    [Tags]  Regression dev
    Given open web sauce demo
        And login Web saucedemo
    When add back pack item
        And click button cart
        And click button checkout
        And input data user on sauce demo web default data
        And click button continue  
        And click button finish  
    Then verify order has been complete
        And click button back home 
    [Teardown]  close browser

As a user, i want to buy some item but on cart delete one item on website saucedemo
    [documentation]  buy item
    [Tags]  Regression dev
    Given open web sauce demo
        And login Web saucedemo
        And add back pack item
        And add bike light item
        And click button cart
    When delete back light item from cart
        And click button checkout
        And input data user on sauce demo web default data
        And click button continue  
        And click button finish  
    Then verify order has been complete
        And click button back home 
    [Teardown]  close browser