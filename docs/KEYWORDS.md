# Catalogo de keywords

Este repositorio mezcla keywords nativas de Robot Framework/SeleniumLibrary con
keywords propias que agregan lectura de Excel y evidencia HTML/PDF.

Las keywords Python viven en `resources/libraries/` y estan declaradas con
`@keyword` y `ROBOT_AUTO_KEYWORDS = False`. Eso evita que Robot publique metodos
internos como keywords por accidente.

## Como leer este catalogo

- Usa las keywords propias para los pasos de negocio del test.
- Usa las keywords nativas cuando necesites algo puntual que todavia no tenga
  wrapper en `resources/keywords.robot`.
- Las keywords propias que interactuan con navegador registran evidencia
  automaticamente.

## Keywords propias de flujo

| Keyword | Argumentos | Uso |
| --- | --- | --- |
| `Preparar caso de prueba` | `${codigo_caso}=${EMPTY}`, `${fila}=1`, `${archivo}=${EMPTY}` | Carga variables desde Excel e inicia evidencia. Normalmente se usa como `Test Setup`. |
| `Finalizar caso de prueba` | `${cerrar_navegador}=True` | Cierra navegador, toma evidencia final y genera HTML/PDF. Normalmente se usa como `Test Teardown`. |
| `Registrar evidencia` | `${descripcion}=Evidencia`, `${capturar_pantalla}=True` | Agrega un paso al reporte del caso. |
| `Iniciar caso de prueba` | `${nombre}=None` | Inicia manualmente la evidencia de un caso. |

## Keywords propias de navegador

| Keyword | Argumentos | Uso |
| --- | --- | --- |
| `Abrir navegador` | `${url}`, `${browser}` | Abre navegador, maximiza y registra evidencia. |
| `Ir a url` | `${url}` | Navega a otra URL con el navegador abierto. |
| `Volver pagina` | Ninguno | Ejecuta `Go Back`. |
| `Recargar pagina` | Ninguno | Ejecuta `Reload Page`. |
| `Cerrar navegador` | Ninguno | Cierra el navegador actual. |
| `Cerrar todos los navegadores` | Ninguno | Cierra todos los navegadores abiertos por Selenium. |

## Keywords propias de validacion

| Keyword | Argumentos | Uso |
| --- | --- | --- |
| `Validar titulo de pagina` | `${title}` | Valida el titulo exacto de la pagina. |
| `Validar texto visible` | `${expected_text}` | Valida que el texto exista en la pagina. |
| `Validar elemento visible` | `${locator}` | Valida que un elemento este visible. |
| `Validar elemento contiene texto` | `${locator}`, `${expected_text}` | Valida texto dentro de un elemento. |
| `Validar url contiene` | `${expected_text}` | Valida una parte de la URL actual. |
| `Validar texto en alert` | `${expected_text}` | Valida y acepta una alerta del navegador. |
| `Esperar elemento visible` | `${locator}`, `${timeout}=10s` | Espera a que un elemento este visible. |

## Keywords propias de interaccion

| Keyword | Argumentos | Uso |
| --- | --- | --- |
| `Presionar boton` | `${locator}` | Click sobre un elemento tipo button. |
| `Presionar elemento` | `${locator}` | Click sobre cualquier elemento localizable. |
| `Introducir texto` | `${locator}`, `${text}` | Escribe texto en un campo. |
| `Limpiar e introducir texto` | `${locator}`, `${text}` | Limpia y escribe texto en un campo. |
| `Seleccionar opcion por texto` | `${locator}`, `${text}` | Selecciona una opcion visible en un select. |
| `Obtener texto de elemento` | `${locator}` | Devuelve el texto de un elemento. |

## Keywords Python de Excel

Estas keywords vienen de `resources/libraries/excel.py`.

| Keyword | Argumentos | Uso |
| --- | --- | --- |
| `Cargar variables de excel` | `${codigo_caso}=None`, `${fila}=1`, `${archivo}=None` | Lee una hoja del Excel y crea variables Robot con sus encabezados. |
| `Obtener filas con datos` | `${codigo_caso}`, `${archivo}=None` | Devuelve los indices de filas llenas para repetir un caso. |
| `Obtener codigo caso actual` | Ninguno | Obtiene el `TC-XXX` desde los tags del test. |

## Keywords nativas recomendadas

Estas vienen de Robot Framework o SeleniumLibrary y ya estan disponibles porque
`resources/keywords.robot` importa `SeleniumLibrary`.

| Keyword nativa | Biblioteca | Para que sirve |
| --- | --- | --- |
| `Should Be Equal` | BuiltIn | Comparar dos valores exactamente. |
| `Should Contain` | BuiltIn | Validar que un texto/lista contenga un valor. |
| `Set Test Variable` | BuiltIn | Crear variables visibles dentro del test actual. |
| `Log` | BuiltIn | Escribir mensajes en `log.html`. |
| `Open Browser` | SeleniumLibrary | Abrir navegador en una URL. |
| `Go To` | SeleniumLibrary | Navegar a otra URL. |
| `Click Element` | SeleniumLibrary | Click en cualquier elemento. |
| `Click Button` | SeleniumLibrary | Click en un boton. |
| `Input Text` | SeleniumLibrary | Escribir en un campo. |
| `Clear Element Text` | SeleniumLibrary | Limpiar un campo. |
| `Wait Until Element Is Visible` | SeleniumLibrary | Esperar visibilidad de elemento. |
| `Element Should Be Visible` | SeleniumLibrary | Validar visibilidad de elemento. |
| `Element Should Contain` | SeleniumLibrary | Validar texto dentro de elemento. |
| `Page Should Contain` | SeleniumLibrary | Validar texto en pagina. |
| `Title Should Be` | SeleniumLibrary | Validar titulo exacto. |
| `Location Should Contain` | SeleniumLibrary | Validar URL actual. |
| `Select From List By Label` | SeleniumLibrary | Seleccionar opcion visible en un select. |
| `Capture Page Screenshot` | SeleniumLibrary | Tomar captura manual. |
| `Close Browser` | SeleniumLibrary | Cerrar navegador actual. |
| `Close All Browsers` | SeleniumLibrary | Cerrar todos los navegadores. |

## Ejemplo de caso reutilizable

```robot
*** Test Cases ***
TC-002 Buscar producto desde Excel
    [Tags]   TC-002
    Abrir navegador   ${url}   ${browser}
    Esperar elemento visible   ${input_busqueda}
    Limpiar e introducir texto   ${input_busqueda}   ${producto}
    Presionar elemento   ${boton_buscar}
    Validar texto visible   ${resultado_esperado}
```
