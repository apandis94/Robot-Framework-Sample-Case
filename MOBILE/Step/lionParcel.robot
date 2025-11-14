*** Settings ***
Library         AppiumLibrary    timeout=20s    
Library         OperatingSystem
Library    String
Variables       ${CURDIR}/../Resource/Locator/lionparcel.py

*** Variables ***
${platform-name-RealDriver}         Android
${app-package-RealDriver}           com.lionparcel.services.consumer
${app-activity-RealDriver}          com.lionparcel.services.consumer.view.splash.BrandingActivity
${platform-version-RealDriver}      12
${device-name-RealDriver}           LG V50
&{KEYCODES}    0=7    1=8    2=9    3=10    4=11    5=12    6=13    7=14    8=15    9=16

*** Keywords ***
open application lion parcel on real device
    Open Application    http://127.0.0.1:4723/wd/hub     platformName=${platform-name-RealDriver}
    ...    appPackage=${app-package-RealDriver} 
    ...    appActivity=${app-activity-RealDriver} 
    ...    platformVersion=${platform-version-RealDriver}
    ...    deviceName=${device-name-RealDriver}
    ...    fullReset=false
    ...    noReset=true
    Wait Until Element Is Visible    ${menu_cektarif}     120s
    sleep      1s

skip step login
    Click Element       ${buttonsetuju}
    sleep      2s
    Click Element       ${buttonskip}
    sleep      2s
    Click Element       ${allowlocation}
    Wait Until Element Is Visible    ${buttonx}     120s
    sleep      2s
    Click Element       ${buttonx}

click menu cek tarif
    Click Element       ${menu_cektarif}
    Wait Until Element Is Visible    ${home_cektarif}     60s

click origin location pick up
    Click Element    ${origin_loc}
    Wait Until Element Is Visible    ${input_origin}     60s
    Input Text       ${input_origin}      Kelapa Dua
    Wait Until Element Is Visible    ${origin_routename}     60s
    Click Element       ${origin_routename}
    sleep   2s

destination is not filled
    Log    destination is not filled / skip

click destination location drop
    Click Element       ${destination_loc}
    Wait Until Element Is Visible    ${input_destination}     60s
    Input Text       ${input_destination}      Sariwangi
    Wait Until Element Is Visible    ${destination_name}     60s
    Click Element       ${destination_name}
    sleep   2s

click button cek tarif
    Click Element       ${buttoncek_tarif}
    sleep   2s

input item weight
    Input Text       ${input_beratbarang}      5

input item weight is 0
    Input Text       ${input_beratbarang}      0
    
input item dimensions
    Input Text       ${panjang}      20
    sleep   1s
    Input Text       ${lebar}        10
    sleep   1s
    Input Text       ${tinggi}       5
    sleep   2s

input type of item
    Click Element       ${jenisbarang}
    Wait Until Element Is Visible    ${inputjenisbarang}     60s
    Input Text       ${inputjenisbarang}      Elektronik
    Wait Until Element Is Visible    ${pilihjenisbarang}     60s
    Click Element       ${pilihjenisbarang}
    sleep   2s

input assurance
    FOR    ${scroll}    IN RANGE    5
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${inputnilaibarang}
        Exit For Loop If    ${is_visible}
        
        # Scroll down
        Swipe By Percent    50    70    50    30
        Sleep    1s
    END
    Element Should Be Visible    ${inputnilaibarang}
    Log    Element ${inputnilaibarang} found after ${scroll} scrolls
    Input Text       ${inputnilaibarang}      5000000
    scroll down into button request pick up

select shipping type
    Click Element       ${jenispengiriman}

click add assurance
    Click Element       ${checkboxassurance}
    sleep   4s

verify is biaya asuransi should be appears
    ${totalbiayaassurance}=  Get Text      ${nilaiasuransi}
    ${clean_biaya}=    Remove String    ${totalbiayaassurance}    Rp    .
    ${clean_biaya}=    Strip String    ${clean_biaya}
    ${biaya_asr}=    Convert To Number    ${clean_biaya}
    Log    Clean number: ${biaya_asr}
    IF  ${biaya_asr} > 0
        Log   total biaya tarif sudah muncul: ${biaya_asr}
    ELSE
        Log   total biaya tarif belum muncul
    END 

scroll down into button request pick up
     FOR    ${scroll}    IN RANGE    5
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${requestpickup}
        Exit For Loop If    ${is_visible}
        
        # Scroll down
        Swipe By Percent    50    70    50    30
        Sleep    1s
    END
    sleep   2s
    Element Should Be Visible    ${requestpickup}
    Log    Element ${requestpickup} found after ${scroll} scrolls

verify is tarif should be appears
    scroll down into button request pick up
    #cek biaya tarif
    ${totalbiayaall}=  Get Text      ${totalbiaya}
    ${clean_biaya}=    Remove String    ${totalbiayaall}    Rp    .
    ${clean_biaya}=    Strip String    ${clean_biaya}
    ${biaya_total}=    Convert To Number    ${clean_biaya}
    Log    Clean number: ${biaya_total}
    IF  ${biaya_total} > 0
        Log   total biaya tarif sudah muncul: ${totalbiayaall}
    ELSE
        Log   total biaya tarif belum muncul
    END 

verify button element is clickcable
    Element Should Be Enabled    ${requestpickup}
    sleep   2s

click button pick up
    Click Element       ${requestpickup}
    sleep   2s

click button lanjutkan
    ${keyboard_visible}=    Run Keyword And Return Status   Wait Until Element Is Visible       ${buttonx}     10s
    ${keyboard_visible}=    Run Keyword And Return Status   Click Element       ${buttonx}
    sleep   3s
    Click Element       ${buttonlanjutkan}
    Wait Until Element Is Visible    ${namapengirim}     60s

sender data is not filled
    Log    sender data is not filled / skip

sender data input
    Input Text       ${namapengirim}      Rangga Suherman
    sleep   1s
    Click Element       ${nopengirim}
    sleep   1s
    Input Text       ${nopengirim}      81390096721
    Hide Keyboard    key_name=Done
    Hide Keyboard    strategy=tapOutside
    sleep   2s
    Click Element       ${buttonconfirm}
    sleep   1s
    Wait Until Element Is Visible    ${alamat}     60s

full addres is not filled
    Log    full addres is not filled / skip

recipient address input
    Input Text       ${alamat}      Kp. Baranangsiang
    Click Element    ${kecamatan}
    sleep   1s
    @{text}=    Create List    s    u    k    a    j    a    y    a
    Type Text With Keyboard    ${text}
    Click Element       ${tapatlocation}
    sleep   1s
    Input Text       ${patokan}     sebrang sungai
    Input Text       ${namapengguna}     Aji Sabra
    Click Element       ${notelppengguna}
    sleep   1s
    Input Text       ${notelppengguna}     81390096721
    Hide Keyboard    key_name=Done
    Hide Keyboard    strategy=tapOutside
    sleep   2s
    Click Element       ${buttonlanjutkan3}
    Wait Until Element Is Visible    ${jenisbarangpilih}     60s

chose item package 
    Click Element       ${jenisbarangpilih}
    Wait Until Element Is Visible    ${inputjenisbarang2}     60s
    Input Text       ${inputjenisbarang2}      Elektronik
    Wait Until Element Is Visible    ${jenisbarangchoose}     60s
    Click Element       ${jenisbarangchoose}
    sleep   2s

input price on item
    Click Element     ${inputnilaibarang2}
    Input number with keycode        ${inputnilaibarang2}      500000
    Press Keycode    66
    sleep   3s
    Element Should Be Enabled    ${buttonlanjutkan2}
    click element     ${buttonlanjutkan2}
    Wait Until Element Is Visible    ${buttonpembayaran}     60s

click button payment 
    Click Element       ${buttonpembayaran}
    Wait Until Element Is Visible    ${halamanbayar}     60s

click gopay payment method
    Click Element       ${gopay}
    sleep   1s
    Click Element       ${buttonfinalbayar}

verify home payment is appears
    Wait Until Element Is Visible    ${aplikasinotinstal}     60s

verify message eror on field total weight is appears
    Wait Until Element Is Visible    ${erortotalweight}     60s
    ${erormessage}=  Get Text      ${erortotalweight}

verify button cek tarif is disable
    ${status_cektarif}=    Run Keyword And Return Status  Element Should Be Disabled    ${buttoncek_tarif}     60s
    IF  '${status_cektarif}' == 'True'
        Log   button cek tarif cannot be clickable
    ELSE
        Log   button cek tarif can be clickable
    END 

verify button next to page input addres is disable
    ${status_confirm}=    Run Keyword And Return Status  Element Should Be Disabled    ${buttonconfirm}     60s
    IF  '${status_confirm}' == 'True'
        Log   button cek tarif cannot be clickable
    ELSE
        Log   button cek tarif can be clickable
    END 

verify button next to page input item package is disable
    ${status_button}=    Run Keyword And Return Status  Element Should Be Disabled    ${buttonlanjutkan3}     60s
    IF  '${status_button}' == 'True'
        Log   button cek tarif cannot be clickable
    ELSE
        Log   button cek tarif can be clickable
    END 


Type Text With Keyboard
    [Arguments]    ${text_list}
    FOR    ${char}    IN    @{text_list}
        ${keycode}=    Get Keycode From Character    ${char}
        Press Keycode    ${keycode}
        Sleep    0.1s
    END

Get Keycode From Character
    [Arguments]    ${character}
    ${character}=    Convert To Lower Case    ${character}
    ${keycodes}=    Create Dictionary
    ...    a=29    b=30    c=31    d=32    e=33    f=34    g=35    h=36
    ...    i=37    j=38    k=39    l=40    m=41    n=42    o=43    p=44
    ...    q=45    r=46    s=47    t=48    u=49    v=50    w=51    x=52
    ...    y=53    z=54    0=7    1=8    2=9    3=10    4=11    5=12
    ...    6=13    7=14    8=15    9=16    .=56    ,=55    =62
    RETURN    ${keycodes['${character}']}

Input number with keycode
    [Arguments]    ${locator}    ${number}
    Click Element    ${locator}
    Sleep    1s
    
    # Convert number to string lalu split menjadi list characters
    ${number_str}=    Convert To String    ${number}
    @{digits}=    Split String To Characters    ${number_str}
    
    FOR    ${digit}    IN    @{digits}
        Press Keycode    ${KEYCODES['${digit}']}
        Sleep    0.2s
    END


