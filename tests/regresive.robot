*** Settings ***
Resource   ../resources/keywords.robot
Test Setup   Preparar escenario web
Test Teardown   Finalizar escenario web

*** Test Cases ***

TC-001 Validar pagina publica desde Excel
    [Tags]   TC-001
    Validar texto visible   ${expected_text}
    Esperar y validar elementos   ${login_locator}   ${fields_locator}   ${search_form_locator}

TC-002 Validar elementos del formulario de busqueda
    [Tags]   TC-002
    Validar texto visible   ${expected_text}
    Esperar y validar elementos   ${search_locator}   ${depating_locator}   ${returning_locator}   ${children_locator}   ${adults_locator}

TC-003 Iniciar sesion con credenciales
    [Tags]   TC-003
    Validar texto visible   ${expected_text}
    Iniciar sesion


TC-004 Validar saludo despues de iniciar sesion
    [Tags]   TC-004
    Validar texto visible   ${expected_text}
    Iniciar sesion

    

TC-005 Cerrar el formulario de inicio de sesion
    [Tags]   TC-005
    Validar texto visible   ${expected_text}

    Abrir inicio de sesion  ${expected_text}   ${login_locator}   ${username_locator}   ${password_locator}   ${login_btn_locator}

    Presionar elemento  ${cancel_btn_locator}
    Validar texto visible   ${expected_text}

TC-006 Seleccionar una fecha de salida
    [Tags]  TC-006
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}
    Colocar y validar fecha de salida   ${depating_locator}   ${calendar_locator}   ${date_locator}   ${accept_btn_locator}   ${date}



TC-007 Seleccionar una fecha de regreso
    [Tags]  TC-007
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}

    Colocar y validar fecha de salida   ${depating_locator}   ${calendar_locator}   ${date_locator1}   ${accept_btn_locator}   ${date1}
    Colocar y validar fecha de regreso   ${returning_locator}   ${calendar_locator}   ${date_locator2}   ${accept_btn_locator}   ${date2}

    Comparar valores distintos de dos campos  ${depating_locator}   ${returning_locator}
    Comparar fechas de inputs   ${depating_locator}   ${returning_locator}

TC-008 Seleccionar una fecha de regreso anterior al de salida
    [Tags]  TC-008
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}

    Colocar y validar fecha de regreso   ${returning_locator}   ${calendar_locator}   ${date_locator2}   ${accept_btn_locator}   ${date2}

    Colocar y validar fecha de salida   ${depating_locator}   ${calendar_locator}   ${date_locator1}   ${accept_btn_locator}   ${date1}
    
    Comparar valores distintos de dos campos  ${depating_locator}   ${returning_locator}
    Validar fecha de regreso invalida no aceptada   ${depating_locator}   ${returning_locator}   ${date2}

TC-009 Cambiar cantidad de pasajeros adultos
    [Tags]  TC-009
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}

    Colocar cantidad de pasajeros adultos   ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}

TC-010 Validar limites de pasajeros
    [Tags]  TC-010
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}

    # Validar minimo
    Esperar y validar elementos   ${adults_locator}   ${children_locator}   ${travelers_locator}
    Validar elemento contiene texto  ${travelers_locator}   ${min}

    # Validar maximo
    Colocar cantidad de pasajeros adultos   ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}
    Colocar cantidad de pasajeros ninios   ${children_locator}   ${children_quantity_locator}   ${children_quantity}
    Validar elemento contiene texto  ${travelers_locator}   ${max}

TC-011 Buscar viajes con datos validos
    [Tags]   TC-011
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}

    #Colocar fechas
    Colocar y validar fecha de salida   ${depating_locator}   ${calendar_locator}   ${date_locator1}   ${accept_btn_locator}   ${date1}

    Colocar y validar fecha de regreso   ${returning_locator}   ${calendar_locator}   ${date_locator2}   ${accept_btn_locator}   ${date2}
    
    Comparar valores distintos de dos campos  ${depating_locator}   ${returning_locator}
    Run Keyword And Continue On Failure   Comparar fechas de inputs   ${depating_locator}   ${returning_locator}

    #Elegir cantidad de pasajeros
    Colocar cantidad de pasajeros adultos   ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}
    Colocar cantidad de pasajeros ninios   ${children_locator}   ${children_quantity_locator}   ${children_quantity}

    #Presionar en buscar
    Presionar elemento  ${search_locator}


TC-012 Validar viajes disponibles luego de buscar
    [Tags]  TC-012
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}

    #Colocar fechas
    Colocar y validar fecha de salida   ${depating_locator}   ${calendar_locator}   ${date_locator1}   ${accept_btn_locator}   ${date1}

    Colocar y validar fecha de regreso   ${returning_locator}   ${calendar_locator}   ${date_locator2}   ${accept_btn_locator}   ${date2}
    Run Keyword And Continue On Failure   Comparar fechas de inputs   ${depating_locator}   ${returning_locator}

    #Elegir cantidad de pasajeros
    Colocar cantidad de pasajeros adultos   ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}
    Colocar cantidad de pasajeros ninios   ${children_locator}   ${children_quantity_locator}   ${children_quantity}

    #Presionar en buscar
    Presionar elemento  ${search_locator}

    #Validar resultados de busqueda
    Validar tarjetas de galeria   ${destinations_grid_locator}

TC-013 Seleccionar un destino de la galeria de viajes
    [Tags]  TC-013
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}

    #Colocar fechas
    Colocar y validar fecha de salida   ${depating_locator}   ${calendar_locator}   ${date_locator1}   ${accept_btn_locator}   ${date1}

    Colocar y validar fecha de regreso   ${returning_locator}   ${calendar_locator}   ${date_locator2}   ${accept_btn_locator}   ${date2}
    
    Comparar valores distintos de dos campos  ${depating_locator}   ${returning_locator}
    Run Keyword And Continue On Failure   Comparar fechas de inputs   ${depating_locator}   ${returning_locator}

    #Elegir cantidad de pasajeros
    Colocar cantidad de pasajeros adultos   ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}
    Colocar cantidad de pasajeros ninios   ${children_locator}   ${children_quantity_locator}   ${children_quantity}

    #Presionar en buscar
    Presionar elemento  ${search_locator}

    #Validar resultados de busqueda
    Validar tarjetas de galeria   ${destinations_grid_locator}

    #Reservar destino
    Esperar validar y presionar elemento   ${destination_btn_locator}
    Validar texto visible   ${reserved_text}

TC-014 Validar info de viaje seleccionado
    [Tags]  TC-014
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}

    #Colocar fechas
    Colocar y validar fecha de salida   ${depating_locator}   ${calendar_locator}   ${date_locator1}   ${accept_btn_locator}   ${date1}

    Colocar y validar fecha de regreso   ${returning_locator}   ${calendar_locator}   ${date_locator2}   ${accept_btn_locator}   ${date2}
    
    Comparar valores distintos de dos campos  ${depating_locator}   ${returning_locator}
    Run Keyword And Continue On Failure   Comparar fechas de inputs   ${depating_locator}   ${returning_locator}

    #Elegir cantidad de pasajeros
    Colocar cantidad de pasajeros adultos   ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}
    Colocar cantidad de pasajeros ninios   ${children_locator}   ${children_quantity_locator}   ${children_quantity}

    #Presionar en buscar
    Presionar elemento  ${search_locator}

    #Validar resultados de busqueda
    Validar tarjetas de galeria   ${destinations_grid_locator}

    #Reservar destino
    Esperar validar y presionar elemento   ${destination_btn_locator}
    Validar texto visible   ${reserved_text}

    Validar informacion del destino   ${expected_destiny_text}   ${expected_travelers_text}   ${expected_dates_text}  ${price_locator}


TC-015 Completar flujo principal de reservacion
    [Tags]  TC-015
    Validar texto visible   ${expected_text}
    Esperar y validar elemento   ${fields_locator}

    Iniciar sesion

    #Colocar fechas
    Colocar y validar fecha de salida   ${depating_locator}   ${calendar_locator}   ${date_locator1}   ${accept_btn_locator}   ${date1}

    Colocar y validar fecha de regreso   ${returning_locator}   ${calendar_locator}   ${date_locator2}   ${accept_btn_locator}   ${date2}
    
    Comparar valores distintos de dos campos  ${depating_locator}   ${returning_locator}
    Run Keyword And Continue On Failure   Comparar fechas de inputs   ${depating_locator}   ${returning_locator}

    #Elegir cantidad de pasajeros
    Colocar cantidad de pasajeros adultos   ${adults_locator}   ${adults_quantity_locator}   ${adults_quantity}
    Colocar cantidad de pasajeros ninios   ${children_locator}   ${children_quantity_locator}   ${children_quantity}

    #Presionar en buscar
    Presionar elemento  ${search_locator}

    #Validar resultados de busqueda
    Validar tarjetas de galeria   ${destinations_grid_locator}

    #Reservar destino
    Esperar validar y presionar elemento   ${destination_btn_locator}
    Validar texto visible   ${reserved_text}

    Validar informacion del destino   ${expected_destiny_text}   ${expected_travelers_text}   ${expected_dates_text}  ${price_locator}

    Completar y finalizar reserva  ${name_input_locator}   ${name_value}   ${email_input_locator}   ${email_value}   ${snumber_input_locator}   ${snumber_value}   ${phnumber_input_locator}   ${phnumber_value}   ${health_input_locator}  ${health_file}  ${real_health_input_locator}
