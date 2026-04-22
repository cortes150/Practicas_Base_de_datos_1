
insert into Planta_produccion (id_planta_produccion, nombre, ubicacion) values 
(1, 'Planta Norte', 'Parque Industrial Nro 1'),
(2, 'Planta Sur', 'Av. Santos Dumont'),
(3, 'Planta Este', 'Carretera a Cotoca');

insert into Distribuidor (id_distribuidor, nombre, telefono) values 
(1, 'Juan Perez', '70010101'),
(2, 'Maria Lopez', '70020202'),
(3, 'Pedro Gomez', '70030303'),
(4, 'Ana Rios', '70040404'),
(5, 'Luis Castro', '70050505');

insert into Cliente (id_cliente, nombre, telefono, tipo, ciudad) values 
(1, 'Tienda El Sol', '33445566', 'Minorista', 'Santa Cruz'),
(2, 'Supermercado Fidalga', '33221100', 'Mayorista', 'Santa Cruz'),
(3, 'Minimarket Ana', '33889977', 'Minorista', 'Montero'),
(4, 'Comercial Warnes', '39223344', 'Mayorista', 'Warnes'),
(5, 'Pulpería Don Jose', '33112233', 'Minorista', 'La Guardia');

insert into Producto (id_producto, nombre, precio, id_categoria) values 
(1, 'Soda 2L', 10.50, 1),
(2, 'Agua Mineral', 5.00, 1),
(3, 'Leche Entera', 6.50, 2),
(4, 'Yogurt Frutilla', 12.00, 2),
(5, 'Papas Fritas', 8.00, 3),
(6, 'Galletas Saladas', 3.50, 3),
(7, 'Detergente 1kg', 15.00, 4),
(8, 'Jabón Líquido', 18.00, 4),
(9, 'Avena en Hojuelas', 7.00, 5),
(10, 'Corn Flakes', 22.00, 5);

insert into Ruta (id_ruta, ciudad, id_distribuidor) values 
(1, 'Santa Cruz - Centro', 1),
(2, 'Santa Cruz - Norte', 2),
(3, 'Montero - Centro', 3),
(4, 'Warnes - Industrial', 4),
(5, 'La Guardia - Km 12', 5);

insert into Inventario (id_inventario, stock, id_producto, id_planta_produccion) values 
(1, 100, 1, 1), (2, 50, 1, 2), (3, 80, 2, 1),
(4, 200, 3, 2), (5, 150, 4, 2), (6, 300, 5, 3),
(7, 120, 6, 3), (8, 90, 7, 1), (9, 110, 8, 1),
(10, 60, 9, 2), (11, 40, 10, 3), (12, 75, 2, 2),
(13, 85, 4, 1), (14, 130, 6, 1), (15, 20, 10, 1);

insert into Pedido (id_pedido, fecha, estado, id_cliente) values 
(1, '2024-04-20', 'Entregado', 1),
(2, '2024-04-21', 'Pendiente', 2),
(3, '2024-04-21', 'En Proceso', 3),
(4, '2024-04-22', 'Pendiente', 4),
(5, '2024-04-22', 'Cancelado', 5);

insert into Detalle_Pedido (id_pedido, id_producto, id_planta_produccion, detalle, cantidad, precio_unitario) values
(1, 1, 1, 'Pedido normal', 10, 10.50),
(1, 2, 1, 'Pedido normal', 20, 5.00),
(2, 3, 2, 'Urgente', 50, 6.50),
(2, 4, 2, 'Urgente', 30, 12.00),
(3, 5, 3, 'Fragil', 15, 8.00),
(3, 6, 3, 'Fragil', 10, 3.50),
(4, 7, 1, 'Cuidado', 5, 15.00),
(4, 8, 1, 'Cuidado', 12, 18.00),
(5, 9, 2, 'Sin detalle', 20, 7.00),
(5, 10, 3, 'Sin detalle', 5, 22.00);

insert into Entrega (id_entrega, id_pedido, id_ruta, fecha, hora, estado) values 
(1, 1, 1, '2024-04-20', '10:00:00', 'Completado'),
(2, 2, 2, '2024-04-21', '14:30:00', 'En camino'),
(3, 3, 3, '2024-04-21', '09:15:00', 'Programado'),
(4, 4, 4, '2024-04-22', '11:00:00', 'Pendiente'),
(5, 5, 5, '2024-04-22', '16:45:00', 'Fallido');