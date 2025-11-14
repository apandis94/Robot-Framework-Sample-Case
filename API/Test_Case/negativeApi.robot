*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         OperatingSystem
Library         JSONLibrary
Resource       ${CURDIR}/../Step/testApi.robot

*** Test Cases ***
As a user, i want to create user on api reqres.in with invalid url
    [Documentation]  Create User
    Given create sesion on body request user regist
    When post user register on api reqres.in with invalid url
    get response 404 with status url not found

As a user, i want to create user on api reqres.in with invalid token
    [Documentation]  Create User
    Given create sesion on body request user regist
    When post user register on api reqres.in with invalid token / auth
    get response 403 with status missing / invalid token