CREATE TABLE Categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    id_categoria INT REFERENCES Categoria(id_categoria)
);

CREATE TABLE Planta_Produccion (
    id_planta SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(150)
);

CREATE TABLE Inventario (
    id_planta INT REFERENCES Planta_Produccion(id_planta),
    id_producto INT REFERENCES Producto(id_producto),
    stock INT DEFAULT 0,
    PRIMARY KEY (id_planta, id_producto)
);

CREATE TABLE Distribuidor (
    id_distribuidor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    vehiculo VARCHAR(50)
);

CREATE TABLE Ruta (
    id_ruta SERIAL PRIMARY KEY,
    nombre_zona VARCHAR(100) NOT NULL,
    id_distribuidor INT REFERENCES Distribuidor(id_distribuidor)
);

-- 7. Cliente
CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion TEXT,
    ciudad VARCHAR(50)
);
CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) CHECK (estado IN ('pendiente', 'entregado', 'cancelado')),
    id_cliente INT REFERENCES Cliente(id_cliente),
    id_ruta INT REFERENCES Ruta(id_ruta)
);

CREATE TABLE Detalle_Pedido (
    id_pedido INT REFERENCES Pedido(id_pedido),
    id_producto INT REFERENCES Producto(id_producto),
    cantidad INT NOT NULL,
    PRIMARY KEY (id_pedido, id_producto)
);
CREATE TABLE Entrega (
    id_entrega SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES Pedido(id_pedido),
    fecha_entrega TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(100)
);

INSERT INTO Categoria (nombre) VALUES 
('Gaseosas'), ('Aguas'), ('Jugos'), ('Isotónicos'), ('Energizantes');

INSERT INTO Producto (nombre, precio, id_categoria) VALUES 
('Coca-Cola Original 500ml', 1.50, 1),
('Coca-Cola Sin Azúcar 1L', 2.00, 1),
('Fanta Naranja 500ml', 1.20, 1),
('Sprite Lima-Limón 1.5L', 2.50, 1),
('Agua Kin Gasificada 500ml', 1.00, 2),
('Jugo Del Valle Naranja 250ml', 0.80, 3),
('Powerade Blue 600ml', 1.80, 4),
('Monster Energy 473ml', 3.00, 5),
('Fuze Tea Limón 500ml', 1.30, 3),
('Aquarius Pera 1.5L', 2.20, 2);

INSERT INTO Planta_Produccion (nombre, ubicacion) VALUES 
('Planta Central - CDMX', 'Av. Insurgentes 500'),
('Planta Norte - Monterrey', 'Parque Industrial 12'),
('Planta Sur - Mérida', 'Calle 60 por 35');

INSERT INTO Inventario (id_planta, id_producto, stock) VALUES 
(1, 1, 1000), (1, 2, 800), (1, 3, 500), (1, 4, 400), (1, 5, 900),
(2, 1, 1200), (2, 6, 300), (2, 7, 450), (2, 8, 200), (2, 2, 700),
(3, 3, 600), (3, 5, 1000), (3, 9, 350), (3, 10, 500), (3, 4, 300);

INSERT INTO Distribuidor (nombre, vehiculo) VALUES 
('Juan Pérez', 'Camión T-01'), ('Ana Gómez', 'Furgón F-22'), 
('Luis Rivas', 'Camión T-05'), ('Marta Solís', 'Camión T-09'), 
('Pedro Sosa', 'Furgón F-15');

INSERT INTO Ruta (nombre_zona, id_distribuidor) VALUES 
('Zona Norte Centro', 1), ('Sector Playas', 2), 
('Barrios Altos', 3), ('Zona Industrial', 4), ('Centro Histórico', 5);

INSERT INTO Cliente (nombre, direccion, ciudad) VALUES 
('Abarrotes Doña Mari', 'Calle Luna 10', 'CDMX'),
('Supermercado Express', 'Av. Sol 45', 'Monterrey'),
('Restaurante El Sabor', 'Calle 50 #12', 'Mérida'),
('Gimnasio FitLife', 'Blvd. Kukulcán 5', 'Cancún'),
('Tienda La Esquina', 'Av. Reforma 88', 'CDMX');

INSERT INTO Pedido (estado, id_cliente, id_ruta) VALUES 
('entregado', 1, 1), ('pendiente', 2, 2), 
('entregado', 3, 3), ('pendiente', 4, 4), 
('entregado', 5, 5);

INSERT INTO Detalle_Pedido (id_pedido, id_producto, cantidad) VALUES 
(1, 1, 10), (1, 3, 5), 
(2, 2, 20), (2, 4, 10),
(3, 5, 50), (3, 9, 15),
(4, 7, 30), (4, 8, 12),
(5, 1, 100), (5, 10, 20);

INSERT INTO Entrega (id_pedido, estado) VALUES 
(1, 'Entregado'), (3, 'Entregado'), 
(5, 'Entregado'), (2, 'Pendiente'), 
(4, 'Pendiente');