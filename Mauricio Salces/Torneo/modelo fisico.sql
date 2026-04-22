create database torneo;
use torneo;

create table categoria(
	id_categoria int auto_increment primary key,
    nombre_categoria varchar(50)
);

create table producto(
	id_producto int auto_increment primary key,
    nombre varchar(50),
    precio decimal (10.2),
    
    id_categoria int,  FOREIGN KEY (id_categoria) references categoria(id_categoria)
);

create table cliente(
	id_cliente int auto_increment primary key,
    nombre varchar(50),
    tipo varchar(50),
    email varchar(50),
    ciudad varchar(50)
);

create table celular_cliente(
	celular_cliente int auto_increment primary key,
    celular varchar(50),
    
	id_cliente int, FOREIGN KEY (id_cliente) references cliente(id_cliente)
);


create table distribuidor( 
id_distribuidor int auto_increment primary key,
nombre varchar (150)

);

create table ruta(
	id_ruta int auto_increment primary key,
    nombre varchar(50),
    direccion varchar(50),
    
    id_distribuidor int, FOREIGN KEY (id_distribuidor) references distribuidor(id_distribuidor)
);
create table pedido(
	id_pedido int auto_increment primary key,
    fecha date,
    hora time,
    direccion varchar(50),
    
    id_cliente int, FOREIGN KEY (id_cliente) references cliente(id_cliente),
    id_ruta int, FOREIGN KEY (id_ruta) references ruta(id_ruta)
);

create table detalle_pedido(
	id_detalle_pedido int auto_increment primary key,
    cantidad int,
    precio_unitario decimal(10.2),
    
	id_pedido int, FOREIGN KEY (id_pedido) references pedido(id_pedido),
    id_producto int, FOREIGN KEY (id_producto) references producto(id_producto)
);

create table planta_produccion ( 
id_planta int auto_increment primary key,
direccion varchar(150)
);
alter table planta_produccion add nombre varchar(50);
create table inventario( 
id_inventario int auto_increment primary key,
stock int,

id_producto int, FOREIGN KEY (id_producto) references producto(id_producto),
id_planta int, FOREIGN KEY (id_planta) references planta_produccion(id_planta)
); 


create table entrega( 
id_entrega int auto_increment primary key,
fecha date, 
hora time,
estado  varchar (150),

id_pedido int, FOREIGN KEY (id_pedido) references pedido(id_pedido)
); 

create table celular_distribuidor(
	celular_distribuidor int auto_increment primary key,
    celular varchar(50),
    
	id_distribuidor int, FOREIGN KEY (id_distribuidor) references distribuidor(id_distribuidor)
);