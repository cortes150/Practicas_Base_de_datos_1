CREATE TABLE Categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
);

CREATE TABLE Producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    id_categoria INT, 
	FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Planta_Produccion (
    id_planta SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(150)
);

CREATE TABLE Inventario (
    id_planta INT,
	FOREIGN KEY (id_planta) REFERENCES Planta_Produccion(id_planta),
    id_producto INT,
	FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
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
    id_distribuidor INT,
	FOREIGN KEY (id_distribuidor) REFERENCES Distribuidor(id_distribuidor)
);

CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    ciudad VARCHAR(50)
);

CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20),
    id_cliente INT REFERENCES Cliente(id_cliente),
    id_ruta INT REFERENCES Ruta(id_ruta)
);

CREATE TABLE Detalle_Pedido (
    id_pedido INT REFERENCES Pedido(id_pedido),
    id_producto INT REFERENCES Producto(id_producto),
    cantidad INT NOT NULL,
	detalle VARCHAR(100),
    PRIMARY KEY (id_pedido, id_producto)
);
CREATE TABLE Entrega(
	id_entrega SERIAL PRIMARY KEY,
	fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	estado VARCHAR(20),
	id_pedido INT,
	FOREIGN KEY (id_pedido) REFERENCES Pedido (id_pedido)
);