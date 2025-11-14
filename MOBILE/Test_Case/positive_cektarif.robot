*** Settings ***
Library         AppiumLibrary    timeout=20s    
Library         OperatingSystem
Library         String
Resource       ${CURDIR}/../Step/lionParcel.robot

*** Test Cases ***
As a user, i want to cek tarif on without checklist assurance
    [documentation]  cek tarif
    [Tags]  Regression dev
    Given open application lion parcel on real device
    When click menu cek tarif
        And click origin location pick up
        And click destination location drop
        And click button cek tarif
        And input item weight
        And input item dimensions
        And input type of item
        And input assurance
        And select shipping type
    Then verify is tarif should be appears
        And verify button element is clickcable
        And click button pick up
        And click button lanjutkan
        And sender data input
        And recipient address input
        And chose item package 
        And input price on item
        And click button payment 
        And click gopay payment method
        And verify home payment is appears
    [Teardown]  Close Application

As a user, i want to cek tarif on with checklist assurance
    [documentation]  cek tarif
    [Tags]  Regression dev
    Given open application lion parcel on real device
    When click menu cek tarif
        And click origin location pick up
        And click destination location drop
        And click button cek tarif
        And input item weight
        And input item dimensions
        And input type of item
        And input assurance
        And select shipping type
        And click add assurance
    Then verify is biaya asuransi should be appears
        And verify is tarif should be appears
        And verify button element is clickcable
        And click button pick up
        And click button lanjutkan
        And sender data input
        And recipient address input
        And chose item package 
        And input price on item
        And click button payment 
        And click gopay payment method
        And verify home payment is appears
    [Teardown]  Close Application

As a user, i want to cek tarif witouht optional field is not filled
    [documentation]  cek tarif
    [Tags]  Regression dev
    Given open application lion parcel on real device
    When click menu cek tarif
        And click origin location pick up
        And click destination location drop
        And click button cek tarif
        And input item weight
        And scroll down into button request pick up
        And select shipping type
    Then verify is tarif should be appears
        And verify button element is clickcable
        And click button pick up
        And click button lanjutkan
        And sender data input
        And recipient address input
        And chose item package 
        And input price on item
        And click button payment 
        And click gopay payment method
        And verify home payment is appears
    [Teardown]  Close Application