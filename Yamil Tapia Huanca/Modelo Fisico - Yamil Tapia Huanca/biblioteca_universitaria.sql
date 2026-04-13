create database biblioteca_universitaria;
use biblioteca_universitaria;
create table estudiante(
id_estudiante int auto_increment primary key,
codigo_matricula varchar(30) unique not null,
nombre varchar(50),
apellido_paterno varchar(30),
apellido_materno varchar(30),
carrera varchar(100),
semestre int,
calle varchar(50),
numero varchar(50),
ciudad varchar(50),
edad int,
correo_electronico varchar(100)
);

create table telefono_estudiante(
id_telefono int auto_increment primary key,
numero varchar(50),
id_estudiante int, foreign key (id_estudiante) references estudiante(id_estudiante)
);

create table libro(
id_libro int auto_increment primary key,
titulo varchar(50),
editorial varchar(50),
categoria varchar (50),
año_publicacion date,
id_prestamo int, foreign key (id_prestamo) references prestamo(id_prestamo)
);

create table bibliotecario (
id_bibliotecario int auto_increment primary key,
telefono varchar(50),
nombre varchar(50),
apellido_paterno varchar(50),
apellido_materno varchar(50),
años_experiencia int,
turno varchar(50)
);

create table prestamo(
id_prestamo int auto_increment primary key,
fecha_prevista date, 
fecha_real date,
fecha_prestamo date,
id_bibliotecario int, foreign key (id_bibliotecario) references bibliotecario(id_bibliotecario),
id_estudiante int, foreign key (id_estudiante) references estudiante(id_estudiante)
);

create table autor(
id_autor int auto_increment primary key,
nombre varchar(50),
especialidad varchar(50)
);

create table L_A(
id_L_A int auto_increment primary key,
id_autor int, foreign key (id_autor) references autor(id_autor),
id_libro int, foreign key (id_libro) references libro(id_libro)
);