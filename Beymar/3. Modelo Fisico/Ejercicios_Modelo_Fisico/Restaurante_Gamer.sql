create database Restaurante_Gamer;
use Restaurante_Gamer;

create table Cliente (
id_cliente int primary key identity(1,1),
nombre varchar(50) not null,
apellido_paterno varchar(50) not null,
apellido_materno varchar(50) not null
);

create table Pedido (
id_pedido int primary key identity(1,1),
fecha datetime not null,
id_cliente int, foreign key (id_cliente) references Cliente (id_cliente)
);

create table Plato (
id_plato int primary key identity (1,1),
nombre_plato varchar(50) not null,
precio decimal (10,2) not null
);

create table Pedido_Plato (
id_pedido_plato int primary key identity (1,1),
cantidad int not null,
id_pedido int, foreign key (id_pedido) references Pedido (id_pedido),
id_plato int, foreign key (id_plato) references Plato (id_plato)
);

create table Pago (
id_pago int primary key identity (1,1),
forma_pago varchar (50) not null,
monto_total decimal (10,2) not null,
id_pedido int, foreign key (id_pedido) references Pedido (id_pedido) 
);
