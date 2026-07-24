*** Settings ***
Library    SeleniumLibrary
Library    ../biblioteca/control_de_variables/ControldeVariablesLibrary.py    archivoVariables=${archivoVariables}    pais=${pais}    hoja=${hoja}
Resource    ../resources/keywords.robot    
#Suite Setup    Open Browser    ${urlnav}    chrome
#Suite Teardown    Close Browser


*** Variables ***
${archivoVariables}    %{archivoVariables=regresivo_v1.xlsx}
${pais}
${hoja}

*** Test Cases ***

TC001 Validar carga pagina principal
    [Tags]    TC001
    Abrir Navegador
    Validar Pagina Principal
    Cerrar Navegador


TC002 Validar elementos formulario busqueda
    [Tags]    TC002
    Abrir Navegador
    Validar Formulario Busqueda
    Cerrar Navegador


TC003 Iniciar sesion con credenciales
    [Tags]    TC003
    Abrir Navegador
    Inicio de Sesion Exitoso
    Cerrar Navegador


TC004 Validar saludo despues login
    [Tags]    TC004
    Abrir Navegador
    Inicio de Sesion Exitoso
    Validar Saludo Usuario
    Cerrar Navegador


TC005 Cerrar formulario login
    [Tags]    TC005
    Abrir Navegador
    Cerrar Formulario Login
    Cerrar Navegador


TC006 Seleccionar fecha salida
    [Tags]    TC006
    Abrir Navegador
    Seleccionar Fecha Salida
    Validar Fecha Salida
    Cerrar Navegador


TC007 Seleccionar fecha regreso
    [Tags]    TC007
    Abrir Navegador
    Seleccionar Fecha Salida
    Seleccionar Fecha Regreso
    Validar Fecha Regreso
    Cerrar Navegador


TC008 Validar rango incorrecto
    [Tags]    TC008
    Abrir Navegador
    Validar Rango Incorrecto
    Cerrar Navegador


TC009 Cambiar cantidad adultos
    [Tags]    TC009
    Abrir Navegador
    Cambiar Cantidad Adultos
    Cerrar Navegador


TC010 Validar limites pasajeros
    [Tags]    TC010
    Abrir Navegador
    Validar Limites Pasajeros
    Cerrar Navegador


TC011 Buscar viajes validos
    [Tags]    TC011
    Abrir Navegador
    Buscar Viajes Validos
    Validar Resultados Busqueda
    Cerrar Navegador


TC012 Validar resultados busqueda
    [Tags]    TC012
    Abrir Navegador
    Buscar Viajes Validos
    Validar Resultados Busqueda
    Cerrar Navegador


TC013 Seleccionar destino
    [Tags]    TC013
    Abrir Navegador
    Buscar Viajes Validos
    Seleccionar Destino
    Cerrar Navegador


TC014 Validar informacion destino
    [Tags]    TC014
    Abrir Navegador
    Buscar Viajes Validos
    Seleccionar Destino
    Validar Informacion Destino
    Cerrar Navegador


TC015 Flujo principal reservacion
    [Tags]    TC015
    Abrir Navegador
    Flujo Completo Reservacion
    Cerrar Navegador