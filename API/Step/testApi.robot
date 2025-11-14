*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         OperatingSystem
Library         JSONLibrary
Variables       ${CURDIR}/../Resource/Variable/dataUser.py


*** Variables ***
${base_url}                 https://reqres.in/api
${base_url_invalid}         https://reqres.in
${CONTENT_TYPE}             application/json 
${api_key}                  reqres-free-v1

*** Keywords ***
create sesion on body request user regist
    Create Session   mysession    ${base_url}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    Log  ${body}
    Set suite variable    ${body}

post user register on api reqres.in
    ${header}=    Create Dictionary    Content-Type=${CONTENT_TYPE}    x-api-key=${api_key} 
    ${response}=    POST    ${base_url}/register    json=${body}   headers=${header} 
    Set suite variable   ${response}
    ${bodyresponse} =   Convert To String  ${response.content}
    Log  Response status is: ${response.status_code}
    Log  Response content is: ${response.content}
    ${getvalue}=    Convert String To Json    ${bodyresponse}
    ${id}=    Get Value From Json    ${getvalue}    $.id
    Set suite variable    ${id}   ${id[0]}
    log   userid is: ${id}
    ${token}=    Get Value From Json    ${getvalue}    $.token
    Set suite variable    ${token}   ${token[0]}
    log   user token is: ${token}

post user register on api reqres.in with invalid url
    ${header}=    Create Dictionary    Content-Type=${CONTENT_TYPE}    x-api-key=${api_key} 
    ${response}=    POST    ${base_url_invalid}/register    json=${body}   headers=${header}      expected_status=ANY
    Set suite variable   ${response}
    ${bodyresponse} =   Convert To String  ${response.content}
    Log  Response status is: ${response.status_code}

post user register on api reqres.in with invalid token / auth
    ${header}=    Create Dictionary    Content-Type=${CONTENT_TYPE}    x-api-key=invalid_token 
    ${response}=    POST    ${base_url}/register    json=${body}   headers=${header}     expected_status=ANY
    Set suite variable   ${response}
    ${bodyresponse} =   Convert To String  ${response.content}     

get response 404 with status url not found
    Status Should Be    404    ${response}

get response 403 with status missing / invalid token
    Status Should Be    403    ${response}
    Should Contain    ${response.json()}    error
    
get response 200 and succes create user
    Status Should Be    200    ${response}
    Should Contain    ${response.json()}    token

create sesion on body request get user
    Create Session   mysession    ${base_url}

get single user on api reqres.in
    ${response}=    GET    ${base_url}/users/${id}   
    Set suite variable   ${response}
    ${bodyresponse} =   Convert To String  ${response.content}
    Log  Response status is: ${response.status_code}
    Log  Response content is: ${response.content}

get response 200 and succes get single user
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()['data']}    email
    Should Be Equal    ${response.json()['data']['id']}    ${id}
