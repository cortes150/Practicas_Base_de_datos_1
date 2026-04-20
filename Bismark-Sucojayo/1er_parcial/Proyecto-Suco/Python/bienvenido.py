import flet as ft

def vista_bienvenida(page, usuario_nombre, ir_a_login):
    return ft.Container(
        content=ft.Column([
            ft.Icon(ft.Icons.CHECK_CIRCLE, color="green", size=80),
            ft.Text(f"¡Bienvenido, {usuario_nombre}!", size=30, weight="bold", color="white"),
            ft.Text("Has ingresado al sistema UNANDES con éxito.", color="white70"),
            ft.Button("CERRAR SESIÓN", on_click=lambda _: ir_a_login(page), bgcolor="red", color="white")
        ], alignment="center", horizontal_alignment="center"),
        width=400, height=300, border_radius=20, padding=20, bgcolor=ft.Colors.BLUE_GREY_900
    )