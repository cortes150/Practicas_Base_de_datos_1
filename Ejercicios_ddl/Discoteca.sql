SCRIPT COMPLETO – DISCOTECA (DDL)
BASE DE DATOS
CREATE DATABASE discoteca_db;
USE discoteca_db;
TABLA CLIENTE
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT
);

ALTER TABLE cliente
ADD correo VARCHAR(100) UNIQUE;

ALTER TABLE cliente
MODIFY edad INT NOT NULL;

ALTER TABLE cliente
DROP COLUMN correo;
TABLA EVENTO
CREATE TABLE evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_evento VARCHAR(100),
    fecha DATE,
    precio_entrada FLOAT
);

ALTER TABLE evento
CHANGE nombre_evento nombre VARCHAR(100);

ALTER TABLE evento
MODIFY precio_entrada DECIMAL(10,2);
TABLA ENTRADA
CREATE TABLE entrada (
    id_entrada INT AUTO_INCREMENT PRIMARY KEY,
    fecha_compra DATE
);

ALTER TABLE entrada
ADD id_cliente INT,
ADD CONSTRAINT fk_entrada_cliente
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

ALTER TABLE entrada
ADD id_evento INT,
ADD CONSTRAINT fk_entrada_evento
FOREIGN KEY (id_evento) REFERENCES evento(id_evento);
TABLA DJ
CREATE TABLE dj (
    id_dj INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    genero_musical VARCHAR(50)
);

ALTER TABLE dj
ADD CONSTRAINT unique_nombre_dj UNIQUE (nombre);
TABLA INTERMEDIA EVENTO_DJ
CREATE TABLE evento_dj (
    id_evento INT,
    id_dj INT
);

ALTER TABLE evento_dj
ADD PRIMARY KEY (id_evento, id_dj);

ALTER TABLE evento_dj
ADD CONSTRAINT fk_evento_dj_evento
FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
ADD CONSTRAINT fk_evento_dj_dj
FOREIGN KEY (id_dj) REFERENCES dj(id_dj);
TABLA EMPLEADO
CREATE TABLE empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(50)
);

ALTER TABLE empleado
ADD telefono VARCHAR(20);

ALTER TABLE empleado
MODIFY cargo VARCHAR(100);

ALTER TABLE empleado
DROP COLUMN telefono;

ALTER TABLE empleado
MODIFY nombre VARCHAR(50) NOT NULL;
TABLA MESA
CREATE TABLE mesa (
    id_mesa INT AUTO_INCREMENT PRIMARY KEY,
    numero_mesa INT,
    capacidad INT
);

ALTER TABLE mesa
ADD CONSTRAINT unique_numero_mesa UNIQUE (numero_mesa);

ALTER TABLE mesa
DROP COLUMN capacidad;
TABLA RESERVA
CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    hora TIME
);

ALTER TABLE reserva
ADD id_cliente INT,
ADD CONSTRAINT fk_reserva_cliente
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

ALTER TABLE reserva
ADD id_mesa INT,
ADD CONSTRAINT fk_reserva_mesa
FOREIGN KEY (id_mesa) REFERENCES mesa(id_mesa);
TABLA BEBIDA / PRODUCTO
CREATE TABLE bebida (
    id_bebida INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio FLOAT
);

ALTER TABLE bebida
MODIFY precio DECIMAL(8,2);

RENAME TABLE bebida TO producto;
TABLA PEDIDO
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE
);
TABLA INTERMEDIA PEDIDO_BEBIDA
CREATE TABLE pedido_bebida (
    id_pedido INT,
    id_bebida INT
);

ALTER TABLE pedido_bebida
ADD PRIMARY KEY (id_pedido, id_bebida);

ALTER TABLE pedido_bebida
ADD CONSTRAINT fk_pb_pedido
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
ADD CONSTRAINT fk_pb_bebida
FOREIGN KEY (id_bebida) REFERENCES producto(id_bebida);

ALTER TABLE pedido_bebida
ADD cantidad INT;

DROP TABLE pedido_bebida;
OPERACIONES FINALES
ALTER TABLE entrada
DROP FOREIGN KEY fk_entrada_cliente;

TRUNCATE TABLE evento;

DROP DATABASE discoteca_db;