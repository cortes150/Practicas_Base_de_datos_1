CREATE DATABASE GameFood;
GO

USE GameFood;
GO

CREATE TABLE Mesa(
	id_mesa int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	capacidad int,
	numero_mesa int,
	estado varchar(50)
);
GO

CREATE TABLE Cliente(
	id_Cliente int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre varchar(100),
	A_P varchar(50),
	A_M varchar(50)
);
GO

CREATE TABLE Plato(
	id_plato int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	precio decimal(10,2),
	descripcion varchar(200),
	categoria varchar(100)
);
GO

CREATE TABLE Pedido(
	id_pedido int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	id_cliente int, CONSTRAINT fk_P_Cliente FOREIGN KEY(id_cliente) REFERENCES Cliente(id_Cliente),
	id_mesa int, CONSTRAINT fk_P_Mesa FOREIGN KEY(id_mesa) REFERENCES Mesa(id_mesa),
	Fecha_Hora datetime2,
	estado varchar(50)
);
GO

CREATE TABLE pedido_plato(
	id_pedido_plato int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	id_pedido int, CONSTRAINT fk_PP_Pedido FOREIGN KEY(id_pedido) REFERENCES Pedido(id_pedido),
	id_plato int, CONSTRAINT fk_PP_Plato FOREIGN KEY(id_plato) REFERENCES Plato(id_plato),
	cantidad_plato int
);
GO

CREATE TABLE Pago(
	id_pago int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	id_pedido int, CONSTRAINT fk_Pg_Ped FOREIGN KEY(id_pedido) REFERENCES Pedido(id_pedido),
	monto decimal(10,2),
	forma_pago varchar(50),
	Fecha_Hora datetime2
);
GO
