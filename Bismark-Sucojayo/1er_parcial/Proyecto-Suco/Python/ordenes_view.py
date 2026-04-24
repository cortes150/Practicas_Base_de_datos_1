import flet as ft

def vista_lista_ordenes(page, datos_usuario, ir_a_bienvenida, get_ordenes_func):
    id_usuario = datos_usuario[0]
    # Cambiamos al índice 3 para obtener el Rol correctamente
    rol_usuario = datos_usuario[3] 
    es_admin = True if rol_usuario == "Administrador" else False

    tabla = ft.DataTable(
        columns=[
            ft.DataColumn(ft.Text("Nro")),
            ft.DataColumn(ft.Text("Cliente")),
            ft.DataColumn(ft.Text("Equipo")),
            ft.DataColumn(ft.Text("Técnico")), # Nueva columna para el Admin
            ft.DataColumn(ft.Text("Fecha")),
        ],
        rows=[]
    )

    def cargar_tabla():
        # Llamamos a la función con el flag de admin corregido
        ordenes = get_ordenes_func(id_usuario, es_admin)
        tabla.rows.clear()
        for o in ordenes:
            tabla.rows.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(str(o[0]))), # ID
                        ft.DataCell(ft.Text(f"{o[1]} {o[2]}")), # Cliente
                        ft.DataCell(ft.Text(f"{o[3]} {o[4]}")), # Equipo
                        ft.DataCell(ft.Text(o[7])), # Nombre del Técnico (o[7] por el nuevo JOIN)
                        ft.DataCell(ft.Text(str(o[6]))), # Fecha
                    ]
                )
            )
        page.update()

    cargar_tabla()

    return ft.Container(
        content=ft.Column([
            ft.Row([
                ft.Text("CONTROL GLOBAL DE ÓRDENES" if es_admin else "MIS ÓRDENES ASIGNADAS", 
                        size=20, weight="bold", color="blue" if es_admin else "white"),
                ft.IconButton(ft.Icons.ARROW_BACK, on_click=lambda _: ir_a_bienvenida(page, datos_usuario))
            ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
            ft.Divider(),
            ft.Column([tabla], scroll=ft.ScrollMode.AUTO, expand=True)
        ]),
        padding=20,
        expand=True,
        bgcolor=ft.Colors.BLUE_GREY_900 if es_admin else ft.Colors.BLACK
    )