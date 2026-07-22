*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library   XML
Library    String

*** Variables ***


*** Keywords ***

  ${Nombre1}    ${Nombre2}    ${filename}
CapturaImagenSinComentarios
    ${nombre}=    Set Variable    evidencia-${TEST NAME}-{index}.png

    ${filename}=    Capture Page Screenshot    ${nombre}

    Should Not Be Empty
    ...    ${filename}
    ...    SeleniumLibrary no devolvió la ruta de la captura.

    Logging Evidence In Report    ${filename}


Eliminar productos del carrito de compras
    Wait Until Page Contains Element    //a[text()='Cart']    30s
    Click Element    //a[text()='Cart']
    CapturaImagenSinComentarios
    Sleep    3s

    ${existe_delete}    Run Keyword And Return Status    Page Should Contain Element    //a[text()='Delete']
    IF    ${existe_delete}
        Log    Existen productos en el carrito
        WHILE    ${True}
          ${existe_delete}=    Run Keyword And Return Status    Page Should Contain Element    //a[text()='Delete']   

          IF    not ${existe_delete}
              Log    Ya no existe productos en el carrito
              BREAK
          END
          
        Click Element    //a[text()='Delete']
        Sleep    3s

        END
    ELSE
        Log    No existe productos por eliminar
        
    END

    CapturaImagenSinComentarios
    #Continua el flujo
    Wait Until Page Contains Element    //a[text()='Home ']    30s
    Click Element    //a[text()='Home ']

KEYWORD PRUEBA CLASE GIT SEMANA 10
    Click Button    locator=XPATH
    Click Button    locator=XPATH
    Click Button    locator=XPATH
    Click Button    locator=XPATH
    Click Button    locator=XPATH
    Click Button    locator=XPATH
    Click Button    locator=XPATH
    Click Button    locator=XPATH