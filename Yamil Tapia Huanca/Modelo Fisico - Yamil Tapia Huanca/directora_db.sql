create database directora_db;
use directora_db;

create table cliente(
	id_cliente int auto_increment primary key,
    nombre varchar(100),
    edad int
);

ALTER TABLE cliente
ADD Email varchar(255) unique;

ALTER TABLE cliente
modify edad int not null;

ALTER TABLE cliente
drop correo ;

create table evento(	
	id_evento int primary key,
	nombre_evento varchar(50),
    fecha date,
    precio_entrada decimal
);

create table entrada(
	id_entrada int auto_increment primary key,
    fecha_compra date
);

alter table entrada add  column id_cliente int;
alter table entrada add constraint fk_entrada_cliente
FOREIGN KEY (id_cliente) references cliente(id_cliente);

alter table entrada add  column id_evento int;
alter table entrada add constraint fk_entrada_evento
FOREIGN KEY (id_evento) references evento(id_evento);


alter table evento rename column
nombre_evento  to nombre ;

alter table evento modify column
precio_entrada decimal(10,2);

create table dj (  
id_dj int auto_increment primary key,
nombre varchar(100),
genero_musical varchar(50)
); 
##14
create table evento_dj (
    id_evento int ,
    id_dj int ,
    foreign key (id_evento) references evento(id_evento),
    foreign key (id_dj) references dj(id_dj)
);

alter table evento_dj 
add primary key (id_evento, id_dj);



insert into dj(nombre,genero_musical)values
('dj Alex', 'Electronica'), 
('dj Maria', 'Reggaeton'), 
('dj Luis', 'House'), 
('dj Carla', 'Techno'), 
('dj Pedro', 'Salsa');

insert into evento (id_evento, nombre,fecha,precio_entrada)values
(1,'Fiesta Electronica', '2026-05-01', 50.00),
(2,'Noche Latina', '2026-05-03', 40.00), 
(3,'Festival Techno', '2026-05-10', 60.00), 
(4,'Retro Party', '2026-05-15', 35.00), 
(5,'Summer Night', '2026-05-020', 45.00);

###para insertar datos
insert into evento_dj values(1,2);
insert into evento_dj values(1,3);
insert into evento_dj values(2,2); 
insert into evento_dj values(1,2);






create table empleado ( 
id_empleado int auto_increment primary key,
nombre varchar(100),
cargo varchar(50) 
); 
 
ALTER TABLE empleado
ADD column  telefono varchar(20); 

 Alter table empleado  
 modify column cargo varchar(100); 
 
ALTER TABLE empleado
drop column telefono ; 

 
alter table empleado 
modify column nombre varchar (100) not null;

create table mesa ( 
id_mesa int auto_increment primary key,
numero_mesa int,
capacidad int
); 

alter table mesa
 add constraint unique_numero_mesa unique (numero_mesa);

create table reserva (
id_reserva int primary key,
fecha date,
hora time
); 

alter table reserva add column id_cliente int;
alter table reserva add constraint fk_reserva_cliente
foreign key (id_cliente)references cliente (id_cliente);

alter table reserva add column id_mesa int;
alter table reserva add constraint fk_reserva_mesa
foreign key (id_mesa)references cliente (id_mesa);






