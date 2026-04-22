CREATE DATABASE torneo;
use torneo;
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    precio INT ,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL UNIQUE,
    telefono INT,
    ciudad VARCHAR(100)
);
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE ,
    estado varchar(20),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);
CREATE TABLE detalle_pedido (
    id_pedido INT,
    cantidad INT ,
    precio_unitario INT ,
    detalle varchar(200),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
CREATE TABLE ruta(
	id_ruta INT auto_increment primary key,
    ciudad VARCHAR(50),
    id_distribuidor INT,
    FOREIGN KEY (id_distribuidor) REFERENCES distribuidor(id_distribuidor)
);
CREATE TABLE entrega (
	id_entrega INT auto_increment primary key,
    id_pedido INT,
    fecha date,
    hora time,
    estado varchar(30),
	FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
CREATE TABLE inventario (
    id_pedido INT,
    cantidad INT ,
    precio_unitario INT ,
    detalle varchar(200),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);