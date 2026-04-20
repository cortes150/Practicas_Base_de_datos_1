create database uniprojects;
use uniprojects;
 create table estudiante(
 id_estudiante int auto_increment primary key,
 nombre varchar(50),
 Apellido_paterno varchar(50),
 Apellido_materno varchar(50),
 carrera varchar(50),
 semestre varchar(50)
 );
 
 create table jurado(
 id_jurado int auto_increment primary key,
 especialidad varchar(50),
 nombre varchar(50),
 Apellido_paterno varchar(50),
 Apellido_materno varchar(50)
 );
 
 create table materia(
 id_materia int auto_increment primary key,
 nombre varchar(50)
 );
 
 create table presentacion(
 id_presentacion int auto_increment primary key,
 fecha date,
 categoria varchar(50)
 );

 create table proyecto(
 id_proyecto int auto_increment primary key,
 nombre varchar (50),
 estado varchar(50),
 id_materia int,
 id_presentacion int,
 foreign key (id_materia) references materia(id_materia),
 foreign key (id_presentacion) references presentacion(id_presentacion)
 );
 
 create table evaluacion(
 id_evaluacion int,
 puntaje int,
 criterio varchar(1000),
 observaciones varchar(1000)
 );
 
 create table proyecto_estudiante(
 id_proyecto_estudiante int,
 id_estudiante int,
 id_proyecto int,
 foreign key (id_estudiante) references estudiante(id_estudiante),
 foreign key (id_proyecto) references proyecto(id_proyecto)
 );
 
 create table proyecto_jurado(
 id_proyecto_jurado int,
 id_proyecto int,
 id_jurado int,
 foreign key (id_proyecto) references proyecto(id_proyecto),
 foreign key (id_jurado) references jurado(id_jurado)
 );
 
 alter table proyecto add column observaciones varchar(1000);
 