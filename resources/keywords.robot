*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library   XML
Library    String

Resource    ../resources/VGeneral.robot
Resource    ../resources/common.robot

*** Variables ***


*** Keywords ***

Abrir Navegador
    Open Browser    ${url}    chrome
    Maximize Browser Window

Registrar usuario nuevo
    Wait Until Page Contains Element    //a[text()='CATEGORIES']    30s
    Click Element    //a[text()='Sign up']

    Wait Until Element Is Enabled    (//label[text()='Username:'])[1]    30s
    Sleep    2s
    Input Text    //input[@id='sign-username']    ${user}
    Input Text    //input[@id='sign-password']    ${pass}
    CapturaImagenSinComentarios
    Click Element    //button[text()='Sign up']

    Sleep    5s
    Close Browser

Inicio de sesion
    Wait Until Page Contains Element    //a[text()='CATEGORIES']    30s
    Click Element    //a[text()='Log in']

    Wait Until Page Contains Element    (//label[text()='Username:'])[2]    30s
    Sleep    2s
    Input Text    //input[@id='loginusername']    ${user}
    Input Text    //input[@id='loginpassword']    ${pass}
    CapturaImagenSinComentarios
    Click Element    //button[text()='Log in']
    Sleep    2s

    Wait Until Page Contains Element    //a[text()='Welcome ${user}']    30s

Inicio de sesion no valido
    Wait Until Page Contains Element    //a[text()='CATEGORIES']    30s
    Click Element    //a[text()='Log in']

    Wait Until Page Contains Element    (//label[text()='Username:'])[2]    30s
    Sleep    2s
    Input Text    //input[@id='loginusername']    ${user}
    Input Text    //input[@id='loginpassword']    ${pass}
    CapturaImagenSinComentarios
    Click Element    //button[text()='Log in']
    Sleep    2s

    Alert Should Be Present    User does not exist.    ACCEPT
    Sleep     3s
    CapturaImagenSinComentarios
    Close Browser

Envio informacion de contacto
    Wait Until Page Contains Element    //a[text()='CATEGORIES']    30s
    Click Element    //a[text()='Contact']

    Wait Until Page Contains Element    //label[text()='Contact Email:']    30s
    Sleep    2s

    Input Text    //input[@id='recipient-email']    ${contactemail}
    Input Text    //input[@id='recipient-name']    ${contactuser}
    Input Text    //textarea[@id='message-text']    ${contactmessage}

    Click Element    //button[text()='Send message']

    Alert Should Be Present    Thanks for the message!!    ACCEPT

    Close Browser

Agregar productos al carrito
#AGREGAR PRODUCTO 1
    Wait Until Page Contains Element    //a[contains(text(), '${producto1}')]    30s
    Click Element    //a[contains(text(), '${producto1}')]
    
    Wait Until Page Contains Element    //h2[contains(text(), '${producto1}')]    30s
    CapturaImagenSinComentarios
    Click Element    //a[text()='Add to cart']

    Handle Alert   ACCEPT
    Click Element    //a[text()='Home ']

#AGREGAR PRODUCTO 2
    Wait Until Page Contains Element    //a[contains(text(), '${producto2}')]    30s
    Click Element    //a[contains(text(), '${producto2}')]
    
    Wait Until Page Contains Element    //h2[contains(text(), '${producto2}')]    30s
    CapturaImagenSinComentarios
    Click Element    //a[text()='Add to cart']

    Handle Alert   ACCEPT
    Click Element    //a[text()='Home ']

#AGREGAR PRODUCTO 3
    Wait Until Page Contains Element    //a[contains(text(), '${producto3}')]    30s
    Click Element    //a[contains(text(), '${producto3}')]
    
    Wait Until Page Contains Element    //h2[contains(text(), '${producto3}')]    30s
    CapturaImagenSinComentarios
    Click Element    //a[text()='Add to cart']

    Handle Alert   ACCEPT
    Click Element    //a[text()='Home ']

#VALIDACION DE PRODUCTOS AÑADIDOS AL CARRITO
    Wait Until Page Contains Element    //a[text()='Cart']    30s
    Click Element    //a[text()='Cart']

    Wait Until Page Contains Element    //td[contains(text(), '${producto1}')]    30s
    Wait Until Page Contains Element    //td[contains(text(), '${producto2}')]    30s
    Wait Until Page Contains Element    //td[contains(text(), '${producto3}')]    30s
    CapturaImagenSinComentarios

Completar compra

    Wait Until Page Contains Element    //a[text()='Cart']    30s
    Click Element    //a[text()='Cart']

    Wait Until Page Contains Element    //button[text()='Place Order']
    Click Element    //button[text()='Place Order']
    Sleep    2s

    Input Text    //input[@id='name']    ${name}
    Input Text    //input[@id='country']    ${country}
    Input Text    //input[@id='city']    ${city}
    Input Text    //input[@id='card']    ${creditcard}
    Input Text    //input[@id='month']    ${month}
    Input Text    //input[@id='year']    ${year}
    CapturaImagenSinComentarios

    Click Element    //button[text()='Purchase']
    Wait Until Page Contains Element    //p[@class='lead text-muted ']    30s
    Log    Se realiza completar pago sin añadir producots
    CapturaImagenSinComentarios
    
Verificacion de productos disponibles

    ${CambioPagina}    Run Keyword And Return Status    Page Should Contain Element    //button[text()='Next']
    IF    ${CambioPagina}
        FOR    ${pagina}    IN RANGE    3
            Log     INICIO DEL CICLO
            
            Run Keyword And Ignore Error    Wait Until Page Contains Element    //a[contains(text(), '${producto1}')]    5s   
            Run Keyword And Ignore Error    Wait Until Page Contains Element    //a[contains(text(), '${producto2}')]    5s   
            Run Keyword And Ignore Error    Wait Until Page Contains Element    //a[contains(text(), '${producto3}')]    5s   
            Run Keyword And Ignore Error    Wait Until Page Contains Element    //a[contains(text(), '${producto4}')]    5s              

            Run Keyword And Ignore Error    Click Element    //button[text()='Next']
        END
    END
    
         
        