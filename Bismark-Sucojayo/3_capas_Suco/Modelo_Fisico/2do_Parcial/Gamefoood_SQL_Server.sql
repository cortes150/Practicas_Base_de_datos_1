USE master; -- Nos movemos a la maestra para no estar "pisando" la que queremos borrar
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'gamefood')
BEGIN
    -- El comando SINGLE_USER con ROLLBACK IMMEDIATE cierra todas las conexiones abiertas
    ALTER DATABASE gamefood SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE gamefood;
END
GO

create database gamefood;
go

use gamefood;
go

create table cliente(
id_cliente int identity (1,1) primary key,
nombre nvarchar(50),
Apellido_paterno nvarchar(50),
Apellido_materno nvarchar(50)
);
go

create table pedido(
id_pedido int identity (1,1) primary key,
fecha date,
id_cliente int,
foreign key(id_cliente) references cliente(id_cliente)
);
go

create table plato(
id_plato int identity (1,1) primary key,
cantidad int,
nombre nvarchar(50)
);
go

create table pedido_plato(
id_pedido_plato int identity (1,1) primary key,
id_pedido int,
id_plato int,
foreign key(id_pedido) references pedido(id_pedido),
foreign key(id_plato) references plato(id_plato)
);
go

create table pago(
id_pago int identity (1,1) primary key,
monto int,
tipo_pago nvarchar(50),
id_pedido int,
foreign key (id_pedido) references pedido(id_pedido)
);
go