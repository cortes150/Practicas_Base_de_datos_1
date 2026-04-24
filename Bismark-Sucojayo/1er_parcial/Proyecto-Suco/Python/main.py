import flet as ft
import mysql.connector
from login import vista_login
from bienvenido import vista_bienvenida
from admin_view import vista_admin
from ordenes_view import vista_lista_ordenes

# --- 1. FUNCIONES DE BASE DE DATOS (Deben estar antes de usarse) ---

def validar_usuario(correo, contra):
    if correo == "1111" and contra == "1111":
        return (0, "Administrador", "Maestro", "Administrador")
    try:
        db = mysql.connector.connect(host="localhost", user="root", password="", database="soporte_tecnico")
        cursor = db.cursor()
        sql = "SELECT id_tecnico, nombre, apellido, nivel_acceso FROM Tecnico WHERE correo_institucional = %s AND ci = %s"
        cursor.execute(sql, (correo, contra))
        resultado = cursor.fetchone() 
        db.close()
        return resultado 
    except Exception as e:
        print(f"Error Login DB: {e}")
        return None

def obtener_ordenes_db(id_tecnico=None, es_admin=False):
    try:
        db = mysql.connector.connect(host="localhost", user="root", password="", database="soporte_tecnico")
        cursor = db.cursor()
        sql = """
            SELECT o.id_orden, c.nombre, c.apellido, e.tipo_equipo, e.modelo, o.falla_reportada, o.fecha_ingreso, t.nombre
            FROM Orden_Servicio o
            JOIN Cliente c ON o.id_cliente = c.id_cliente
            JOIN Equipo e ON o.id_equipo = e.id_equipo
            JOIN Tecnico t ON o.id_tecnico = t.id_tecnico
        """
        if not es_admin:
            sql += " WHERE o.id_tecnico = %s"
            cursor.execute(sql, (id_tecnico,))
        else:
            cursor.execute(sql)
        res = cursor.fetchall()
        db.close()
        return res
    except Exception as e:
        print(f"Error al obtener órdenes: {e}")
        return []

def registrar_soporte_completo(id_tecnico, datos_cliente, datos_equipo, falla):
    try:
        db = mysql.connector.connect(host="localhost", user="root", password="", database="soporte_tecnico")
        cursor = db.cursor()
        
        # Manejo de Cliente
        cursor.execute("SELECT id_cliente FROM Cliente WHERE CI = %s", (datos_cliente['ci'],))
        res_c = cursor.fetchone()
        if res_c:
            id_c = res_c[0]
        else:
            sql_c = "INSERT INTO Cliente (nombre, apellido, CI, celular, correo_electronico) VALUES (%s, %s, %s, %s, %s)"
            cursor.execute(sql_c, (datos_cliente['nombre'], datos_cliente['apellido'], datos_cliente['ci'], datos_cliente['celular'], datos_cliente['correo']))
            id_c = cursor.lastrowid

        # Manejo de Equipo y Orden
        sql_e = "INSERT INTO Equipo (nro_serie, tipo_equipo, marca, modelo, id_cliente) VALUES (%s, %s, %s, %s, %s)"
        cursor.execute(sql_e, (datos_equipo['nro_serie'], datos_equipo['tipo'], datos_equipo['marca'], datos_equipo['modelo'], id_c))
        id_e = cursor.lastrowid

        sql_o = "INSERT INTO Orden_Servicio (id_cliente, id_equipo, id_tecnico, falla_reportada, fecha_ingreso) VALUES (%s, %s, %s, %s, NOW())"
        cursor.execute(sql_o, (id_c, id_e, id_tecnico, falla))

        db.commit()
        db.close()
        return True
    except Exception as e:
        print(f"Error: {e}")
        return False

# --- 2. NAVEGACIÓN ---

def ir_a_login(page):
    page.clean()
    page.add(vista_login(page, None, validar_usuario, ir_a_bienvenida))

def ir_a_bienvenida(page, datos_usuario):
    rol = datos_usuario[3]
    page.clean()
    if rol == "Administrador":
        # Nota: Asegúrate de tener estas funciones o pasarlas como None si no las usas aún
        page.add(vista_admin(page, datos_usuario, ir_a_login, None, None, None, ir_a_lista_ordenes))
    else:
        page.add(vista_bienvenida(page, datos_usuario, ir_a_login, registrar_soporte_completo, ir_a_lista_ordenes))

def ir_a_lista_ordenes(page, datos_usuario):
    page.clean()
    page.add(vista_lista_ordenes(page, datos_usuario, ir_a_bienvenida, obtener_ordenes_db))

def main(page: ft.Page):
    page.title = "Soporte Técnico UNANDES"
    page.window_width = 450
    page.window_height = 800
    ir_a_login(page)

if __name__ == "__main__":
    # Usamos la nueva sintaxis recomendada por el error
    ft.app(main) 
    # Si sigue saliendo el warning de 'Use run instead', cámbialo a:
    # ft.run_app(main)