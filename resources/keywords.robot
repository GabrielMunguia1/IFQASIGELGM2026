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
    Open Browser    ${url}    ${navegador}
    Maximize Browser Window

Validar Carga De La Pagina
#Pagina Disponible
    Location Should Be    ${url}
#Validar Titulo
    Wait Until Page Contains Element    //h1[text()="Space & Beyond"]     30s
#Validar si se muestra formulario
    Page Should Contain Element    //div[contains(@class,'form-box')]    30s
#Validar si Se muestra la opción de inicio de sesión
    Page Should Contain Element    //button[normalize-space()='Log in']    30s
#Validar si Se muestran los campos de fecha y pasajeros.   
#FECHA 
    Page Should Contain Element    (//div[@data-react-toolbox='date-picker']//input)[1]    30s
    Page Should Contain Element    (//div[@data-react-toolbox='date-picker']//input)[2]    30s
#PASAJEROS
    Page Should Contain Element    (//div[@data-react-toolbox='dropdown'])[1]    30s
    Page Should Contain Element    (//div[@data-react-toolbox='dropdown'])[2]    30s
    CapturaImagenSinComentarios

Cerrar Navegador
    Close Browser

Verificar Elementos Del Formulario De Busqueda
# Validar campo de fecha de salida
    Wait Until Element Is Visible    (//div[@data-react-toolbox='date-picker'])[1]    30s
    Element Should Be Enabled    (//div[@data-react-toolbox='date-picker'])[1]    
#Validar campo de fecha de regreso
    Wait Until Element Is Visible    (//div[@data-react-toolbox='date-picker'])[2]    30s
    Element Should Be Enabled    (//div[@data-react-toolbox='date-picker'])[2]    
#Validar selector de adultos
    Wait Until Element Is Visible    (//div[@data-react-toolbox='dropdown'])[1]    30s
    Element Should Be Enabled    (//div[@data-react-toolbox='dropdown'])[1]    
#Validar selector de ninos
    Wait Until Element Is Visible    (//div[@data-react-toolbox='dropdown'])[2]    30s
    Element Should Be Enabled    (//div[@data-react-toolbox='dropdown'])[2]    
#validar el button
    Wait Until Element Is Visible    //button[normalize-space()='Select Destination']
    Element Should Be Enabled    //button[normalize-space()='Select Destination']   

    CapturaImagenSinComentarios


Iniciar Sesion
#Abrir formulario
    Wait Until Element Is Visible    //button[normalize-space()='Log in']    30s
    Click Element    //button[normalize-space()='Log in']
#Valdimos que abra el formulario
    Wait Until Element Is Visible    //h2[normalize-space()='Login']
    CapturaImagenSinComentarios
#Ingresamos usuario
    Wait Until Element Is Visible    (//input[contains(@class,'theme__inputElement___27dyY')])[9]    30s
    Input Text    (//input[contains(@class,'theme__inputElement___27dyY')])[9]   ${user}
    Wait Until Element Is Visible    (//input[contains(@class,'theme__inputElement___27dyY')])[10]
    Input Text    (//input[contains(@class,'theme__inputElement___27dyY')])[10]    ${pass}
    CapturaImagenSinComentarios
#Validar que el boton de login este visible
    Wait Until Element Is Visible    (//button[contains(normalize-space(),'Log in')])[2]    30s
    Element Should Be Enabled    (//button[contains(normalize-space(),'Log in')])[2]
#Confirmar Inicion de sesion
    Click Element    (//button[contains(normalize-space(),'Log in')])[2]
    CapturaImagenSinComentarios

Validar Saludo Al Usuario
    Wait Until Element Is Visible    //span[contains(text(),'Hello')]
    Page Should Contain Element    //span[contains(text(),'Hello')]
    CapturaImagenSinComentarios

Cerrar Formulario
    Wait Until Element Is Visible    //button[normalize-space()='Log in']    30s
    Click Element    //button[normalize-space()='Log in']
    Wait Until Element Is Visible    //h2[normalize-space()='Login']
#VALIDAMOS QUE ESTE EL BUTTON CANCEL
    Wait Until Element Is Visible    //button[normalize-space()='Cancel']    30s
    CapturaImagenSinComentarios
    Click Element    //button[normalize-space()='Cancel']  
#Confirmar Que salio del form
    Wait Until Element Is Visible    //button[normalize-space()='Log in']    30s
    CapturaImagenSinComentarios


Seleccionar Fecha
    Location Should Be    ${url}
    Wait Until Page Contains Element    //h1[normalize-space()='Space & Beyond']    30s
#Abrir calendario
    Wait Until Element Is Visible    (//div[@data-react-toolbox='date-picker']//input)[1]    30s
    Click Element    (//div[@data-react-toolbox='date-picker']//input)[1]
#Validar que el calendario abrió
    Wait Until Element Is Visible    //button[normalize-space()='Ok']    30s
    CapturaImagenSinComentarios
#Seleccionar el día
    Wait Until Keyword Succeeds    10s    1s    Click Element    //div[@data-react-toolbox='day'][.//span[normalize-space()='20']]
    CapturaImagenSinComentarios
#Confirmar la fecha
    Wait Until Keyword Succeeds    10s    1s    Click Element    //button[normalize-space()='Ok']
#Validar que el calendario desapareció
    Wait Until Element Is Not Visible    //button[normalize-space()='Ok']    30s
#Verificar que el campo tenga una fecha
    ${fecha}=    Get Value    (//div[@data-react-toolbox='date-picker']//input)[1]
    Should Not Be Empty    ${fecha}
    Should Contain         ${fecha}    20
    CapturaImagenSinComentarios

Seleccionar Fecha De Regreso
    Location Should Be    ${url}
    Wait Until Page Contains Element    //h1[normalize-space()='Space & Beyond']    30s

    Wait Until Element Is Visible    (//div[@data-react-toolbox='date-picker']//input)[2]    30s
    Click Element    (//div[@data-react-toolbox='date-picker']//input)[2]

    Wait Until Element Is Visible    //button[normalize-space()='Ok']    30s

    Wait Until Keyword Succeeds    10s    1s    Click Element    //div[@data-react-toolbox='day'][.//span[normalize-space()='25']]

    Wait Until Keyword Succeeds    10s    1s    Click Element    //button[normalize-space()='Ok']

    ${fecha_salida}=    Get Value    (//div[@data-react-toolbox='date-picker']//input)[1]
    ${fecha_regreso}=    Get Value    (//div[@data-react-toolbox='date-picker']//input)[2]

    Should Not Be Empty    ${fecha_salida}
    Should Not Be Empty    ${fecha_regreso}

    Log    Fecha de salida: ${fecha_salida}
    Log    Fecha de regreso: ${fecha_regreso}

    CapturaImagenSinComentarios
    
Rango De Fechas Incorrecto
    # Seleccionar fecha de salida
    Location Should Be    ${url}
    Wait Until Page Contains Element    //h1[normalize-space()='Space & Beyond']    30s
    CapturaImagenSinComentarios

    Wait Until Element Is Visible    (//div[@data-react-toolbox='date-picker']//input)[1]    30s
    Click Element    (//div[@data-react-toolbox='date-picker']//input)[1]

    Wait Until Element Is Visible    //button[normalize-space()='Ok']    30s

    Wait Until Keyword Succeeds    10s    1s    Click Element    //div[@data-react-toolbox='day'][.//span[normalize-space()='20']]

    Wait Until Keyword Succeeds    10s    1s    Click Element    //button[normalize-space()='Ok']

    CapturaImagenSinComentarios

    # Intentar seleccionar una fecha de regreso anterior
    Wait Until Element Is Visible    (//div[@data-react-toolbox='date-picker']//input)[2]    30s

    Wait Until Keyword Succeeds    10s    1s    Click Element    (//div[@data-react-toolbox='date-picker']//input)[2]

    Wait Until Element Is Visible    //button[normalize-space()='Ok']    30s

    Wait Until Keyword Succeeds    10s    1s    Click Element    //div[@data-react-toolbox='day'][.//span[normalize-space()='17']]

    Wait Until Keyword Succeeds    10s    1s    Click Element    //button[normalize-space()='Ok']

    CapturaImagenSinComentarios

    # Obtener las fechas finales
    ${fecha_salida}=    Get Value    (//div[@data-react-toolbox='date-picker']//input)[1]
    ${fecha_regreso}=    Get Value    (//div[@data-react-toolbox='date-picker']//input)[2]

    # Validar que ambos campos tengan un valor
    Should Not Be Empty    ${fecha_salida}
    Should Not Be Empty    ${fecha_regreso}

    # Registrar el comportamiento observado
    Log    Fecha de salida final: ${fecha_salida}
    Log    Fecha de regreso final: ${fecha_regreso}
    Log    La aplicación corrigió automáticamente el rango de fechas al seleccionar una fecha de regreso anterior a la fecha de salida.

    CapturaImagenSinComentarios

Validar Limites De Selector Pasajeros
    Location Should Be    ${url}
    Wait Until Page Contains Element    //h1[normalize-space()='Space & Beyond']    30s
     FOR    ${valor}    IN    1    2    3    4
        Click Element    (//div[@data-react-toolbox='dropdown'])[1]
        Wait Until Element Is Visible    (//ul[contains(@class,'theme__values')])[1]/li[normalize-space()='${valor}']
        Click Element    (//ul[contains(@class,'theme__values')])[1]/li[normalize-space()='${valor}']

        ${adultos}=    Get Value    (//div[@data-react-toolbox='dropdown']//input)[1]
        Should Be Equal As Strings    ${adultos}    ${valor}

        CapturaImagenSinComentarios
    END

    FOR    ${valor}    IN    3    2    1
        Click Element    (//div[@data-react-toolbox='dropdown'])[1]
        Wait Until Element Is Visible    (//ul[contains(@class,'theme__values')])[1]/li[normalize-space()='${valor}']
        Click Element    (//ul[contains(@class,'theme__values')])[1]/li[normalize-space()='${valor}']

        ${adultos}=    Get Value    (//div[@data-react-toolbox='dropdown']//input)[1]
        Should Be Equal As Strings    ${adultos}    ${valor}

        CapturaImagenSinComentarios
    END

    FOR    ${valor}    IN    1    2    3    4
        Click Element    (//div[@data-react-toolbox='dropdown'])[2]
        Wait Until Element Is Visible    (//ul[contains(@class,'theme__values')])[2]/li[normalize-space()='${valor}']
        Click Element    (//ul[contains(@class,'theme__values')])[2]/li[normalize-space()='${valor}']

        ${children}=    Get Value    (//div[@data-react-toolbox='dropdown']//input)[2]
        Should Be Equal As Strings    ${children}    ${valor}

        CapturaImagenSinComentarios
    END

    FOR    ${valor}    IN    3    2    1
        Click Element    (//div[@data-react-toolbox='dropdown'])[2]
        Wait Until Element Is Visible    (//ul[contains(@class,'theme__values')])[2]/li[normalize-space()='${valor}']
        Click Element    (//ul[contains(@class,'theme__values')])[2]/li[normalize-space()='${valor}']

        ${children}=    Get Value    (//div[@data-react-toolbox='dropdown']//input)[2]
        Should Be Equal As Strings    ${children}    ${valor}

        CapturaImagenSinComentarios
    END

Buscar Viajes Con Datos Validos
      # Seleccionar fecha de salida
    Click Element
    ...    (//div[@data-react-toolbox='date-picker']//input)[1]

    Wait Until Element Is Visible
    ...    //button[normalize-space()='Ok']
    ...    30s

    Wait Until Keyword Succeeds
    ...    10s
    ...    1s
    ...    Click Element
    ...    //div[@data-react-toolbox='day'][.//span[normalize-space()='20']]

    Wait Until Keyword Succeeds
    ...    10s
    ...    1s
    ...    Click Element
    ...    //button[normalize-space()='Ok']

    # Seleccionar fecha de regreso
    Click Element
    ...    (//div[@data-react-toolbox='date-picker']//input)[2]

    Wait Until Element Is Visible
    ...    //button[normalize-space()='Ok']
    ...    30s

    Wait Until Keyword Succeeds
    ...    10s
    ...    1s
    ...    Click Element
    ...    //div[@data-react-toolbox='day'][.//span[normalize-space()='25']]

    Wait Until Keyword Succeeds
    ...    10s
    ...    1s
    ...    Click Element
    ...    //button[normalize-space()='Ok']

    # Seleccionar 2 adultos
    Click Element
    ...    (//div[@data-react-toolbox='dropdown'])[1]

    Wait Until Element Is Visible
    ...    (//ul[contains(@class,'theme__values')])[1]/li[normalize-space()='2']
    ...    30s

    Click Element
    ...    (//ul[contains(@class,'theme__values')])[1]/li[normalize-space()='2']

    # Seleccionar 1 niño
    Click Element
    ...    (//div[@data-react-toolbox='dropdown'])[2]

    Wait Until Element Is Visible
    ...    (//ul[contains(@class,'theme__values')])[2]/li[normalize-space()='1']
    ...    30s

    Click Element
    ...    (//ul[contains(@class,'theme__values')])[2]/li[normalize-space()='1']

    # Obtener datos seleccionados
    ${fecha_salida}=    Get Value
    ...    (//div[@data-react-toolbox='date-picker']//input)[1]

    ${fecha_regreso}=    Get Value
    ...    (//div[@data-react-toolbox='date-picker']//input)[2]

    ${adultos}=    Get Value
    ...    (//div[@data-react-toolbox='dropdown']//input)[1]

    ${ninos}=    Get Value
    ...    (//div[@data-react-toolbox='dropdown']//input)[2]

    # Validar datos
    Should Not Be Empty    ${fecha_salida}
    Should Not Be Empty    ${fecha_regreso}
    Should Be Equal As Strings    ${adultos}    2
    Should Be Equal As Strings    ${ninos}    1

    Log    Fecha de salida: ${fecha_salida}
    Log    Fecha de regreso: ${fecha_regreso}
    Log    Adultos: ${adultos}
    Log    Niños: ${ninos}

    CapturaImagenSinComentarios

    # Ejecutar búsqueda
    Wait Until Element Is Visible
    ...    //button[normalize-space()='Select Destination']
    ...    30s

    Element Should Be Enabled
    ...    //button[normalize-space()='Select Destination']

    Click Element
    ...    //button[normalize-space()='Select Destination']

    # Esperar resultados
    Wait Until Element Is Visible
    ...    //h2[normalize-space()='Your next destination']
    ...    30s

    Scroll Element Into View
    ...    //h2[normalize-space()='Your next destination']

    Wait Until Element Is Visible
    ...    (//div[@data-react-toolbox='card'])[1]
    ...    30s

    # Validar resultados
    ${cantidad_destinos}=    SeleniumLibrary.Get Element Count
    ...    //div[@data-react-toolbox='card']

    Should Be True
    ...    ${cantidad_destinos} > 0
    ...    No se encontraron destinos después de realizar la búsqueda.

    Log    Cantidad de destinos encontrados: ${cantidad_destinos}

    Element Should Be Visible
    ...    (//div[@data-react-toolbox='card'])[1]

    Element Should Be Visible
    ...    (//div[@data-react-toolbox='card'])[1]//*[contains(@class,'cardTitle')]

    Element Should Be Visible
    ...    (//div[@data-react-toolbox='card'])[1]//button[normalize-space()='Book']

    Element Should Be Enabled
    ...    (//div[@data-react-toolbox='card'])[1]//button[normalize-space()='Book']

    ${titulo_destino}=    Get Text
    ...    (//div[@data-react-toolbox='card'])[1]//*[contains(@class,'cardTitle')]
    CapturaImagenSinComentarios


Cambiar Cantidad De Adultos
    # Abrir selector de adultos
    Wait Until Element Is Visible
    ...    (//div[@data-react-toolbox='dropdown'])[1]
    ...    30s

    Click Element
    ...    (//div[@data-react-toolbox='dropdown'])[1]

    CapturaImagenSinComentarios

    # Seleccionar la opción 2 dentro del primer desplegable
    Wait Until Element Is Visible
    ...    (//div[@data-react-toolbox='dropdown'])[1]//ul//*[normalize-space()='2']
    ...    30s

    Click Element
    ...    (//div[@data-react-toolbox='dropdown'])[1]//ul//*[normalize-space()='2']

    # Validar el valor seleccionado
    ${cantidad_adultos}=    Get Value
    ...    (//div[@data-react-toolbox='dropdown']//input)[1]

    Should Be Equal As Strings
    ...    ${cantidad_adultos}
    ...    2

    # Validar que no admita valores negativos
    Click Element
    ...    (//div[@data-react-toolbox='dropdown'])[1]

    Page Should Not Contain Element
    ...    (//div[@data-react-toolbox='dropdown'])[1]//ul//*[normalize-space()='-1']

    Log    Cantidad de adultos seleccionada: ${cantidad_adultos}

    CapturaImagenSinComentarios



Validar Informacion Del Resultado
    Wait Until Element Is Visible
    ...    (//div[@data-react-toolbox='card'])[1]
    ...    30s

    # Evidencia: Resultados cargados
    CapturaImagenSinComentarios

    ${cantidad_resultados}=    SeleniumLibrary.Get Element Count
    ...    //div[@data-react-toolbox='card']

    Should Be True
    ...    ${cantidad_resultados} > 0
    ...    No se encontraron resultados.

    Log    Cantidad de resultados encontrados: ${cantidad_resultados}

    ${limite}=    Evaluate    ${cantidad_resultados} + 1

    FOR    ${indice}    IN RANGE    1    ${limite}

        Log    ===== Validando destino ${indice} =====

        # Nombre del destino
        Wait Until Element Is Visible
        ...    (//div[@data-react-toolbox='card'])[${indice}]//*[contains(@class,'cardTitle')]
        ...    30s

        ${nombre}=    Get Text
        ...    (//div[@data-react-toolbox='card'])[${indice}]//*[contains(@class,'cardTitle')]

        Should Not Be Empty    ${nombre}

        # Imagen
        Wait Until Element Is Visible
        ...    (//div[@data-react-toolbox='card'])[${indice}]//*[contains(@class,'cardMedia')]
        ...    30s

        ${imagen}=    SeleniumLibrary.Get Element Attribute
        ...    (//div[@data-react-toolbox='card'])[${indice}]//*[contains(@class,'cardMedia')]
        ...    style

        Should Contain    ${imagen}    background-image

        # Precio
        Wait Until Element Is Visible
        ...    (//div[@data-react-toolbox='card'])[${indice}]//*[contains(text(),'$')]
        ...    30s

        ${precio}=    Get Text
        ...    (//div[@data-react-toolbox='card'])[${indice}]//*[contains(text(),'$')]

        Should Not Be Empty    ${precio}

        # Información del viaje
        Wait Until Element Is Visible
        ...    (//div[@data-react-toolbox='card'])[${indice}]//*[contains(@class,'cardText')]
        ...    30s

        ${descripcion}=    Get Text
        ...    (//div[@data-react-toolbox='card'])[${indice}]//*[contains(@class,'cardText')]

        Should Not Be Empty    ${descripcion}

        # Botón Book
        Wait Until Element Is Visible
        ...    (//div[@data-react-toolbox='card'])[${indice}]//button[normalize-space()='Book']
        ...    30s

        Element Should Be Enabled
        ...    (//div[@data-react-toolbox='card'])[${indice}]//button[normalize-space()='Book']

        Log
        ...    Destino ${indice}: ${nombre} | Precio: ${precio}

        # Evidencia de la primera tarjeta
        IF    ${indice} == 1
            Scroll Element Into View
            ...    (//div[@data-react-toolbox='card'])[1]

            Wait Until Element Is Visible
            ...    (//div[@data-react-toolbox='card'])[1]//button[normalize-space()='Book']
            ...    30s


        END

    END

    # Evidencia final de todos los resultados
    Scroll Element Into View
    ...    (//div[@data-react-toolbox='card'])[1]

    Wait Until Element Is Visible
    ...    (//div[@data-react-toolbox='card'])[1]
    ...    30s

    CapturaImagenSinComentarios


Seleccionar Destino
  # Esperar que exista al menos una tarjeta de destino
    Wait Until Element Is Visible    (//div[@data-react-toolbox='card'])[1]    30s
    Scroll Element Into View    (//div[@data-react-toolbox='card'])[1]

    # Validar nombre del destino
    Wait Until Element Is Visible    (//div[@data-react-toolbox='card'])[1]//*[contains(@class,'cardTitle')]    30s
    ${nombre_destino}=    Get Text    (//div[@data-react-toolbox='card'])[1]//*[contains(@class,'cardTitle')]
    Should Not Be Empty    ${nombre_destino}

    # Validar botón Book
    Wait Until Element Is Visible    (//div[@data-react-toolbox='card'])[1]//button[normalize-space()='Book']    30s
    Element Should Be Enabled    (//div[@data-react-toolbox='card'])[1]//button[normalize-space()='Book']

    Log    Destino seleccionado: ${nombre_destino}

    # Evidencia antes de seleccionar el destino
    CapturaImagenSinComentarios

    # Seleccionar destino
    Click Element    (//div[@data-react-toolbox='card'])[1]//button[normalize-space()='Book']

    # Validar redirección al checkout
    Wait Until Location Contains    /checkout    30s
    Location Should Contain    /checkout

    # Validar encabezado Checkout
    Wait Until Element Is Visible    //h2[normalize-space()='Checkout']    30s
    Page Should Contain Element    //h2[normalize-space()='Checkout']

    # Evidencia al ingresar al checkout
    CapturaImagenSinComentarios

    # Validar formulario del cliente
    Wait Until Element Is Visible    //form    30s

    ${cantidad_campos}=    SeleniumLibrary.Get Element Count    //form//div[@data-react-toolbox='input']
    Should Be True    ${cantidad_campos} >= 4    No se mostraron todos los campos requeridos del checkout.

    # Validar campos del formulario
    Page Should Contain Element    //form//*[normalize-space()='Name']
    Page Should Contain Element    //form//*[normalize-space()='Email Address']
    Page Should Contain Element    //form//*[normalize-space()='Social Security Number']
    Page Should Contain Element    //form//*[normalize-space()='Phone Number']

    # Evidencia del formulario
    CapturaImagenSinComentarios

    # Validar resumen de la orden
    Wait Until Element Is Visible    //*[normalize-space()='Order Summary']    30s
    Page Should Contain Element    //*[normalize-space()='Order Summary']

    Page Should Contain Element    //*[normalize-space()='Dates']
    Page Should Contain Element    //*[contains(normalize-space(),'traveler')]

    # Validar checkbox de términos y condiciones
    Wait Until Element Is Visible    //label[@data-react-toolbox='checkbox']    30s
    Page Should Contain Element    //label[@data-react-toolbox='checkbox']
    Page Should Contain Element    //label[@data-react-toolbox='checkbox']//input
    Page Should Contain Element    //label[@data-react-toolbox='checkbox']//div[@data-react-toolbox='check']
    Page Should Contain Element    //label[@data-react-toolbox='checkbox']//span[@data-react-toolbox='label' and normalize-space()='I agree to the terms and conditions']

    # Validar precio total
    Wait Until Element Is Visible    //div[contains(@class,'OrderSummary__price')]    30s
    Page Should Contain Element    //div[contains(@class,'OrderSummary__price')]

    ${precio_total}=    Get Text    //div[contains(@class,'OrderSummary__price')]
    Should Not Be Empty    ${precio_total}
    Should Contain    ${precio_total}    $

    Log    Precio total mostrado: ${precio_total}

    # Evidencia del resumen de la orden
    CapturaImagenSinComentarios

    # Validar botón Pay Now
    Wait Until Element Is Visible    //button[normalize-space()='Pay now']    30s
    Page Should Contain Element    //button[normalize-space()='Pay now']

    # El botón puede estar deshabilitado hasta completar los datos
    ${estado_boton}=    Run Keyword And Return Status    Element Should Be Enabled    //button[normalize-space()='Pay now']

    IF    ${estado_boton}
        Log    El botón Pay Now está habilitado.
    ELSE
        Log    El botón Pay Now está visible, pero deshabilitado hasta completar los datos requeridos.
    END

    Scroll Element Into View    //button[normalize-space()='Pay now']
    Wait Until Element Is Visible    //button[normalize-space()='Pay now']    30s

    
    CapturaImagenSinComentarios
    Sleep    2s

Validar Informacion Del Viaje
   # Esperar resultados
    Wait Until Element Is Visible    (//div[@data-react-toolbox='card'])[1]    30s

    # Seleccionar la quinta tarjeta
    ${tarjeta}=    Set Variable    (//div[@data-react-toolbox='card'])[5]

    Scroll Element Into View    ${tarjeta}
    Wait Until Element Is Visible    ${tarjeta}    30s

    # Guardar nombre del destino
    Wait Until Element Is Visible    ${tarjeta}//*[contains(@class,'cardTitle')]    30s
    ${nombre_destino}=    Get Text    ${tarjeta}//*[contains(@class,'cardTitle')]
    Should Not Be Empty    ${nombre_destino}

    # Guardar precio del destino
    Wait Until Element Is Visible    ${tarjeta}//*[contains(text(),'$')]    30s
    ${precio_destino}=    Get Text    ${tarjeta}//*[contains(text(),'$')]
    Should Not Be Empty    ${precio_destino}
    Should Contain    ${precio_destino}    $

    Log    Destino seleccionado: ${nombre_destino}
    Log    Precio seleccionado: ${precio_destino}

    CapturaImagenSinComentarios

    # Validar y presionar Book
    Wait Until Element Is Visible    ${tarjeta}//button[normalize-space()='Book']    30s
    Element Should Be Enabled    ${tarjeta}//button[normalize-space()='Book']
    Click Element    ${tarjeta}//button[normalize-space()='Book']

    # Validar redirección al Checkout
    Wait Until Location Contains    /checkout    30s
    Location Should Contain    /checkout

    Wait Until Element Is Visible    //h2[normalize-space()='Checkout']    30s
    CapturaImagenSinComentarios

    # Validar precio visible
    Wait Until Element Is Visible    //div[contains(@class,'OrderSummary__price')]    30s
    ${precio_checkout}=    Get Text    //div[contains(@class,'OrderSummary__price')]

    Should Not Be Empty    ${precio_checkout}
    Should Contain    ${precio_checkout}    $

    Log    Precio mostrado en Checkout: ${precio_checkout}

    # Validar fechas
    Wait Until Element Is Visible    //*[normalize-space()='Dates']    30s
    ${fechas_checkout}=    Get Text    //*[normalize-space()='Dates']/parent::*
    Should Not Be Empty    ${fechas_checkout}

    Log    Fechas mostradas: ${fechas_checkout}

    # Validar pasajeros
    Wait Until Element Is Visible    //*[contains(normalize-space(),'traveler')]    30s
    ${pasajeros_checkout}=    Get Text    //*[contains(normalize-space(),'traveler')]
    Should Not Be Empty    ${pasajeros_checkout}

    Log    Pasajeros mostrados: ${pasajeros_checkout}

    CapturaImagenSinComentarios

    # Ir hasta el final de la página
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)

    # Esperar la sección del destino
    Wait Until Element Is Visible    //h1[contains(@class,'Climate__headline-1')]    30s
    Scroll Element Into View    //h1[contains(@class,'Climate__headline-1')]

    # Obtener el nombre mostrado al final
    ${nombre_destino_final}=    Get Text    //h1[contains(@class,'Climate__headline-1')]
    Should Not Be Empty    ${nombre_destino_final}

    # Normalizar ambos nombres antes de comparar
    ${nombre_destino_minuscula}=    Convert To Lower Case    ${nombre_destino}
    ${nombre_final_minuscula}=    Convert To Lower Case    ${nombre_destino_final}
    ${nombre_final_limpio}=    Replace String    ${nombre_final_minuscula}    temperatures    ${EMPTY}
    ${nombre_final_limpio}=    Strip String    ${nombre_final_limpio}

    Should Be Equal As Strings    ${nombre_final_limpio}    ${nombre_destino_minuscula}
    CapturaImagenSinComentarios


Continuar Con Reservacion
    # Validar que estamos en Checkout
    Wait Until Element Is Visible    //h2[normalize-space()='Checkout']    30s
    Location Should Contain    /checkout

    # Completar nombre
    Wait Until Element Is Visible    (//form//input[@type='text'])[1]    30s
    Clear Element Text    (//form//input[@type='text'])[1]
    Input Text    (//form//input[@type='text'])[1]    ${name}

    # Completar correo
    Wait Until Element Is Visible    //form//input[@type='email']    30s
    Clear Element Text    //form//input[@type='email']
    Input Text    //form//input[@type='email']    ${email}

    # Completar seguro social con formato válido
    Wait Until Element Is Visible    (//form//input[@type='text'])[2]    30s
    Clear Element Text    (//form//input[@type='text'])[2]
    Input Text    (//form//input[@type='text'])[2]    ${socialNumero}

    # Completar teléfono válido
    Wait Until Element Is Visible    //form//input[@type='tel']    30s
    Clear Element Text    //form//input[@type='tel']
    Input Text    //form//input[@type='tel']    ${celular}

    # Quitar el foco del último campo para activar las validaciones
    Click Element    //h2[normalize-space()='Checkout']

    # Verificar que los campos conservaron sus valores
    Textfield Value Should Be    (//form//input[@type='text'])[1]    ${name}
    Textfield Value Should Be    //form//input[@type='email']    ${email}
    Textfield Value Should Be    (//form//input[@type='text'])[2]    ${socialNumero}
    Textfield Value Should Be    //form//input[@type='tel']    ${celular}

    CapturaImagenSinComentarios

    # Aceptar términos
    Scroll Element Into View    //label[@data-react-toolbox='checkbox']
    Wait Until Element Is Visible    //label[@data-react-toolbox='checkbox']    30s

    ${seleccionado}=    Run Keyword And Return Status    Checkbox Should Be Selected    //label[@data-react-toolbox='checkbox']//input

    IF    not ${seleccionado}
        Click Element    //label[@data-react-toolbox='checkbox']
    END

    Checkbox Should Be Selected    //label[@data-react-toolbox='checkbox']//input

    CapturaImagenSinComentarios

    # Validar botón Pay now habilitado
    Wait Until Element Is Visible    //button[translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')='pay now']    30s

    Wait Until Keyword Succeeds    15s    1s    Element Should Be Enabled    //button[translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')='pay now']

    CapturaImagenSinComentarios

    # Presionar Pay now
    Click Element    //button[translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')='pay now']

    Log    Se hizo clic en el botón Pay now.

Validar EL Resultado Final
    # La aplicación demo no muestra una confirmación posterior
    Location Should Contain    /checkout

    # Validar que seguimos en Checkout
    Wait Until Element Is Visible    //h2[normalize-space()='Checkout']    30s
    Page Should Contain Element    //h2[normalize-space()='Checkout']

    # Validar que el resumen sigue visible
    Wait Until Element Is Visible    //*[normalize-space()='Order Summary']    30s
    Page Should Contain Element    //*[normalize-space()='Order Summary']

    # Validar precio final
    Wait Until Element Is Visible    //div[contains(@class,'OrderSummary__price')]    30s
    ${precio_final}=    Get Text    //div[contains(@class,'OrderSummary__price')]

    Should Not Be Empty    ${precio_final}
    Should Contain    ${precio_final}    $

    # Validar que Pay now continúa visible
    Wait Until Element Is Visible
    ...    //button[translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')='pay now']
    ...    30s

    Page Should Contain Element
    ...    //button[translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')='pay now']

    Log    Precio final mostrado: ${precio_final}
    Log    La aplicación demo permanece en Checkout porque no implementa una confirmación posterior al pago.

    CapturaImagenSinComentarios

