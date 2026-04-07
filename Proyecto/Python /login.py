import flet as ft

def vista_login(page, ir_a_registro, validar_usuario, ir_a_bienvenida):
    # Definimos los campos
    txt_user = ft.TextField(
        label="Correo",
        label_style=ft.TextStyle(
                            size=17,
                            weight=ft.FontWeight.BOLD,
                            italic=True,
                            color=ft.Colors.WHITE,
                        ),
        border="underline", 
        color= "white", 
        border_color="white"
    )
    txt_pass = ft.TextField(
        label="Contraseña",
        label_style=ft.TextStyle(
                            size=17,
                            weight=ft.FontWeight.BOLD,
                            italic=True,
                            color=ft.Colors.WHITE,
                        ), 
        password=True, 
        border="underline", 
        color="white", 
        border_color="white"
    )

    def acceder(e):
        # Llamamos a la función que está en el main
        nombre_usuario = validar_usuario(txt_user.value, txt_pass.value)
        if nombre_usuario:
            # nombre_usuario[0] porque fetchone devuelve una tupla
            ir_a_bienvenida(page, nombre_usuario[0])
        else:
            page.snack_bar = ft.SnackBar(ft.Text("Correo o contraseña incorrectos"))
            page.snack_bar.open = True
            page.update()

    return ft.Container(
        content=ft.Column([
            ft.Text("INICIAR SESIÓN", size=30, weight="bold", color="white", text_align="center", width=320),
            txt_user,
            txt_pass,
            ft.Button("ENTRAR", on_click=acceder, width=280, bgcolor="black", color="white"),
            
            # --- Aquí agregamos el botón que te faltaba ---


            ft.Row([
    ft.Text("¿No tienes cuenta?", color="white"),
    ft.TextButton(
        "Crear cuenta",
        # Aplicamos el estilo aquí
        style=ft.ButtonStyle(
            color={
                ft.ControlState.HOVERED: ft.Colors.BLUE_400,  # Color al pasar el mouse
                ft.ControlState.DEFAULT: ft.Colors.WHITE,    # Color normal
            },
            # Puedes agregar un ligero color de fondo al pasar el mouse si quieres
            overlay_color={
                ft.ControlState.HOVERED: ft.Colors.WHITE10,
            },
            # Animación suave para el cambio
            animation_duration=300,
        ),
        on_click=lambda _: ir_a_registro(page)
    )
], alignment=ft.MainAxisAlignment.CENTER)




        ], 
        alignment=ft.MainAxisAlignment.SPACE_EVENLY, 
        horizontal_alignment=ft.CrossAxisAlignment.CENTER
        ),
        width=320, 
        height=500, 
        border_radius=20, 
        padding=20,
        gradient=ft.LinearGradient([ft.Colors.BLUE_900, ft.Colors.PURPLE])
    )