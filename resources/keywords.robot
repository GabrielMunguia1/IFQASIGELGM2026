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

    


Cerrar Navegador
    Close Browser


Validar Pagina Principal
    Wait Until Element Is Visible    //h1[text()='Space & Beyond']    15s
    Wait Until Page Contains Element    //h2[text()='Customize your dream journey to space']    15s   
    CapturaImagenSinComentarios 
    


Validar Formulario Busqueda
   
    Wait Until Page Contains Element    (//input[contains(@class,'WhiteDatePicker__inputElement')])[1]    15s

    Wait Until Page Contains Element    (//input[contains(@class,'WhiteDatePicker__inputElement')])[2]    15s

    Wait Until Page Contains Element    //input[@value='Adults (18+)']    15s

    Wait Until Page Contains Element    //input[@value='Children (0-7)']    15s

    Wait Until Page Contains Element    //button[text()='Select Destination']    15s
    Sleep    2s


Inicio de Sesion Exitoso
    Wait Until Page Contains Element    //button[text()='Log in']    15s
    Click Element    //button[text()='Log in']

    Wait Until Element Is Visible    //input[@type='text' and @tabindex='1']    15s
    Input Text    //input[@type='text' and @tabindex='1']    ${usuario}

    Wait Until Element Is Visible    //input[@type='password']    15s
    Input Text    //input[@type='password']    ${password}

    CapturaImagenSinComentarios

    Sleep    3s
    Wait Until Page Contains Element    //button[@form='login' and text()='Log in']    15s
    Click Element    //button[@form='login' and text()='Log in']

    Wait Until Element Is Visible    //span[contains(text(),'Hello')]    20s


Validar Saludo Usuario
     Wait Until Element Is Visible    //span[contains(text(),'Hello')]    20s
     Sleep    2s


Cerrar Formulario Login
    Wait Until Page Contains Element    //button[text()='Log in']    15s
    Click Element    //button[text()='Log in']
   
    Sleep    1s

    Wait Until Page Contains Element    //button[text()='Cancel']    15s
    Click Element    //button[text()='Cancel']


Seleccionar Fecha Salida
    Wait Until Page Contains Element    (//input[contains(@class,'WhiteDatePicker__inputElement')])[1]    15s
    Click Element    (//input[contains(@class,'WhiteDatePicker__inputElement')])[1]

    Wait Until Element Is Visible    //span[text()='18']    15s
    Click Element    //span[text()='18']

    Wait Until Page Contains Element    //button[text()='Ok']    15s
    Click Element    //button[text()='Ok']
    CapturaImagenSinComentarios


Seleccionar Fecha Regreso
    Wait Until Element Is Visible    (//input[contains(@class,'WhiteDatePicker__inputElement')])[2]    15s
    Click Element    (//input[contains(@class,'WhiteDatePicker__inputElement')])[2]

    Wait Until Keyword Succeeds    10s    500ms
    ...    Click Element    //div[@data-react-toolbox='day' and .//span[text()='24']]

    Wait Until Element Is Visible    //button[text()='Ok']    15s
    Click Element    //button[text()='Ok']
    CapturaImagenSinComentarios

Validar Fecha Salida
    Wait Until Page Contains Element    //input[@value='18 July 2026']


Validar Fecha Regreso
    Wait Until Page Contains Element    //input[@value='24 July 2026']


Validar Rango Incorrecto
    Wait Until Page Contains Element    (//input[contains(@class,'WhiteDatePicker__inputElement')])[1]    15s
    Click Element    (//input[contains(@class,'WhiteDatePicker__inputElement')])[1]

    Wait Until Element Is Visible    //span[text()='25']    15s
    Click Element    //span[text()='25']

    Wait Until Page Contains Element    //button[text()='Ok']    15s
    Click Element    //button[text()='Ok']

    Wait Until Element Is Visible    (//input[contains(@class,'WhiteDatePicker__inputElement')])[2]    15s
    Click Element    (//input[contains(@class,'WhiteDatePicker__inputElement')])[2]

    Wait Until Keyword Succeeds    10s    500ms
    ...    Click Element    //div[@data-react-toolbox='day' and .//span[text()='24']]

    Sleep    2s
    CapturaImagenSinComentarios

    Wait Until Element Is Visible    //button[text()='Ok']    15s
    Click Element    //button[text()='Ok']

Cambiar Cantidad Adultos
    Wait Until Element Is Visible    //input[@value='Adults (18+)']    15s
    Click Element    //input[@value='Adults (18+)']

    Sleep    2s

    Click Element    //li[text()='3']
    CapturaImagenSinComentarios


Validar Limites Pasajeros

    Element Should Be Visible    //input[@role='input' and @readonly and @value='3']
    Sleep    2s


Buscar Viajes Validos
    Seleccionar Fecha Salida
    Seleccionar Fecha Regreso

    Wait Until Page Contains Element    //button[text()='Select Destination']    15s
    Click Element    //button[text()='Select Destination']
    Sleep    2s
    CapturaImagenSinComentarios


Validar Resultados Busqueda
    Wait Until Element Is Visible    //h2[text()='Your next destination']    20s

Seleccionar Destino
    Click Element    (//button[text()='Book'])[1]
    Sleep    2s


Validar Informacion Destino
    Element Should Be Visible    //h1[text()='Madan']    15s

    Element Should Be Visible    //strong[contains(text(), '$')]
    CapturaImagenSinComentarios


Continuar Reservacion
    Wait Until Page Contains Element    //span[text()='Name']/preceding-sibling::input
    Input Text    //span[text()='Name']/preceding-sibling::input    ${name}

    Input Text    //span[text()='Email Address']/preceding-sibling::input    ${email}

    Input Text    //span[text()='Social Security Number']/preceding-sibling::input    ${codigo}

    Input Text    //span[text()='Phone Number']/preceding-sibling::input    ${telefono}

    Click Element    //div[@data-react-toolbox='check']

    CapturaImagenSinComentarios

    Sleep    10s
    
    Wait Until Page Contains Element    //button[text()='Pay now']    10s
    Click Element    //button[text()='Pay now']    

    Sleep    2s




Flujo Completo Reservacion
    Inicio de Sesion Exitoso
    Seleccionar Fecha Salida
    Seleccionar Fecha Regreso
    Cambiar Cantidad Adultos
    Buscar Viajes Validos
    Seleccionar Destino
    Validar Informacion Destino
    Continuar Reservacion

#esta es la creacion de un nuevo keyword para la rama 'keywords-nueva'

Prueba de Keyword
    Abrir Navegador
    #prueba realizada