from datetime import datetime
from html import escape as _html_escape
from pathlib import Path
import re

from fpdf import FPDF
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


ROBOT_LIBRARY_SCOPE = "GLOBAL"
ROBOT_AUTO_KEYWORDS = False


class Reportes:
    def __init__(self):
        self.casos = []
        self.caso_actual = None

    def iniciar_caso_de_prueba(self, nombre=None):
        test_name = nombre or self._robot_var("${TEST NAME}", "caso")
        self.caso_actual = {
            "nombre": str(test_name),
            "inicio": datetime.now(),
            "pasos": [],
        }
        self._log(f"Reporte iniciado para: {test_name}")

    def registrar_evidencia(self, descripcion="Evidencia", capturar_pantalla=True):
        if self.caso_actual is None:
            self.iniciar_caso_de_prueba()

        screenshot = None
        if self._as_bool(capturar_pantalla):
            screenshot = self._capturar_pantalla()

        self.caso_actual["pasos"].append(
            {
                "fecha": datetime.now(),
                "descripcion": str(descripcion),
                "screenshot": screenshot,
            }
        )

    def finalizar_caso_de_prueba(self, cerrar_navegador=True):
        if self.caso_actual is None:
            self.iniciar_caso_de_prueba()

        estado = self._robot_var("${TEST STATUS}", "UNKNOWN")
        mensaje = self._robot_var("${TEST MESSAGE}", "")

        self.registrar_evidencia(f"Estado final del caso: {estado}", True)

        if self._as_bool(cerrar_navegador):
            self._cerrar_navegador()

        self.caso_actual["fin"] = datetime.now()
        self.caso_actual["estado"] = str(estado)
        self.caso_actual["mensaje"] = str(mensaje or "")

        html_path = self._generar_html(self.caso_actual)
        pdf_path = self._generar_pdf(self.caso_actual)

        self.caso_actual["html"] = str(html_path)
        self.caso_actual["pdf"] = str(pdf_path)
        self.casos.append(self.caso_actual)
        self.caso_actual = None

        self._log(f"Evidencia HTML: {html_path}")
        self._log(f"Evidencia PDF: {pdf_path}")

    def _output_dir(self):
        output_dir = self._robot_var("${OUTPUT DIR}", None)
        path = Path(output_dir) if output_dir else Path.cwd() / "results"
        path.mkdir(parents=True, exist_ok=True)
        return path

    def _capturar_pantalla(self):
        try:
            selenium = BuiltIn().get_library_instance("SeleniumLibrary")
        except Exception as exc:
            self._log(f"No se pudo obtener SeleniumLibrary para captura: {exc}", "WARN")
            return None

        output_dir = self._output_dir()
        nombre = self._safe_name(self._robot_var("${TEST NAME}", "captura"))
        timestamp = datetime.now().strftime("%Y%m%d-%H%M%S-%f")
        screenshot = output_dir / f"{nombre}-{timestamp}.png"

        try:
            selenium.capture_page_screenshot(str(screenshot))
            return screenshot
        except Exception as exc:
            self._log(f"No se pudo capturar pantalla: {exc}", "WARN")
            return None

    def _cerrar_navegador(self):
        try:
            selenium = BuiltIn().get_library_instance("SeleniumLibrary")
            selenium.close_all_browsers()
        except Exception as exc:
            self._log(f"No se pudo cerrar el navegador: {exc}", "WARN")

    def _generar_html(self, caso):
        output_dir = self._output_dir()
        timestamp = caso["inicio"].strftime("%Y%m%d-%H%M%S")
        nombre = self._safe_name(caso["nombre"])
        path = output_dir / f"evidencia-{nombre}-{timestamp}.html"

        duracion = caso.get("fin", datetime.now()) - caso["inicio"]
        pasos = []
        for indice, paso in enumerate(caso["pasos"], start=1):
            img = ""
            screenshot = paso.get("screenshot")
            if screenshot:
                screenshot_path = Path(screenshot)
                img = (
                    f'<a href="{_html_escape(screenshot_path.name)}">'
                    f'<img src="{_html_escape(screenshot_path.name)}" alt="Captura {indice}"></a>'
                )
            pasos.append(
                "<section>"
                f"<h2>Paso {indice}</h2>"
                f"<p>{_html_escape(paso['descripcion'])}</p>"
                f"<small>{_html_escape(paso['fecha'].strftime('%Y-%m-%d %H:%M:%S'))}</small>"
                f"{img}"
                "</section>"
            )

        contenido = f"""<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>Evidencia - {_html_escape(caso['nombre'])}</title>
  <style>
    body {{ font-family: Arial, sans-serif; margin: 32px; color: #202124; }}
    header {{ border-bottom: 3px solid #1a73e8; margin-bottom: 24px; padding-bottom: 16px; }}
    h1 {{ margin: 0 0 8px; font-size: 24px; }}
    h2 {{ margin-bottom: 8px; font-size: 18px; }}
    .estado {{ display: inline-block; padding: 6px 10px; color: white; background: {self._status_color(caso['estado'])}; }}
    table {{ border-collapse: collapse; margin-top: 16px; width: 100%; }}
    td {{ border: 1px solid #d0d7de; padding: 8px; vertical-align: top; }}
    section {{ break-inside: avoid; border-bottom: 1px solid #d0d7de; padding: 18px 0; }}
    img {{ display: block; margin-top: 12px; max-width: 100%; border: 1px solid #d0d7de; }}
  </style>
</head>
<body>
  <header>
    <h1>Evidencia de prueba automatizada</h1>
    <div class="estado">{_html_escape(caso['estado'])}</div>
    <table>
      <tr><td>Caso</td><td>{_html_escape(caso['nombre'])}</td></tr>
      <tr><td>Inicio</td><td>{_html_escape(caso['inicio'].strftime('%Y-%m-%d %H:%M:%S'))}</td></tr>
      <tr><td>Duracion</td><td>{_html_escape(str(duracion).split('.')[0])}</td></tr>
      <tr><td>Mensaje</td><td>{_html_escape(caso.get('mensaje', ''))}</td></tr>
    </table>
  </header>
  {''.join(pasos)}
</body>
</html>
"""
        path.write_text(contenido, encoding="utf-8")
        return path

    def _generar_pdf(self, caso):
        output_dir = self._output_dir()
        timestamp = caso["inicio"].strftime("%Y%m%d-%H%M%S")
        nombre = self._safe_name(caso["nombre"])
        path = output_dir / f"evidencia-{nombre}-{timestamp}.pdf"

        pdf = FPDF()
        pdf.set_auto_page_break(auto=True, margin=15)
        pdf.add_page()
        pdf.set_font("Helvetica", "B", 16)
        pdf.cell(0, 10, self._pdf_text("Evidencia de prueba automatizada"), ln=1)

        pdf.set_font("Helvetica", "", 10)
        pdf.cell(0, 7, self._pdf_text(f"Caso: {caso['nombre']}"), ln=1)
        pdf.cell(0, 7, self._pdf_text(f"Estado: {caso['estado']}"), ln=1)
        pdf.cell(0, 7, self._pdf_text(f"Inicio: {caso['inicio'].strftime('%Y-%m-%d %H:%M:%S')}"), ln=1)
        if caso.get("mensaje"):
            pdf.multi_cell(0, 6, self._pdf_text(f"Mensaje: {caso['mensaje']}"))
        pdf.ln(3)

        for indice, paso in enumerate(caso["pasos"], start=1):
            if pdf.get_y() > 250:
                pdf.add_page()
            pdf.set_font("Helvetica", "B", 12)
            pdf.cell(0, 8, self._pdf_text(f"Paso {indice}"), ln=1)
            pdf.set_font("Helvetica", "", 10)
            pdf.multi_cell(0, 6, self._pdf_text(paso["descripcion"]))
            pdf.cell(0, 6, self._pdf_text(paso["fecha"].strftime("%Y-%m-%d %H:%M:%S")), ln=1)

            screenshot = paso.get("screenshot")
            if screenshot and Path(screenshot).exists():
                if pdf.get_y() > 150:
                    pdf.add_page()
                try:
                    pdf.image(str(screenshot), x=15, w=180)
                    pdf.ln(4)
                except Exception as exc:
                    pdf.multi_cell(0, 6, self._pdf_text(f"No se pudo insertar captura: {exc}"))
            pdf.ln(4)

        pdf.output(str(path))
        return path

    def _robot_var(self, name, default=None):
        try:
            return BuiltIn().get_variable_value(name, default)
        except Exception:
            return default

    def _safe_name(self, value):
        value = re.sub(r"[^A-Za-z0-9._-]+", "-", str(value)).strip("-")
        return value[:90] or "caso"

    def _as_bool(self, value):
        if isinstance(value, bool):
            return value
        return str(value).strip().lower() in {"1", "true", "yes", "si", "y"}

    def _status_color(self, status):
        return "#188038" if str(status).upper() == "PASS" else "#d93025"

    def _pdf_text(self, value):
        return str(value).encode("latin-1", errors="replace").decode("latin-1")

    def _log(self, message, level="INFO"):
        try:
            BuiltIn().log(message, level=level)
        except Exception:
            print(message)


_REPORTES = Reportes()


@keyword("Iniciar caso de prueba")
def iniciar_caso_de_prueba(nombre=None):
    return _REPORTES.iniciar_caso_de_prueba(nombre)


@keyword("Registrar evidencia")
def registrar_evidencia(descripcion="Evidencia", capturar_pantalla=True):
    return _REPORTES.registrar_evidencia(descripcion, capturar_pantalla)


@keyword("Finalizar caso de prueba")
def finalizar_caso_de_prueba(cerrar_navegador=True):
    return _REPORTES.finalizar_caso_de_prueba(cerrar_navegador)
