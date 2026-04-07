import flet as ft
import mysql.connector
# Importamos las vistas desde tus otros archivos .py
from login import vista_login
from NueCuenta import vista_registro
from bienvenido import vista_bienvenida

# --- 1. LÓGICA DE BASE DE DATOS ---
def validar_usuario(correo, contra):
    try:
        db = mysql.connector.connect(
            host="localhost", user="root", password="", database="base_suco"
        )
        cursor = db.cursor()
        # SELECT para buscar coincidencia exacta
        sql = "SELECT nombre FROM usuarios WHERE correo = %s AND password = %s"
        cursor.execute(sql, (correo, contra))
        resultado = cursor.fetchone() 
        db.close()
        return resultado # Devuelve una tupla (nombre,) o None
    except Exception as e:
        print(f"Error DB: {e}")
        return None

def registrar_usuario(nombre, correo, contra):
    try:
        db = mysql.connector.connect(
            host="localhost", user="root", password="", database="base_suco"
        )
        cursor = db.cursor()
        sql = "INSERT INTO usuarios (nombre, correo, password) VALUES (%s, %s, %s)"
        cursor.execute(sql, (nombre, correo, contra))
        db.commit()
        db.close()
        return True
    except:
        return False

# --- 2. FUNCIONES DE NAVEGACIÓN ---
def ir_a_login(page):
    page.clean()
    # PASAMOS LOS 4 ARGUMENTOS QUE PIDE TU VISTA_LOGIN
    page.add(vista_login(page, ir_a_registro, validar_usuario, ir_a_bienvenida))

def ir_a_registro(page):
    page.clean()
    page.add(vista_registro(page, ir_a_login, registrar_usuario))

def ir_a_bienvenida(page, nombre):
    page.clean()
    page.add(vista_bienvenida(page, nombre, ir_a_login))

# --- 3. CONFIGURACIÓN PRINCIPAL ---
def main(page: ft.Page):
    page.title = "Sistema UNANDES"
    page.window.width = 400
    page.window.height = 650
    page.horizontal_alignment = "center"
    page.vertical_alignment = "center"
    page.bgcolor = "white"
    
    ir_a_login(page)

if __name__ == "__main__":
    ft.run(main)