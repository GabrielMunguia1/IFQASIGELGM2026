*** Settings ***
Library   SeleniumLibrary
Library   ${CURDIR}/libraries/reportes.py
Library   ${CURDIR}/libraries/excel.py
Library    DateTime

*** Keywords ***
# Flujo del caso
Preparar caso de prueba
    [Documentation]   Carga variables desde Excel segun el tag TC-XXX e inicia la evidencia del caso.
    [Arguments]   ${codigo_caso}=${EMPTY}   ${fila}=1   ${archivo}=${EMPTY}
    ${codigo_cargado}=   Cargar variables de excel   ${codigo_caso}   ${fila}   ${archivo}
    Iniciar caso de prueba
    Registrar evidencia   Datos cargados desde Excel para ${codigo_cargado}, fila ${fila}   False

Preparar escenario web
    [Documentation]   Carga las variables del caso desde Excel y abre el navegador.
    [Arguments]   ${codigo_caso}=${EMPTY}   ${fila}=1   ${archivo}=${EMPTY}
    Preparar caso de prueba   ${codigo_caso}   ${fila}   ${archivo}
    Abrir navegador   ${url}   ${browser}

# Navegacion
Abrir navegador
    [Documentation]   Abre el navegador en la URL indicada, maximiza la ventana y registra evidencia.
    [Arguments]   ${url}   ${browser}
    Open Browser   ${url}   ${browser}
    Maximize Browser Window
    Registrar evidencia   Navegador abierto en ${url}

Ir a url
    [Documentation]   Navega a una URL usando el navegador ya abierto.
    [Arguments]   ${url}
    Go To   ${url}
    Registrar evidencia   Navegacion realizada a ${url}

Volver pagina
    [Documentation]   Vuelve a la pagina anterior del navegador.
    Go Back
    Registrar evidencia   Volviendo a la pagina anterior

Recargar pagina
    [Documentation]   Recarga la pagina actual.
    Reload Page
    Registrar evidencia   Pagina recargada

# Validaciones
Validar titulo de pagina
    [Documentation]   Valida que el titulo de la pagina sea exactamente el esperado.
    [Arguments]   ${title}
    Title Should Be   ${title}
    Registrar evidencia   Titulo validado: ${title}

Validar texto visible
    [Documentation]   Valida que el texto esperado exista en la pagina.
    [Arguments]   ${expected_text}
    Page Should Contain   ${expected_text}
    Registrar evidencia   Texto visible validado: ${expected_text}

Validar elemento visible
    [Documentation]   Valida que un elemento este visible en pantalla.
    [Arguments]   ${locator}
    Element Should Be Visible   ${locator}
    Registrar evidencia   Elemento visible validado: ${locator}

Validar elemento contiene texto
    [Documentation]   Valida que un elemento contenga el texto esperado.
    [Arguments]   ${locator}   ${expected_text}
    Element Should Contain   ${locator}   ${expected_text}
    Registrar evidencia   Texto validado en ${locator}: ${expected_text}

Validar valor de un campo
    [Documentation]   Valida que un campo tenga el valor esperado.
    [Arguments]   ${locator}   ${expected_value}
    Textfield Value Should Be   ${locator}   ${expected_value}
    Registrar evidencia   Valor validado en ${locator}: ${expected_value}

Comparar valores iguales de dos campos
    [Documentation]   Valida que dos campos tengan valores iguales.
    [Arguments]   ${locator1}   ${locator2}
    ${value1}=   Get Value   ${locator1}
    ${value2}=   Get Value   ${locator2}
    Should Be Equal   ${value1}   ${value2}
    Registrar evidencia   Valores comparados: ${value1} y ${value2}

Comparar valores distintos de dos campos
    [Documentation]   Valida que dos campos tengan valores diferentes.
    [Arguments]   ${locator1}   ${locator2}
    ${value1}=   Get Value   ${locator1}
    ${value2}=   Get Value   ${locator2}
    Should Not Be Equal   ${value1}   ${value2}
    Registrar evidencia   Valores comparados: ${value1} y ${value2}

Validar url contiene
    [Documentation]   Valida que la URL actual contenga el texto esperado.
    [Arguments]   ${expected_text}
    Location Should Contain   ${expected_text}
    Registrar evidencia   URL contiene: ${expected_text}

Validar texto en alert
    [Documentation]   Valida el texto de una alerta y la acepta.
    [Arguments]   ${expected_text}
    Alert Should Be Present   ${expected_text}   

Esperar elemento visible
    [Documentation]   Espera hasta que el elemento este visible.
    [Arguments]   ${locator}   ${timeout}=10s
    Wait Until Element Is Visible   ${locator}   ${timeout}
    Registrar evidencia   Elemento visible despues de espera: ${locator}

Esperar y validar elemento
    [Documentation]   Espera hasta que un elemento este visible y valida su visibilidad.
    [Arguments]   ${locator}   ${timeout}=10s
    Wait Until Element Is Visible   ${locator}   ${timeout}
    Element Should Be Visible   ${locator}
    Registrar evidencia   Elemento esperado y validado correctamente: ${locator}

Esperar y validar elementos
    [Documentation]   Espera y valida una lista de elementos visibles.
    [Arguments]   @{locators}
    FOR   ${locator}   IN   @{locators}
        Esperar y validar elemento   ${locator}
    END

# Interacciones
Presionar boton
    [Documentation]   Presiona un elemento tipo button.
    [Arguments]   ${locator}
    Click Button   ${locator}
    Registrar evidencia   Boton presionado: ${locator}

Presionar elemento
    [Documentation]   Presiona cualquier elemento localizable.
    [Arguments]   ${locator}
    Click Element   ${locator}
    Registrar evidencia   Elemento presionado: ${locator}

Esperar validar y presionar elemento
    [Documentation]   Espera, valida y presiona un elemento.
    [Arguments]   ${locator}   ${timeout}=10s
    Wait Until Element Is Visible   ${locator}   ${timeout}
    Element Should Be Visible   ${locator}
    Click Element   ${locator}
    Registrar evidencia   Elemento esperado, validado y presionado: ${locator}

Introducir texto
    [Documentation]   Escribe texto en un campo sin limpiarlo antes.
    [Arguments]   ${locator}   ${text}
    Input Text   ${locator}   ${text}
    Registrar evidencia   Texto introducido: ${text} en el campo: ${locator}

Limpiar e introducir texto
    [Documentation]   Limpia un campo y luego escribe el texto indicado.
    [Arguments]   ${locator}   ${text}
    Clear Element Text   ${locator}
    Input Text   ${locator}   ${text}
    Registrar evidencia   Texto reemplazado en el campo: ${locator}

Seleccionar opcion por texto
    [Documentation]   Selecciona una opcion visible en un select HTML.
    [Arguments]   ${locator}   ${text}
    Select From List By Label   ${locator}   ${text}
    Registrar evidencia   Opcion seleccionada en ${locator}: ${text}

Obtener texto de elemento
    [Documentation]   Devuelve el texto visible de un elemento.
    [Arguments]   ${locator}
    ${text}=   Get Text   ${locator}
    Registrar evidencia   Texto obtenido desde ${locator}: ${text}   False
    RETURN   ${text}

Subir archivo a input
    [Documentation]   Sube un archivo a un input de tipo file.
    [Arguments]   ${locator}   ${file_path}
    Choose File   ${locator}   ${file_path}
    Registrar evidencia   Archivo subido desde ${file_path} al input: ${locator}
    
# Cierre
Cerrar navegador
    [Documentation]   Cierra el navegador actual.
    Close Browser

Cerrar todos los navegadores
    [Documentation]   Cierra todos los navegadores abiertos por Selenium.
    Close All Browsers

Finalizar escenario web
    [Documentation]   Finaliza la evidencia y garantiza el cierre de todos los navegadores.
    TRY
        Finalizar caso de prueba   False
    FINALLY
        Close All Browsers
    END


#-----------------------------Macro Keywords---------------------------
Comparar fechas de inputs
    [Arguments]    ${locator1}    ${locator2}

    ${value1}=    Get Value    ${locator1}
    ${value2}=    Get Value    ${locator2}

    Should Not Be Empty    ${value1}    El primer input de fecha está vacío
    Should Not Be Empty    ${value2}    El segundo input de fecha está vacío

    ${date1}=    Convert Date
    ...    ${value1}
    ...    date_format=%d %B %Y
    ...    result_format=epoch

    ${date2}=    Convert Date
    ...    ${value2}
    ...    date_format=%d %B %Y
    ...    result_format=epoch

    Should Be True
    ...    ${date1} < ${date2}
    ...    La fecha de salida (${value1}) debe ser menor que la fecha de regreso (${value2})

    Registrar evidencia    Fechas comparadas: ${value1} y ${value2}

Comparar fecha de regreso anterior a salida
    [Arguments]    ${salida_locator}    ${regreso_locator}

    ${salida}=    Get Value    ${salida_locator}
    ${regreso}=    Get Value    ${regreso_locator}

    Should Not Be Empty    ${salida}    El input de fecha de salida esta vacio
    Should Not Be Empty    ${regreso}    El input de fecha de regreso esta vacio

    ${fecha_salida}=    Convert Date
    ...    ${salida}
    ...    date_format=%d %B %Y
    ...    result_format=epoch

    ${fecha_regreso}=    Convert Date
    ...    ${regreso}
    ...    date_format=%d %B %Y
    ...    result_format=epoch

    Should Be True
    ...    ${fecha_regreso} < ${fecha_salida}
    ...    La fecha de regreso (${regreso}) debe ser menor que la fecha de salida (${salida})

    Registrar evidencia    Fecha de regreso anterior a salida validada: ${regreso} < ${salida}

Validar fecha de regreso invalida no aceptada
    [Arguments]    ${salida_locator}    ${regreso_locator}    ${regreso_invalido}

    ${salida}=    Get Value    ${salida_locator}
    ${regreso}=    Get Value    ${regreso_locator}

    Should Not Be Empty    ${salida}    El input de fecha de salida esta vacio
    Should Not Be Empty    ${regreso}    El input de fecha de regreso esta vacio
    Should Not Be Equal    ${regreso}    ${regreso_invalido}    La aplicacion acepto la fecha de regreso invalida (${regreso_invalido})

    ${fecha_salida}=    Convert Date
    ...    ${salida}
    ...    date_format=%d %B %Y
    ...    result_format=epoch

    ${fecha_regreso}=    Convert Date
    ...    ${regreso}
    ...    date_format=%d %B %Y
    ...    result_format=epoch

    Should Be True
    ...    ${fecha_regreso} > ${fecha_salida}
    ...    La fecha de regreso final (${regreso}) debe ser posterior a la fecha de salida (${salida})

    Registrar evidencia    Fecha invalida no aceptada. Intentada: ${regreso_invalido}, final: ${regreso}



Abrir inicio de sesion
    [Arguments]  ${expected_text}   ${login_locator}   ${username_locator}   ${password_locator}   ${login_btn_locator}
    Esperar validar y presionar elemento   ${login_locator}
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${username_locator}
    Esperar y validar elemento   ${password_locator}
    Esperar y validar elemento   ${login_btn_locator}

Llenar formulario inicio de sesion e iniciar
    [Arguments]  ${username_locator}   ${password_locator}   ${login_btn_locator}   ${username}   ${password}   ${success_expected_text}
    Introducir texto   ${username_locator}   ${username}
    Introducir texto   ${password_locator}   ${password}
    Presionar elemento  ${login_btn_locator}
    Validar texto visible   ${success_expected_text}

Iniciar sesion
    [Documentation]   Abre el formulario de inicio de sesion e ingresa las credenciales cargadas para el caso.
    Abrir inicio de sesion   ${expected_text}   ${login_locator}   ${username_locator}   ${password_locator}   ${login_btn_locator}
    Llenar formulario inicio de sesion e iniciar   ${username_locator}   ${password_locator}   ${login_btn_locator}   ${username}   ${password}   ${success_expected_text}

Buscar viajes con fechas y pasajeros
    [Documentation]   Completa fechas y pasajeros, valida las fechas y ejecuta la busqueda.
    Colocar y validar fecha de salida   ${depating_locator}   ${calendar_locator}   ${date_locator1}   ${accept_btn_locator}   ${date1}
    Colocar y validar fecha de regreso   ${returning_locator}   ${calendar_locator}   ${date_locator2}   ${accept_btn_locator}   ${date2}
    Comparar valores distintos de dos campos   ${depating_locator}   ${returning_locator}
    Run Keyword And Continue On Failure   Comparar fechas de inputs   ${depating_locator}   ${returning_locator}
    Colocar cantidad de pasajeros adultos   ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}
    Colocar cantidad de pasajeros ninios   ${children_locator}   ${children_quantity_locator}   ${children_quantity}
    Presionar elemento   ${search_locator}

Validar galeria y reservar destino
    [Documentation]   Valida los resultados disponibles y selecciona un destino.
    Validar tarjetas de galeria   ${destinations_grid_locator}
    Esperar validar y presionar elemento   ${destination_btn_locator}
    Validar texto visible   ${reserved_text}

Colocar y validar fecha de salida
    [Arguments]  ${depating_locator}   ${calendar_locator}   ${date_locator}   ${accept_btn_locator}   ${date}
    Seleccionar y validar fecha   ${depating_locator}   ${calendar_locator}   ${date_locator}   ${accept_btn_locator}   ${date}

Colocar y validar fecha de regreso
    [Arguments]  ${returning_locator}   ${calendar_locator}   ${date_locator}   ${accept_btn_locator}   ${date}
    Seleccionar y validar fecha   ${returning_locator}   ${calendar_locator}   ${date_locator}   ${accept_btn_locator}   ${date}

Seleccionar y validar fecha
    [Documentation]   Selecciona una fecha del calendario y valida el valor del campo.
    [Arguments]   ${input_locator}   ${calendar_locator}   ${date_locator}   ${accept_btn_locator}   ${expected_date}
    Esperar validar y presionar elemento   ${input_locator}
    Esperar y validar elemento   ${calendar_locator}
    Presionar elemento   ${date_locator}
    Presionar elemento   ${accept_btn_locator}
    Validar valor de un campo   ${input_locator}   ${expected_date}

Colocar cantidad de pasajeros adultos
    [Arguments]  ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}
    Colocar cantidad de pasajeros   ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}

Colocar cantidad de pasajeros ninios
    [Arguments]  ${children_locator}   ${children_quantity_locator}   ${children_quantity}
    Colocar cantidad de pasajeros   ${children_locator}   ${children_quantity_locator}   ${children_quantity}

Colocar cantidad de pasajeros
    [Documentation]   Selecciona y valida una cantidad de pasajeros.
    [Arguments]   ${input_locator}   ${quantity_locator}   ${expected_quantity}
    Esperar validar y presionar elemento   ${input_locator}
    Esperar validar y presionar elemento   ${quantity_locator}
    Validar valor de un campo   ${input_locator}   ${expected_quantity}

Validar tarjetas de galeria
	[Arguments]	${grid_xpath}

	${cards_xpath}=	Set Variable	${grid_xpath}//div[@data-react-toolbox="card"]
	${cards}=	Get WebElements	xpath=${cards_xpath}
	${cantidad}=	Get Length	${cards}

	Should Be True	${cantidad} > 0	No se encontraron tarjetas dentro de la grilla

	${limite}=	Evaluate	${cantidad} + 1

	FOR	${indice}	IN RANGE	1	${limite}
		${card_xpath}=	Set Variable	(${cards_xpath})[${indice}]
		Validar tarjeta de galeria	${card_xpath}	${indice}
	END


Validar tarjeta de galeria
	[Arguments]	${card_xpath}	${indice}

	${nombre_locator}=	Set Variable	xpath=${card_xpath}//h5
	${imagen_locator}=	Set Variable	xpath=${card_xpath}//div[contains(@style, "background-image")]
	${descripcion_locator}=	Set Variable	xpath=${card_xpath}//p
	${precio_locator}=	Set Variable	xpath=${card_xpath}//span[starts-with(normalize-space(.), "$")]
	${book_locator}=	Set Variable	xpath=${card_xpath}//button[normalize-space(.)="Book"]

	Element Should Be Visible	${nombre_locator}
	Element Should Be Visible	${imagen_locator}
	Element Should Be Visible	${descripcion_locator}
	Element Should Be Visible	${precio_locator}
	Element Should Be Visible	${book_locator}

	${nombre}=	Get Text	${nombre_locator}
	${descripcion}=	Get Text	${descripcion_locator}
	${precio}=	Get Text	${precio_locator}
	${imagen_style}=	Get Element Attribute	${imagen_locator}	style
	${texto_book}=	Get Text	${book_locator}

	Should Not Be Empty	${nombre}	La tarjeta ${indice} no contiene nombre
	Should Not Be Empty	${descripcion}	La tarjeta ${indice} no contiene descripcion
	Should Not Be Empty	${precio}	La tarjeta ${indice} no contiene precio
	Should Not Be Empty	${imagen_style}	La tarjeta ${indice} no contiene imagen

	Should Contain	${imagen_style}	background-image	La tarjeta ${indice} no contiene background-image
	Should Contain	${imagen_style}	url(	La imagen de la tarjeta ${indice} no contiene una URL
	Should Be Equal	${texto_book}	BOOK	La tarjeta ${indice} no contiene la opcion Book

	Should Match Regexp	${precio}	^\\$[0-9]+(\\.[0-9]{2})?$	El precio '${precio}' de la tarjeta ${indice} no tiene un formato valido

	Registrar evidencia	Tarjeta ${indice} validada. Nombre: ${nombre}, precio: ${precio}	False


Validar informacion del destino
    [Arguments]  ${expected_destiny_text}   ${expected_travelers_text}   ${expected_dates_text}  ${price_locator}
    Validar texto visible  ${expected_destiny_text}
    Validar texto visible  ${expected_travelers_text}
    Validar texto visible  ${expected_dates_text}
    Validar elemento visible  ${price_locator}

Completar y finalizar reserva
    [Arguments]  ${name_input_locator}   ${name_value}   ${email_input_locator}   ${email_value}   ${snumber_input_locator}   ${snumber_value}   ${phnumber_input_locator}   ${phnumber_value}   ${health_input_locator}  ${health_file}  ${real_health_input_locator}

    Esperar elemento visible  ${name_input_locator}
    Esperar elemento visible  ${email_input_locator}
    Esperar elemento visible  ${snumber_input_locator}
    Esperar elemento visible  ${phnumber_input_locator}
    Esperar elemento visible  ${health_input_locator}

    Introducir texto   ${name_input_locator}   ${name_value}
    Introducir texto   ${email_input_locator}   ${email_value}
    Introducir texto   ${snumber_input_locator}   ${snumber_value}
    Introducir texto   ${phnumber_input_locator}   ${phnumber_value}
    Subir archivo a input  ${real_health_input_locator}   ${health_file}
