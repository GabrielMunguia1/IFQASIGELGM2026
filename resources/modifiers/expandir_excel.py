import re

from robot.api import SuiteVisitor

try:
    from resources.libraries.excel import obtener_filas_con_datos
except ImportError:
    from libraries.excel import obtener_filas_con_datos


class ExpandirCasosExcel(SuiteVisitor):
    def __init__(self, archivo=None):
        self.archivo = archivo

    def start_suite(self, suite):
        if not suite.tests:
            return

        tests_expandidos = []
        for test in suite.tests:
            codigo = self._codigo_desde_tags(test.tags)
            if not codigo:
                tests_expandidos.append(test)
                continue

            filas = obtener_filas_con_datos(codigo, self.archivo)
            if not filas:
                tests_expandidos.append(test)
                continue

            if len(filas) == 1:
                self._configurar_setup(test, codigo, filas[0])
                tests_expandidos.append(test)
                continue

            for indice, fila in enumerate(filas, start=1):
                clon = test.deepcopy()
                clon.name = f"{test.name} - datos {indice}"
                self._configurar_setup(clon, codigo, fila)
                tests_expandidos.append(clon)

        suite.tests.clear()
        suite.tests.extend(tests_expandidos)

    def _codigo_desde_tags(self, tags):
        for tag in tags:
            valor = str(tag).strip().upper().replace("_", "-")
            if re.fullmatch(r"TC[-_]?\d{1,4}", valor, flags=re.IGNORECASE):
                numero = re.search(r"\d{1,4}", valor).group(0)
                return f"TC-{int(numero):03}"
        return None

    def _configurar_setup(self, test, codigo, fila):
        if test.setup:
            args = (codigo, str(fila), self.archivo) if self.archivo else (codigo, str(fila))
            test.setup.config(args=args)
