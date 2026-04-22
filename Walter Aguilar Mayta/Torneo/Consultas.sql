

-- en la tabla categoria 5 datos, productos 10 datos, platan 3 datos, inventario 15 datos, ruta 5, cliente 5, pedido 5, detallede_pedido 10 datos, entrega 5 datos
use sistemadistribucion;
insert into categoria(tipo)values("refrescos"),("bebidas"),("jugos"),("zumos"),("energeticos");

insert into producto(nombre,precio,id_categoria)values("Pilfrut", 12,3),("yogurt", 15,2),("zumo", 20,4),("coca cola", 18,1),("monster", 25,5);

insert into Distribuidor (id_distribuidor, nombre, telefono) values 
(1, 'Juan Perez', '70010101'),
(2, 'Maria Lopez', '70020202'),
(3, 'Pedro Gomez', '70030303'),
(4, 'Ana Rios', '70040404'),
(5, 'Luis Castro', '70050505');

insert Cliente (id_cliente, nombre, telefono, tipo, ciudad) values
(1, 'Tienda El Sol', '33445566', 'Minorista', 'Santa Cruz'),
(2, 'Supermercado Fidalga', '33221100', 'Mayorista', 'Santa Cruz'),
(3, 'Minimarket Ana', '33889977', 'Minorista', 'Montero'),
(4, 'Comercial Warnes', '39223344', 'Mayorista', 'Warnes'),
(5, 'Pulpería Don Jose', '33112233', 'Minorista', 'La Guardia');