*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         OperatingSystem
Library         JSONLibrary
Resource       ${CURDIR}/../Step/testApi.robot

*** Test Cases ***
As a user, i want to create user on api reqres.in
    [Documentation]  Create User
    Given create sesion on body request user regist
    When post user register on api reqres.in
    Then get response 200 and succes create user

As a user, i want to get single user on api reqres.in
    [Documentation]  Get Single User
    Given create sesion on body request get user
    When get single user on api reqres.in
    Then get response 200 and succes get single user