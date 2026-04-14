create database examen_bd;
use examen_bd; 
create table proyecto(
id_proyecto int  primary key,
id_estudiante int,
nombre varchar(100),
tema varchar(50),
categorias varchar(50), 
estado varchar(50),
f_presentacion date, 
materia varchar(50),
tipo_proyecto varchar(50)
); 

create table jurado(
id_jurado int auto_increment primary key,
id_proyecto int,
nombre varchar(100),
a_paterno varchar(50),
a_materno varchar(50),
asignatura varchar(50),
especialidad varchar(50)
); 

create table estudiante( 
id_estudiante int auto_increment primary key,
nombre varchar(100),
a_paterno varchar(50), 
a_materno varchar(50),
carrera varchar(50),
edad int
); 

create table evaluacion(
id_evaluacion int auto_increment primary key,
criterios varchar(100),
puntaje decimal(10,2),
calificacion int,
observacion varchar(100)
); 

create table materia(
id_materia int auto_increment primary key,
tipo_practica varchar(50),
nombre varchar(50), 
semestre varchar(50),
modulo int
);  

create table feria(
id_feria int auto_increment primary key,
nombre varchar(100),
tipo_feria varchar(100),
participacion varchar(100)
);

alter table proyecto
add column observaciones varchar(50); 

alter table proyecto 
modify column estado varchar(50);

alter table proyecto
add column id_estudiante int,
add constraint fk_proyecto_estudiante
foreign key (id_estudiante) references estudiante(id_estudiante);

alter table proyecto
add column id_estudiante int,
add constraint fk_proyecto_estudiante
foreign key (id_estudiante) references estudiante(id_estudiante);
