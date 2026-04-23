-- entrada de datos
-- tabla categoria llenar 5 datos
insert into categoria(nombre_categoria) values
('gaseosa'),
('bebida energizante'),
('zero'),
('jugos'),
('lite');
-- tabla producto llenar 10 datos
insert into producto(nombre,precio,id_categoria) values
('coca cola',12.50,1),
('fanta',10.50,1),
('redbull',8,2),
('monster',12.50,2),
('coca zero',12.50,3),
('fanta zero',12.50,3),
('tampico',12.50,4),
('mandalife',12.50,4),
('coca lite',18.50,5),
('fanta lite',20.00,5);

-- planta 3 datos
insert into planta_produccion (direccion, nombre)values
('Zona Sur', 'Planta A'),
('El Alto', 'Planta B'),
('Miraflores', 'Planta AC');
-- tabla inventario 15 
insert into inventario (stock, id_producto, id_planta)values
(14, 1, 1),
(15, 2, 2),
(16, 3, 3),
(17, 4, 1),
(20, 5, 2),
(5, 6, 3),
(2, 7, 1),
(7, 8, 2),
(4, 9, 3),
(54, 10, 1),
(24, 1, 2),
(37, 2, 3),
(9, 3, 1),
(10, 4, 2),
(12, 5, 3);
INSERT into ruta (direccion,id_distribuidor,nombre)
VALUES ('villa fatima',1,'la paz'),
('villa victoria',2,'la paz'),
('el prado',1,'oruro'),
('conzata',2,'cochabamba'),
('av buch',1,'beni'),
('villa pabon',2,'santacruz');

INSERT INTO cliente (ciudad,email,nombre,tipo) VALUES('la paz','juan@gmail.com','juan','supermercado'),
('la paz','juan@gmail.com','juan','supermercado'),
('oruro','vero@mail.com','vero','supermercado'),
('beni','maria@gmail.com','maria','supermercado'),
('pando','carlos@gmail.com','carlos','supermercado');

insert into entrega (fecha,hora,estado,id_pedido)values 
('2026-04-03','12:30','entregado',2),
('2026-01-02','14:30','cancelado',3),
('2025-07-05','21:00','entregado',1),
('2026-06-09','16:00','pendiente',5),
('2025-08-07','07:00','cancelado',3); 

-- cusi 
insert into detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 5.2),
(2, 1, 3, 10.1),
(3, 2, 2, 4.2),
(4, 1, 5, 6.4),
(5, 1, 4, 3.9),
(6, 1, 6, 2.6),
(7, 1, 7, 10.7),
(8, 4, 8, 2.9),
(9, 1, 9, 3.4),
(10, 5, 10, 2.7);


INSERT INTO pedido (fecha, hora,direccion, id_cliente, id_ruta) VALUES
('2026-04-01', '08:00', 'Av. La Paz', 3,5),
('2026-04-02', '18:00', 'Av. Camacho', 1,2),
('2026-04-03', '15:00', 'El Prado', 2,3),
('2026-04-06', '13:00', 'Zona El Alto', 4,2),
('2026-04-04', '11:00', 'Zona Los Molinos', 1,5);