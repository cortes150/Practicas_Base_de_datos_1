import flet as ft

def vista_login(page, ir_a_registro, validar_usuario, ir_a_bienvenida):
    # --- CAMPOS DE ENTRADA ---
    txt_user = ft.TextField(
        label="Correo Institucional",
        hint_text="ejemplo@gmail.com",
        label_style=ft.TextStyle(color=ft.Colors.WHITE, italic=True),
        border="underline", 
        color="white", 
        border_color="white",
        width=300
    )
    
    txt_pass = ft.TextField(
        label="Contraseña (CI)",
        label_style=ft.TextStyle(color=ft.Colors.WHITE, italic=True),
        password=True, 
        can_reveal_password=True, 
        border="underline", 
        color="white", 
        border_color="white",
        width=300
    )

    def acceder(e):
        datos_usuario = validar_usuario(txt_user.value, txt_pass.value)
        
        if datos_usuario:
            ir_a_bienvenida(page, datos_usuario)
        else:
            page.snack_bar = ft.SnackBar(
                content=ft.Text("Credenciales incorrectas. Contacte al Administrador."),
                bgcolor=ft.Colors.RED_700
            )
            page.snack_bar.open = True
            page.update()

    # --- DISEÑO DE LA INTERFAZ ---
    return ft.Container(
        content=ft.Column([
            ft.Icon(ft.Icons.LOCK_PERSON_ROUNDED, size=80, color="white"),
            
            ft.Text(
                "SISTEMA DE SOPORTE", 
                size=28, 
                weight="bold", 
                color="white", 
                text_align="center"
            ),
            
            ft.Text(
                "Ingrese sus credenciales para continuar", 
                size=14, 
                color="white70"
            ),
            
            ft.Container(height=10), 
            
            txt_user,
            txt_pass,
            
            ft.Container(height=20), 
            
            ft.ElevatedButton(
                "INICIAR SESIÓN", 
                on_click=acceder, 
                width=300, 
                height=50,
                style=ft.ButtonStyle(
                    bgcolor=ft.Colors.WHITE,
                    color=ft.Colors.BLUE_900,
                    shape=ft.RoundedRectangleBorder(radius=10),
                )
            ),
            
            ft.Text(
                "Acceso restringido a personal autorizado", 
                size=12, 
                color="white54",
                italic=True
            ),

        ], 
        alignment=ft.MainAxisAlignment.CENTER, 
        horizontal_alignment=ft.CrossAxisAlignment.CENTER,
        spacing=15
        ),
        width=400, 
        height=650, 
        border_radius=20, 
        padding=40,
        # SOLUCIÓN AL ERROR DE ALIGNMENT:
        # Usamos ft.Alignment(x, y) donde x=0 es centro e y=-1 es arriba
        gradient=ft.LinearGradient(
            begin=ft.Alignment(0, -1), # Equivalente a top_center
            end=ft.Alignment(0, 1),    # Equivalente a bottom_center
            colors=["#0d47a1", "#1a237e"]
        )
    )