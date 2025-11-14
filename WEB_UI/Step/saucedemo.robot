*** Settings ***
Library      ${CURDIR}/../resource/Helper/keywords.py
Library      Browser
Library      RPA.Excel.Files
Library      OTP
Library      ScreenCapLibrary
Library      Collections
Variables    ${CURDIR}/../resource/Locator/saucedemo.py


*** Keywords ***
#################  Saude Demo  #################
open web sauce demo
    ${workbook}=    Open Workbook    ${CURDIR}/../Resource/data_files/login_data.xlsx
    @{data}=    Read Worksheet    browser    header=${TRUE}
    Close Workbook
    ${second_row}=    Get From List    ${data}    0
    Log    ${second_row}
        ${url}=           Set Variable    ${second_row}[url]
        ${browser}=       Set Variable    ${second_row}[browser] 
        New Browser       ${browser}    headless=False
        New Context    viewport={'width': 1500, 'height': 800}
        New Page       ${url}
        sleep    1s

login Web saucedemo
    ${workbook}=    Open Workbook     ${CURDIR}/../Resource/data_files/login_data.xlsx
    @{data}=    Read Worksheet    user    header=${TRUE}
    Close Workbook
    ${data_login}=    Get From List    ${data}    0
        ${user_sauce}=               Set Variable    ${data_login}[user] 
        ${password_sauce}=           Set Variable    ${data_login}[password] 
        #Open browser
        FOR   ${logindatasauce}  IN RANGE  10
            ${statuslogindata}    Run Keyword And Return Status  Wait For Elements State     ${verify_login}     visible     timeout=1s
            sleep                   1s
            IF  '${statuslogindata}' == 'True'
                Log  Login has been successful
                EXIT FOR LOOP
            ELSE
                keywords.reload page
                ${result}=   fill text                       ${emailuser}     ${user_sauce}
                ${result}=   fill text                       ${passworduser}  ${password_sauce}
                ${result}=   click              ${button_login}
                CONTINUE
            END
        END
    verify if user has been succesfully login web sauce demo


verify if user has been succesfully login web sauce demo
    Wait For Elements State     ${verify_login}     visible     timeout=60s

add back pack item into cart
    [Arguments]         ${backpack}
    IF  '${backpack}' == 'yes'
        click     ${backpackitem}
    ELSE   
        Log   not choose item back pack
    END

add back pack item
    click     ${backpackitem}

add bike light item into cart
    [Arguments]         ${backpack}
    IF  '${backpack}' == 'yes'
        click     ${bikelight}
    ELSE   
        Log   not choose light item
    END

add bike light item
    click     ${bikelight}

delete back light item from cart
    click     ${deletebikelight}

add tshirt item into cart
    [Arguments]         ${tshirt}
    IF  '${tshirt}' == 'yes'
        click     ${tshrirtitem}
    ELSE   
        Log   not choose light item
    END
    

click button cart
    click     ${cartlink}
    sleep  1s

click button checkout
    click     ${buttoncheckout}
    sleep  1s

input data user on sauce demo web
    [Arguments]     ${firstname_user}       ${lastname_user}    ${postal_code}
    fill text     ${firstname}            ${firstname_user}
    fill text     ${lastname}             ${lastname_user}
    fill text     ${postalcodezip}        ${postal_code}
    sleep  1s

input data user on sauce demo web default data
    fill text     ${firstname}            anwar
    fill text     ${lastname}             syaikal
    fill text     ${postalcodezip}        112233
    sleep  1s

click button continue  
    click     ${buttoncontinue}

click button continue not input data user
    click     ${buttoncontinue}

click button finish  
    click     ${buttonfinish}

verify order has been complete
    Wait For Elements State     ${verifycompletebuy}     visible     timeout=60s

click button back home  
    click     ${buttonbackhome} 
    sleep  1s

close browser
    close_browser_pl

## TDD ##
buy some item on saude demo web
    ${workbook}=    Open Workbook    ${CURDIR}/../Resource/data_files/login_data.xlsx
    @{data}=    Read worksheet    cartuser   header=${TRUE}
        FOR    ${row}    IN    @{data}
            ##Get data on resource data .xlsx
            ${firstname_user}=          Set Variable        ${row}[first_name] 
            ${lastname_user}=           Set Variable        ${row}[last_name]
            ${postal_code}=             Set Variable        ${row}[postal_code]  
            ${backpack}=                Set Variable        ${row}[backpack] 
            ${bike_light}=              Set Variable        ${row}[bike_light] 
            ${tshirt}=                  Set Variable        ${row}[tshirt]  

            #add some item into cart
            add back pack item into cart    ${backpack}
            add bike light item into cart  ${bike_light}
            add tshirt item into cart      ${tshirt}

            #click button cart into finish
            click button cart
            click button checkout
            input data user on sauce demo web   ${firstname_user}    ${lastname_user}    ${postal_code}
            click button continue  
            click button finish  
            Then verify order has been complete
            click button back home 
        END
    Close Workbook

all item finish buy on saucedemo web
    Wait For Elements State     ${homepageproducts}     visible     timeout=60s
    sleep   2s

there are message error not input data user
    Wait For Elements State         ${errornotinputdata}     visible     timeout=60s
    ${actual_text}=    Get Text     ${errornotinputdata}
    Should Be Equal                 ${actual_text}           Error: First Name is required
