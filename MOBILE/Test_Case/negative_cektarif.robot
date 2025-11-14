*** Settings ***
Library         AppiumLibrary    timeout=20s    
Library         OperatingSystem
Library         String
Resource       ${CURDIR}/../Step/lionParcel.robot

*** Test Cases ***
As a user, i want to cek tarif with dont input destination
    [documentation]  cek tarif
    [Tags]  Regression dev
    Given open application lion parcel on real device
        And click menu cek tarif
        And click origin location pick up
    When destination is not filled
    Then verify button cek tarif is disable
    [Teardown]  Close Application

As a user, i want to cek tarif with input total weight item is 0
    [documentation]  cek tarif
    [Tags]  Regression dev
    Given open application lion parcel on real device
        And click menu cek tarif
        And click origin location pick up
        And click destination location drop
        And click button cek tarif
    When input item weight is 0
    Then verify message eror on field total weight is appears
    [Teardown]  Close Application

As a user, i want to cek tarif witouht input sender details
    [documentation]  cek tarif
    [Tags]  Regression dev
    Given open application lion parcel on real device
        And click menu cek tarif
        And click origin location pick up
        And click destination location drop
        And click button cek tarif
        And input item weight
        And scroll down into button request pick up
        And select shipping type
        And verify button element is clickcable
        And click button pick up
        And click button lanjutkan
    When sender data is not filled
    Then verify button next to page input addres is disable
    [Teardown]  Close Application

As a user, i want to cek tarif witouht input full address
    [documentation]  cek tarif
    [Tags]  Regression dev
    Given open application lion parcel on real device
        And click menu cek tarif
        And click origin location pick up
        And click destination location drop
        And click button cek tarif
        And input item weight
        And scroll down into button request pick up
        And select shipping type
        And verify is tarif should be appears
        And verify button element is clickcable
        And click button pick up
        And click button lanjutkan
        And sender data input
    When full addres is not filled
    Then verify button next to page input item package is disable
    [Teardown]  Close Application