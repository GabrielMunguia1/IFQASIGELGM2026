# Proyecto de Automatización QA

## Autor

**Fredy Gutiérrez**

Rama: `fredy-gutierrez`

---

## Descripción

Este proyecto corresponde a la entrega final del curso de Automatización QA.

Se desarrolló un conjunto de pruebas automatizadas para la aplicación web **Space & Beyond**, una plataforma de reservación de viajes espaciales.

Las pruebas fueron creadas utilizando **Robot Framework** y **SeleniumLibrary**, aplicando keywords reutilizables, variables almacenadas en Excel, esperas explícitas, validaciones y generación de evidencias.

---

## Objetivo del proyecto

Automatizar el flujo principal de reservación de un viaje espacial, verificando que los elementos y funcionalidades de la aplicación se comporten correctamente.

Entre las funciones evaluadas se encuentran:

- Carga de la página principal.
- Validación del formulario de búsqueda.
- Inicio de sesión.
- Validación del saludo al usuario.
- Selección de fechas de salida y regreso.
- Validación de rangos de fechas.
- Selección de pasajeros adultos y niños.
- Búsqueda de destinos.
- Validación de resultados.
- Selección de un destino.
- Validación del checkout.
- Validación del resumen de la reservación.

---

## Tecnologías utilizadas

- Python
- Robot Framework
- SeleniumLibrary
- OpenPyXL
- Google Chrome
- Visual Studio Code
- Git
- GitHub

---

## Estructura del proyecto

```text
ProyectoTestim/
│
├── biblioteca/
│   └── control_de_variables/
│       └── ControldeVariablesLibrary.py
│
├── resources/
│   ├── VGeneral.robot
│   ├── common.robot
│   └── keywords.robot
│
├── robot/
│   └── regresivo.xlsx
│
├── tests/
│   └── regresivo.robot
│
├── PREGUNTAS.txt
└── README.md
```

---

## Casos de prueba automatizados

El archivo `tests/regresivo.robot` contiene los siguientes escenarios:

| Código | Caso de prueba |
|---|---|
| TC001 | Validar la carga de la página principal |
| TC002 | Validar los elementos del formulario de búsqueda |
| TC003 | Iniciar sesión con credenciales |
| TC004 | Validar el saludo al usuario |
| TC005 | Cerrar el formulario |
| TC006 | Seleccionar una fecha de salida |
| TC007 | Seleccionar una fecha de regreso |
| TC008 | Validar un rango de fechas incorrecto |
| TC009 | Cambiar la cantidad de pasajeros adultos |
| TC010 | Verificar los límites de pasajeros |
| TC011 | Buscar viajes con datos válidos |
| TC012 | Verificar los resultados de búsqueda |
| TC013 | Seleccionar un destino |
| TC014 | Validar la información del viaje seleccionado |
| TC015 | Completar el flujo principal de reservación |
| TC016 | Validar un flujo adicional del sistema |

---

## Características implementadas

- Keywords reutilizables.
- Separación entre casos de prueba y acciones.
- Datos externos almacenados en Excel.
- Esperas explícitas.
- Validaciones de elementos y navegación.
- Capturas de pantalla como evidencia.
- Generación de reportes de ejecución.
- Uso de ramas, commits y merges con Git.
- Automatización del flujo completo de reservación.

---

## Instalación

Se debe tener instalado Python.

Después, instalar las dependencias principales:

```bash
py -m pip install robotframework
py -m pip install robotframework-seleniumlibrary
py -m pip install openpyxl
```

Para verificar la instalación:

```bash
py -m robot --version
```

---

## Ejecución de las pruebas

Para ejecutar todos los casos:

```bash
py -m robot -d results tests/regresivo.robot
```

Para ejecutar un caso específico mediante su etiqueta:

```bash
py -m robot -d results -i TC001 tests/regresivo.robot
```

Ejemplo para ejecutar el flujo principal:

```bash
py -m robot -d results -i TC015 tests/regresivo.robot
```

---

## Ejecución de varios casos

```bash
py -m robot -d results -i TC001 -i TC002 -i TC003 tests/regresivo.robot
```

---

## Resultados de ejecución

Después de ejecutar las pruebas, Robot Framework genera los siguientes archivos:

```text
results/
├── log.html
├── report.html
└── output.xml
```

También se generan capturas de pantalla y evidencias durante la ejecución de los casos.

---

## Validaciones utilizadas

Durante la automatización se utilizaron validaciones como:

- `Location Should Be`
- `Location Should Contain`
- `Wait Until Element Is Visible`
- `Wait Until Page Contains Element`
- `Page Should Contain Element`
- `Element Should Be Enabled`
- `Should Not Be Empty`
- `Should Be Equal As Strings`
- `Should Contain`

---

## Localizadores utilizados

Se utilizaron principalmente localizadores XPath basados en:

- Texto visible mediante `normalize-space()`.
- Atributos `data-react-toolbox`.
- Elementos del formulario.
- Botones y encabezados.
- Tarjetas de destinos.
- Selectores de fechas y pasajeros.

Ejemplo:

```robot
//h1[normalize-space()='Space & Beyond']
```

```robot
//button[normalize-space()='Select Destination']
```

```robot
//div[@data-react-toolbox='card']
```

---

## Flujo principal automatizado

El flujo principal realiza las siguientes acciones:

1. Abre la aplicación.
2. Valida la carga de la página.
3. Inicia sesión.
4. Valida el saludo al usuario.
5. Selecciona la fecha de salida.
6. Selecciona la fecha de regreso.
7. Cambia la cantidad de pasajeros.
8. Busca destinos disponibles.
9. Valida la información de los resultados.
10. Selecciona un destino.
11. Ingresa al checkout.
12. Valida los datos del viaje.
13. Continúa con la reservación.
14. Valida el resultado final.

---

## Conclusión

Este proyecto permitió aplicar conocimientos de automatización de pruebas utilizando Robot Framework y SeleniumLibrary.

La implementación de keywords reutilizables permitió reducir la duplicación de código, facilitar el mantenimiento y crear casos de prueba más organizados. Además, el uso de variables externas, esperas explícitas, evidencias y reportes ayudó a construir una automatización más estable y fácil de analizar.

---

## Curso

**Proyecto de Automatización QA**  
**IF QA SIGEL 2026**
