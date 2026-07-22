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

TC001 - REGISTRO USUARIO
    [Tags]    TC001
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Keyword Succeeds    30s    1s    Validar Root Principal

Validar Root Principal
${existe}=    Execute JavaScript
...    const app = document.querySelector('shop-app');
...    return app !== null && app.shadowRoot !== null;
Should Be True    ${existe}

TC002 - INCIO DE SESION EXITOSO
    [Tags]    TC002
    Abrir Navegador
    Inicio de sesion

TC003 - INICIO DE SESION NO EXITOSO
    [Tags]    TC003
    Abrir Navegador
    Inicio de sesion no valido

TC004 - ENVIO INFORMACION DE CONTACTO
    [Tags]    TC004
    Abrir Navegador
    Envio informacion de contacto

TC005 - AGREGAR PRODUCTOS AL CARRITO CON LOGIN CUENTA EXISTENTE
    [Tags]    TC005
    Abrir Navegador
    Inicio de sesion
    Eliminar productos del carrito de compras
    Agregar productos al carrito

TC006 - COMPLETAR COMPRA CUENTA EXISTENTE
    [Tags]    TC006
    Abrir Navegador
    Inicio de sesion
    Eliminar productos del carrito de compras
    Agregar productos al carrito
    Completar compra

TC007 - VALIDACION DE PRODUCTOS DISPONIBLES
    [Tags]    TC007
    Abrir Navegador
    Inicio de sesion
    Verificacion de productos disponibles

TC008 - COMPLETAR COMPRA SIN LOGIN DE CUENTA
    [Tags]    TC008
    Abrir Navegador
    Agregar productos al carrito
    Completar compra

TC009 - ELIMINAR PRODUCTO CLIENTE EXISTENTE
    [Tags]    TC009
    Abrir Navegador
    Inicio de sesion
    Eliminar productos del carrito de compras

TC010 - COMPRA COMPLETA DE UN MISMO PRODUCTO
    [Tags]    TC010
    Abrir Navegador
    Inicio de sesion
    Eliminar productos del carrito de compras
    Agregar productos al carrito
    Completar compra

TC011 - COMPLETAR COMPRA SIN SELECCIONAR PRODUCTOS
    [Tags]    TC011
    Abrir Navegador
    Inicio de sesion
    Eliminar productos del carrito de compras
    Completar compra
    