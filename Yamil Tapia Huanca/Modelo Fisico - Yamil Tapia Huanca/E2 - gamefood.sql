CREATE DATABASE gamefood;


CREATE TABLE cliente(
id_cliente SERIAL PRIMARY KEY,
nombre VARCHAR(50),
correo VARCHAR(50),
direccion VARCHAR(100)
);

CREATE TABLE telefono_cliente(
id_telefono SERIAL PRIMARY KEY,
numero VARCHAR(20),
id_cliente INT,
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE plato(
id_plato SERIAL PRIMARY KEY,
nombre VARCHAR(50),
precio DECIMAL(10,2),
categoria VARCHAR(50),
descripcion VARCHAR(100)
);

CREATE TABLE pedido(
id_pedido SERIAL PRIMARY KEY,
fecha DATE,
total DECIMAL(10,2),
estado VARCHAR(20),
tipo_pago VARCHAR(20),
id_cliente INT,
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- N:M
CREATE TABLE pedido_plato(
id_pp SERIAL PRIMARY KEY,
id_pedido INT,
id_plato INT,
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
FOREIGN KEY (id_plato) REFERENCES plato(id_plato)
);

CREATE TABLE pago(
id_pago SERIAL PRIMARY KEY,
monto DECIMAL(10,2),
metodo VARCHAR(30),
fecha DATE,
estado VARCHAR(20),
id_pedido INT,
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);