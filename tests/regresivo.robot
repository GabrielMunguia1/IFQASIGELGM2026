*** Settings ***
Library    SeleniumLibrary
Library    ./biblioteca/control_de_variables/ControldeVariablesLibrary.py    archivoVariables=${archivoVariables}    pais=${pais}    hoja=${hoja}
Resource    ../resources/keywords.robot    
Test Setup       Abrir Navegador
Test Teardown    Cerrar Navegador



*** Variables ***
${archivoVariables}    robot/regresivo.xlsx
${pais}
${hoja}                regresivo


*** Test Cases ***
TC001 - Validar la carga de la página principal
    [Tags]    TC001
    Validar Carga De La Pagina

TC002 - Validar los elementos del formulario de búsqueda
    [Tags]    TC002
    Verificar Elementos Del Formulario De Busqueda

TC003 - Iniciar Sesion con credenciales
    [Tags]    TC003
    Iniciar Sesion

TC004 - Validar Saludo
    [Tags]     TC004
    Iniciar Sesion
    Validar Saludo Al Usuario

TC005 - Cerrar Formulario
    [Tags]    TC005
    Cerrar Formulario

TC006 - Seleccionar una fecha de salida
    [Tags]    TC006
    Seleccionar fecha

TC007 - Seleccionar una fecha de Regreso
    [Tags]    TC007
    Seleccionar fecha
    Seleccionar Fecha De Regreso

TC008 - Validar un Rango de Fecha Incorrecto
    [Tags]    TC008
    Rango De Fechas Incorrecto

TC009 - Cambiar Cantidad de Pasajeros Adultos
    [Tags]    TC009
    Verificar Elementos Del Formulario De Busqueda
    Cambiar Cantidad De Adultos

TC010 - Verificar Limites de Pasajeros
    [Tags]    TC010
    Validar Limites De Selector Pasajeros

TC011 - Buscar Viajes con Datos Validos 
    [Tags]    TC011
    Validar Carga De La Pagina
    Buscar Viajes Con Datos Validos
    
TC012 - Verificar Resultado de Busqueda
    [Tags]    TC012
    Validar Carga De La Pagina
    Buscar Viajes Con Datos Validos
    Validar Informacion Del Resultado

TC013 - Seleccionar Un Destino
    [Tags]    TC013
    Buscar Viajes Con Datos Validos
    Seleccionar Destino

TC014 - Validar Informacion Del Viaje Seleccionado
    [Tags]    TC014
    Buscar Viajes Con Datos Validos
    Seleccionar Destino
    Validar Informacion Del Viaje

TC015 - Completar Flujo principal
    [Tags]    TC015
    Validar Carga De La Pagina
    Iniciar Sesion
    Validar Saludo Al Usuario
    Seleccionar fecha
    Seleccionar Fecha De Regreso
    Cambiar Cantidad De Adultos
    Buscar Viajes Con Datos Validos
    Validar Informacion Del Resultado
    Seleccionar Destino
    Validar Informacion Del Viaje
    Continuar Con Reservacion
    Validar El Resultado Final

TC016 - Completar Flujo principal
    [Tags]    TC016
    Validar Carga De La Pagina
    Iniciar Sesion
    Validar Saludo Al Usuario
    Seleccionar fecha
