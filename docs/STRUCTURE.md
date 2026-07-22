# Guia de estructura

Esta plantilla esta organizada por capas. La meta es que un proyecto nuevo pueda
cambiar datos, agregar suites y extender keywords sin tocar el motor base.

## Capas

```text
tests/
  Casos de prueba escritos en lenguaje de negocio.

resources/keywords.robot
  Fachada Robot. Aqui se escriben wrappers legibles que combinan Selenium,
  Excel y evidencia.

resources/libraries/
  Librerias Python que exponen keywords explicitas con @keyword.

resources/modifiers/
  Modificadores de modelo de Robot. Se ejecutan antes de la suite.

variables/
  Datos externos. El Excel puede cambiar por proyecto o ambiente.

docs/
  Documentacion para usuarios del repo.
```

## Regla practica

- Si es un paso reusable de negocio, agregalo a `resources/keywords.robot`.
- Si necesita Python o estado interno, agregalo a `resources/libraries/`.
- Si cambia como Robot construye o ejecuta los tests, agregalo a
  `resources/modifiers/`.
- Si es dato del proyecto, dejalo en `variables/`.
- Si solo es explicacion de uso, agregalo a `docs/`.

## Librerias Python explicitas

Las librerias Python usan:

```python
from robot.api.deco import keyword

ROBOT_AUTO_KEYWORDS = False

@keyword("Nombre visible en Robot")
def mi_keyword():
    ...
```

Con esto Robot solo publica lo que esta decorado. Los helpers internos quedan
privados para el codigo Python.

## Compatibilidad

Estos archivos siguen existiendo para no romper imports anteriores:

- `resources/datos_excel.py`
- `resources/reportes.py`
- `resources/expandir_excel.py`

El codigo recomendado esta en:

- `resources/libraries/excel.py`
- `resources/libraries/reportes.py`
- `resources/modifiers/expandir_excel.py`

## Flujo de ejecucion

1. Robot lee `robot.args`.
2. `resources.modifiers.expandir_excel.ExpandirCasosExcel` revisa las hojas del
   Excel default o del archivo indicado y duplica los tests segun filas llenas.
3. Cada test ejecuta `Preparar caso de prueba`.
4. `Preparar caso de prueba` carga variables desde Excel e inicia evidencia.
5. El test ejecuta pasos de negocio desde `resources/keywords.robot`.
6. `Finalizar caso de prueba` cierra navegador y genera HTML/PDF.

Para apuntar a otro Excel, pasa la ruta como argumento del modificador:

```powershell
python -m robot --outputdir results --prerunmodifier resources.modifiers.expandir_excel.ExpandirCasosExcel:variables/otro.xlsx tests/regresive.robot
```

## Como extender

Ejemplo de wrapper Robot:

```robot
Buscar producto
    [Arguments]   ${locator}   ${producto}
    Limpiar e introducir texto   ${locator}   ${producto}
    Press Keys   ${locator}   ENTER
    Registrar evidencia   Producto buscado: ${producto}
```

Ejemplo de keyword Python:

```python
from robot.api.deco import keyword

ROBOT_AUTO_KEYWORDS = False

@keyword("Normalizar texto")
def normalizar_texto(valor):
    return str(valor).strip().lower()
```
