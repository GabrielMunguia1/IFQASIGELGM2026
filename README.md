# Automatización del flujo de reservas de Space & Beyond

Suite de pruebas web construida con Robot Framework y SeleniumLibrary para
validar la aplicación de demostración
[Space & Beyond](https://demo.testim.io/).

El proyecto automatiza el recorrido principal de una reserva: validación de la
página, inicio de sesión, selección de fechas y pasajeros, búsqueda de viajes,
revisión de destinos, reserva y captura de los datos del viajero. Los datos,
credenciales, valores esperados y localizadores se leen desde Excel.

## Cobertura actual

La suite `tests/regresive.robot` contiene 15 casos:

| Caso | Validación |
| --- | --- |
| TC-001 | Elementos principales de la página |
| TC-002 | Controles del formulario de búsqueda |
| TC-003 | Inicio de sesión con credenciales |
| TC-004 | Saludo mostrado después del inicio de sesión |
| TC-005 | Cancelación del formulario de inicio de sesión |
| TC-006 | Selección de fecha de salida |
| TC-007 | Selección de fecha de regreso posterior a la salida |
| TC-008 | Rechazo de una fecha de regreso inválida |
| TC-009 | Cambio de cantidad de pasajeros adultos |
| TC-010 | Límites mínimo y máximo de pasajeros |
| TC-011 | Búsqueda con fechas y pasajeros válidos |
| TC-012 | Tarjetas de viajes disponibles |
| TC-013 | Selección y reserva de un destino |
| TC-014 | Información de la reserva seleccionada |
| TC-015 | Flujo integral: sesión, búsqueda, destino y datos del viajero |

## Tecnologías

- Python 3.10 o posterior
- Robot Framework 7
- SeleniumLibrary y Selenium
- openpyxl para leer los datos de prueba
- fpdf2 para generar evidencia en PDF
- Microsoft Edge por defecto en los datos actuales

Las versiones utilizadas están fijadas en `requirements.txt`.

## Estructura

```text
tests/
  regresive.robot               Suite con los 15 casos

variables/
  variables.xlsx               Datos y localizadores por caso
  variables.py                 Lector alternativo del Excel

resources/
  keywords.robot               Keywords de navegador y del flujo de reservas
  libraries/
    excel.py                    Carga datos como variables de Robot
    reportes.py                 Capturas y evidencia HTML/PDF
  modifiers/
    expandir_excel.py           Expande casos por cada fila de datos

docs/
  KEYWORDS.md                   Catálogo detallado de keywords
  STRUCTURE.md                  Organización interna del proyecto

robot.args                      Configuración común de ejecución
requirements.txt                Dependencias de Python
results/                        Resultados generados (no versionados)
```

Los módulos Python ubicados directamente en `resources/` son wrappers de
compatibilidad. La implementación principal está en `resources/libraries/` y
`resources/modifiers/`.

## Instalación

1. Instala Python 3.10 o posterior.
2. Instala Microsoft Edge, que es el navegador configurado actualmente en el
   Excel. Selenium Manager se encarga de resolver el controlador compatible.
3. Crea y activa un entorno virtual (recomendado):

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

4. Instala las dependencias:

```powershell
python -m pip install -r requirements.txt
```

## Ejecución

Ejecutar toda la suite:

```powershell
python -m robot --argumentfile robot.args tests/regresive.robot
```

Validar la sintaxis y la resolución de keywords sin ejecutar el navegador:

```powershell
python -m robot --dryrun --argumentfile robot.args tests/regresive.robot
```

Ejecutar un caso por nombre:

```powershell
python -m robot --argumentfile robot.args \
  --test "TC-015 Completar flujo principal de reservacion" \
  tests/regresive.robot
```

También se puede filtrar por el tag asociado a la hoja:

```powershell
python -m robot --argumentfile robot.args --include TC-015 tests/regresive.robot
```

`robot.args` configura la carpeta `results/` y activa
`ExpandirCasosExcel`. Este modificador crea una ejecución por cada fila no vacía
de la hoja correspondiente. Por ello, un caso puede aparecer con nombres como
`... - datos 1`, `... - datos 2`, etc.

## Datos de prueba en Excel

`variables/variables.xlsx` contiene una hoja por caso, desde `TC-001` hasta
`TC-015`. El tag del test debe coincidir con el nombre de su hoja:

```robot
TC-006 Seleccionar una fecha de salida
    [Tags]    TC-006
    Validar texto visible    ${expected_text}
```

En cada hoja:

- La primera fila contiene los encabezados.
- Las filas siguientes contienen combinaciones de datos.
- Los encabezados se normalizan a minúsculas y guiones bajos y se exponen como
  variables de Robot. Por ejemplo, `Expected Text` se convierte en
  `${expected_text}`.
- Las filas completamente vacías se ignoran.
- Las hojas actuales apuntan a `https://demo.testim.io/` y usan `Edge`.

Los datos incluyen URLs, credenciales de prueba, fechas, cantidades, textos
esperados, rutas de archivos y localizadores XPath/CSS. Si cambia la interfaz de
la aplicación, los localizadores deben actualizarse en el Excel.

Para ejecutar contra otro libro con la misma estructura:

```powershell
python -m robot --outputdir results \
  --prerunmodifier resources.modifiers.expandir_excel.ExpandirCasosExcel:variables/otro.xlsx \
  tests/regresive.robot
```

## Flujo interno de cada prueba

1. `Preparar escenario web`, configurado como `Test Setup`, identifica el
   `TC-XXX`, carga la fila del Excel, inicia la evidencia y abre el navegador.
2. El caso usa las keywords de `resources/keywords.robot`.
3. Las interacciones importantes registran pasos y capturas.
4. `Finalizar escenario web`, configurado como `Test Teardown`, genera la
   evidencia y cierra todos los navegadores incluso si el caso falla.

Las keywords de negocio cubren, entre otras acciones:

- inicio de sesión;
- selección y comparación de fechas;
- configuración y validación de pasajeros;
- validación de las tarjetas de destinos;
- selección de un viaje;
- validación del resumen de reserva;
- llenado del formulario final y carga de un archivo.

El catálogo completo está en `docs/KEYWORDS.md`.

## Resultados y evidencia

Después de ejecutar se generan en `results/`:

- `output.xml`: resultado procesable de Robot Framework;
- `log.html`: detalle de pasos y errores;
- `report.html`: resumen de la ejecución;
- `evidencia-*.html`: evidencia individual por ejecución;
- `evidencia-*.pdf`: versión PDF de esa evidencia;
- archivos `.png`: capturas tomadas durante los pasos.

La evidencia individual incluye el nombre del caso, estado, duración, mensaje
de error y capturas disponibles.

## Agregar o modificar un caso

1. Crea o actualiza una hoja `TC-XXX` en `variables/variables.xlsx`.
2. Define los encabezados y una o más filas de datos.
3. Agrega el test con el mismo tag en `tests/regresive.robot`.
4. Reutiliza las keywords de `resources/keywords.robot`.
5. Ejecuta primero el `--dryrun` y luego la prueba real.

Ejemplo:

```robot
TC-016 Validar nuevo comportamiento
    [Tags]    TC-016
    Esperar y validar elemento    ${element_locator}
    Validar texto visible         ${expected_text}
```

## Solución de problemas

- **No abre el navegador:** comprueba que Edge esté instalado y accesible.
- **Falta una variable:** revisa el encabezado, el tag del test y la hoja
  `TC-XXX`.
- **Se ejecuta más de una vez:** la hoja contiene varias filas no vacías y el
  modificador genera una prueba por cada una.
- **Falla un localizador:** actualízalo en la hoja del caso; la interfaz de la
  aplicación pudo cambiar.
- **No se genera el PDF:** consulta `results/log.html` para ver el error
  registrado por el teardown.
- **Falla la carga de archivo del TC-015:** comprueba que el valor
  `health_file` apunte a un archivo existente y accesible.
