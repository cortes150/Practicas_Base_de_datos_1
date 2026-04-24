import flet as ft

def vista_admin(page, datos_usuario, ir_a_login, reg_func, del_func, get_func, ir_a_lista_ordenes):
    txt_nom = ft.TextField(label="Nombre", expand=True)
    txt_ape = ft.TextField(label="Apellidos", expand=True)
    txt_ci = ft.TextField(label="CI (Contraseña)", expand=True)
    txt_cor = ft.TextField(label="Correo Institucional", expand=True)
    lista_tecnicos = ft.Column(scroll=ft.ScrollMode.AUTO, height=300)

    def actualizar_lista():
        lista_tecnicos.controls.clear()
        for t in get_func():
            lista_tecnicos.controls.append(
                ft.ListTile(
                    title=ft.Text(f"{t[1]} {t[2]}"),
                    subtitle=ft.Text(f"Acceso: {t[3]}"),
                    trailing=ft.IconButton(ft.Icons.DELETE, icon_color="red", on_click=lambda e, id=t[0]: borrar(id))
                )
            )
        page.update()

    def borrar(id):
        if del_func(id): actualizar_lista()

    def guardar(e):
        if reg_func(txt_nom.value, txt_ape.value, txt_ci.value, "Sistemas", "000", txt_cor.value):
            actualizar_lista()
            txt_nom.value = ""; txt_ape.value = ""; txt_ci.value = ""; txt_cor.value = ""
            page.update()

    actualizar_lista()

    return ft.Container(
        content=ft.Column([
            ft.Row([
                ft.Text("ADMINISTRACIÓN", size=20, weight="bold"),
                ft.IconButton(ft.Icons.LOGOUT, on_click=lambda _: ir_a_login(page))
            ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
            ft.ElevatedButton("VER TODAS LAS ÓRDENES", icon=ft.Icons.LIST_ALT, on_click=lambda _: ir_a_lista_ordenes(page, datos_usuario)),
            ft.Divider(),
            ft.Row([txt_nom, txt_ape]),
            ft.Row([txt_ci, txt_cor]),
            ft.ElevatedButton("REGISTRAR TÉCNICO", on_click=guardar, width=400),
            ft.Text("PERSONAL REGISTRADO", weight="bold"),
            lista_tecnicos
        ]), padding=20, expand=True
    )