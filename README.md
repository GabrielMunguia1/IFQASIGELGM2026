# Proyecto base de automatizacion con Robot Framework

Plantilla para pruebas automatizadas con Robot Framework, SeleniumLibrary,
datos desde Excel y evidencia individual en HTML/PDF.

El flujo recomendado es:

1. Escribir los datos en `variables/variables.xlsx`.
2. Crear o actualizar casos en `tests/`.
3. Reutilizar keywords de `resources/keywords.robot`.
4. Ejecutar con `robot.args`.
5. Revisar resultados en `results/`.

## Estructura del repo

```text
tests/
  regresive.robot          Suite principal de ejemplo

resources/
  keywords.robot           Keywords de negocio reutilizables
  datos_excel.py           Wrapper compatible hacia libraries/excel.py
  expandir_excel.py        Wrapper compatible hacia modifiers/expandir_excel.py
  reportes.py              Wrapper compatible hacia libraries/reportes.py

  libraries/
    excel.py               Keywords Python explicitas para Excel
    reportes.py            Keywords Python explicitas para evidencia

  modifiers/
    expandir_excel.py      Repite tests segun filas llenas del Excel

variables/
  variables.xlsx           Datos de entrada por caso
  variables.py             Lector generico opcional

docs/
  KEYWORDS.md              Catalogo de keywords nativas y propias
  STRUCTURE.md             Guia de capas y organizacion

robot.args                 Argumentos comunes de ejecucion
requirements.txt           Dependencias Python
results/                   Reportes generados
```

## Instalar

Instala Python 3.10 o superior y un navegador compatible con Selenium.

```powershell
python -m pip install -r requirements.txt
```

Para validar navegadores en Windows:

```powershell
where msedge
where chrome
```

## Ejecutar

Ejecutar toda la suite:

```powershell
python -m robot --argumentfile robot.args tests/regresive.robot
```

Validar sintaxis sin abrir navegador:

```powershell
python -m robot --dryrun --argumentfile robot.args tests/regresive.robot
```

Ejecutar un caso especifico:

```powershell
python -m robot --argumentfile robot.args -t "TC-001 Validar pagina publica desde Excel" tests/regresive.robot
```

`robot.args` ya configura:

```text
--outputdir
results
--prerunmodifier
resources.modifiers.expandir_excel.ExpandirCasosExcel
```

El `prerunmodifier` revisa el Excel antes de ejecutar y repite cada caso por
cada fila llena de datos.

Para usar otro archivo Excel sin tocar codigo:

```powershell
python -m robot --outputdir results --prerunmodifier resources.modifiers.expandir_excel.ExpandirCasosExcel:variables/otro.xlsx tests/regresive.robot
```

## Capas del proyecto

El repo queda separado en capas para que sea mas facil reutilizarlo:

- `tests/`: solo contiene escenarios de prueba.
- `resources/keywords.robot`: fachada legible para escribir pasos de negocio.
- `resources/libraries/`: librerias Python con keywords declaradas
  explicitamente con `@keyword`.
- `resources/modifiers/`: extensiones que cambian el modelo de ejecucion de
  Robot antes de correr.
- `variables/`: datos de entrada por ambiente, caso o proyecto.
- `docs/`: guias para mantener y reutilizar la plantilla.

Los archivos `resources/reportes.py`, `resources/datos_excel.py` y
`resources/expandir_excel.py` se mantienen como compatibilidad para imports
anteriores, pero el codigo recomendado vive en `resources/libraries/` y
`resources/modifiers/`.

## Flujo de Excel

Cada hoja del Excel representa un caso. El nombre de la hoja debe coincidir con
el tag del test.

Ejemplo: hoja `TC-001`

| url | browser | title | expected_text |
| --- | --- | --- | --- |
| https://www.example.com | Edge | Example Domain | Example Domain |
| https://www.python.org | Edge | Welcome to Python.org | Python |

Reglas:

- La fila 1 siempre contiene encabezados.
- Cada encabezado se convierte en variable Robot.
- `Expected Text` se normaliza como `${expected_text}`.
- La primera fila de datos es la fila 2 del Excel, pero internamente se usa
  como fila de datos `1`.
- Si una hoja tiene 2 filas llenas, el caso se ejecuta 2 veces.
- Si una hoja tiene 1 fila llena, el caso se ejecuta 1 vez.
- Las filas completamente vacias se ignoran.

Con el ejemplo anterior, Robot genera ejecuciones separadas:

```text
TC-001 Validar pagina publica desde Excel - datos 1
TC-001 Validar pagina publica desde Excel - datos 2
```

Cada ejecucion carga sus variables y genera evidencia propia.

## Crear un caso

1. Crea una hoja en `variables/variables.xlsx`, por ejemplo `TC-002`.
2. Agrega encabezados en la fila 1: `url`, `browser`, `expected_text`, etc.
3. Llena una o mas filas de datos.
4. Crea el test en `tests/regresive.robot` o en otra suite dentro de `tests/`.
5. Agrega el tag con el mismo codigo de la hoja.
6. Usa keywords de `resources/keywords.robot`.

Ejemplo:

```robot
*** Test Cases ***
TC-002 Buscar texto desde Excel
    [Tags]   TC-002
    Abrir navegador   ${url}   ${browser}
    Validar texto visible   ${expected_text}
```

La suite debe importar el recurso y usar setup/teardown:

```robot
*** Settings ***
Resource        ../resources/keywords.robot
Test Setup      Preparar caso de prueba
Test Teardown   Finalizar caso de prueba
```

## Keywords

El catalogo completo esta en `docs/KEYWORDS.md`.
La guia de organizacion esta en `docs/STRUCTURE.md`.

Las mas usadas son:

| Keyword | Uso |
| --- | --- |
| `Preparar caso de prueba` | Carga Excel default o un archivo indicado e inicia evidencia. |
| `Abrir navegador` | Abre navegador y registra evidencia. |
| `Esperar elemento visible` | Espera un elemento antes de interactuar. |
| `Presionar elemento` | Click sobre cualquier elemento. |
| `Introducir texto` | Escribe en un campo. |
| `Limpiar e introducir texto` | Limpia y escribe en un campo. |
| `Validar texto visible` | Valida texto en la pagina. |
| `Validar elemento contiene texto` | Valida texto dentro de un elemento. |
| `Registrar evidencia` | Agrega un paso manual al HTML/PDF. |
| `Finalizar caso de prueba` | Cierra navegador y genera evidencia. |

Tambien puedes usar directamente keywords nativas de SeleniumLibrary como
`Click Element`, `Input Text`, `Page Should Contain`, `Title Should Be` y
`Wait Until Element Is Visible`.

## Evidencia y reportes

Cada ejecucion crea archivos en `results/`:

- `output.xml`: resultado tecnico de Robot Framework.
- `log.html`: detalle completo de ejecucion.
- `report.html`: resumen nativo de Robot Framework.
- `evidencia-*.html`: evidencia ejecutiva por caso.
- `evidencia-*.pdf`: evidencia ejecutiva por caso.
- `*.png`: capturas tomadas durante la prueba.

La evidencia se genera aunque el caso falle, porque `Finalizar caso de prueba`
esta configurado como `Test Teardown`.

## Agregar mas keywords

Agrega wrappers nuevos en `resources/keywords.robot` cuando una accion se repita
en varios casos o cuando quieras registrar evidencia automaticamente.

Ejemplo:

```robot
Buscar texto
    [Arguments]   ${locator}   ${texto}
    Limpiar e introducir texto   ${locator}   ${texto}
    Press Keys   ${locator}   ENTER
    Registrar evidencia   Busqueda enviada: ${texto}
```

Si solo necesitas una accion una vez, puedes usar la keyword nativa directamente
en el test.

## Problemas comunes

- Si no abre navegador, valida que Edge o Chrome esten instalados.
- Si faltan variables, revisa el nombre de la hoja, el tag `TC-XXX` y los
  encabezados del Excel.
- Si un caso no se repite, valida que las filas tengan al menos una variable
  llena.
- Si no aparece el PDF, revisa `results/log.html`; el teardown registra errores
  de evidencia.
- Si falla una validacion, corrige los datos esperados en Excel o ajusta la
  keyword del test.
