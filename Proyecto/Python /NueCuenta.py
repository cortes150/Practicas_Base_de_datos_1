import flet as ft

def vista_registro(page, ir_a_login, registrar_usuario):
    # Campos de texto
    reg_nombre = ft.TextField(label="Nombre Completo", border_color="white", color="white")
    reg_correo = ft.TextField(label="Correo Electrónico", border_color="white", color="white")
    reg_contra = ft.TextField(label="Contraseña", password=True, border_color="white", color="white")

    def btn_registrar_click(e):
        if not reg_nombre.value or not reg_correo.value or not reg_contra.value:
            page.snack_bar = ft.SnackBar(ft.Text("Por favor, llena todos los campos"))
            page.snack_bar.open = True
            page.update()
            return

        if registrar_usuario(reg_nombre.value, reg_correo.value, reg_contra.value):
            page.snack_bar = ft.SnackBar(ft.Text("¡Usuario registrado con éxito!"))
            page.snack_bar.open = True
            page.update()
            ir_a_login(page) 
        else:
            page.snack_bar = ft.SnackBar(ft.Text("Error al registrar. ¿El correo ya existe?"))
            page.snack_bar.open = True
            page.update()

    return ft.Container(
        content=ft.Column([
            ft.Text("CREAR CUENTA", size=30, weight="bold", color="white", text_align="center", width=320),
            reg_nombre,
            reg_correo,
            reg_contra,
            ft.Button("REGISTRAR EN LARAGON", on_click=btn_registrar_click, width=280, bgcolor="white", color="blue"),
            ft.TextButton("Volver al Login", on_click=lambda _: ir_a_login(page))
        ], alignment="center", horizontal_alignment="center"),
        width=320, height=500, border_radius=20, padding=20,
        gradient=ft.LinearGradient([ft.Colors.PURPLE, ft.Colors.RED_700])
    )