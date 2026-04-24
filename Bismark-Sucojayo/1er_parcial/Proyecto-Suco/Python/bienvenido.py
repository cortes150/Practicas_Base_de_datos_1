import flet as ft

def vista_bienvenida(page, datos_usuario, ir_a_login, registrar_soporte_completo, ir_a_lista_ordenes):
    id_tecnico = datos_usuario[0]
    nombre_tecnico = datos_usuario[1]

    # --- CAMPOS DEL FORMULARIO ---
    txt_nombre_cli = ft.TextField(label="Nombre del Cliente", prefix_icon=ft.Icons.PERSON)
    txt_apellido_cli = ft.TextField(label="Apellido del Cliente")
    txt_ci_cli = ft.TextField(label="C.I. Cliente", keyboard_type=ft.KeyboardType.NUMBER)
    txt_cel_cli = ft.TextField(label="Celular", keyboard_type=ft.KeyboardType.PHONE)
    txt_correo_cli = ft.TextField(label="Correo Electrónico")

    txt_nro_serie = ft.TextField(label="Número de Serie", prefix_icon=ft.Icons.SETTINGS)
    dd_tipo_equipo = ft.Dropdown(
        label="Tipo de Equipo",
        options=[
            ft.dropdown.Option("Laptop"),
            ft.dropdown.Option("Desktop"),
            ft.dropdown.Option("Impresora"),
        ]
    )
    txt_marca = ft.TextField(label="Marca")
    txt_modelo = ft.TextField(label="Modelo")
    txt_falla = ft.TextField(label="Falla Reportada", multiline=True, min_lines=3)

    # --- FUNCIÓN GUARDAR ---
    def guardar_orden(e):
        datos_cliente = {
            'nombre': txt_nombre_cli.value,
            'apellido': txt_apellido_cli.value,
            'ci': txt_ci_cli.value,
            'celular': txt_cel_cli.value,
            'correo': txt_correo_cli.value
        }

        datos_equipo = {
            'nro_serie': txt_nro_serie.value,
            'tipo': dd_tipo_equipo.value,
            'marca': txt_marca.value,
            'modelo': txt_modelo.value
        }

        if registrar_soporte_completo(id_tecnico, datos_cliente, datos_equipo, txt_falla.value):
            page.snack_bar = ft.SnackBar(ft.Text("✅ Registro guardado"), bgcolor=ft.Colors.GREEN)
            for field in [txt_nombre_cli, txt_apellido_cli, txt_ci_cli, txt_cel_cli, txt_correo_cli, txt_nro_serie, txt_marca, txt_modelo, txt_falla]:
                field.value = ""
            dd_tipo_equipo.value = None
            txt_nombre_cli.focus()
        else:
            page.snack_bar = ft.SnackBar(ft.Text("❌ Error al guardar"), bgcolor=ft.Colors.RED)

        page.snack_bar.open = True
        page.update()

    # --- CONTENIDOS ---
    contenedor_registro = ft.Column(
        [
            ft.Text("DATOS DEL CLIENTE", color=ft.Colors.BLUE, weight="bold"),
            txt_nombre_cli, txt_apellido_cli, txt_ci_cli, txt_cel_cli, txt_correo_cli,
            ft.Divider(),
            ft.Text("DATOS DEL EQUIPO", color=ft.Colors.GREEN, weight="bold"),
            txt_nro_serie, dd_tipo_equipo, txt_marca, txt_modelo, txt_falla,
            ft.ElevatedButton("GUARDAR ORDEN", on_click=guardar_orden, width=400)
        ],
        scroll=ft.ScrollMode.AUTO
    )

    contenedor_listado = ft.Column(
        [
            ft.ElevatedButton(
                "VER MIS ÓRDENES",
                icon=ft.Icons.LIST_ALT,
                on_click=lambda _: ir_a_lista_ordenes(page, datos_usuario)
            )
        ],
        alignment=ft.MainAxisAlignment.CENTER,
        horizontal_alignment=ft.CrossAxisAlignment.CENTER
    )

    cuerpo_dinamico = ft.Container(content=contenedor_registro, expand=True)

    def cambiar_tab(e):
        # selected_index identifica la pestaña pulsada
        cuerpo_dinamico.content = contenedor_registro if e.control.selected_index == 0 else contenedor_listado
        page.update()

    # --- TABS (USANDO CONTROLS Y LABEL) ---
    mis_tabs = ft.Tabs(
        selected_index=0,
        on_change=cambiar_tab,
        controls=[
            ft.Tab(label="REGISTRO", icon=ft.Icons.EDIT),
            ft.Tab(label="LISTADO", icon=ft.Icons.LIST),
        ]
    )

    return ft.Container(
        content=ft.Column(
            [
                ft.Row(
                    [
                        ft.Text(f"Bienvenido: {nombre_tecnico}", size=20, weight="bold"),
                        ft.IconButton(
                            icon=ft.Icons.LOGOUT,
                            on_click=lambda _: ir_a_login(page),
                            icon_color=ft.Colors.RED
                        )
                    ],
                    alignment=ft.MainAxisAlignment.SPACE_BETWEEN
                ),
                mis_tabs,
                cuerpo_dinamico
            ]
        ),
        padding=20,
        expand=True
    )