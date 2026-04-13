create database biblioteca_universitari;
use biblioteca_universitaria;

create table estudiante(
	id_estudiante int auto_increment primary key,
	id_prestamo int, foreign key(id_prestamo) references prestamo(id_prestamo),
    codigo_matricula varchar(30) unique not null,
	nombre varchar(50),
    apellido_paterno varchar(50),
    apellido_materno varchar(50),
    carrera varchar(100),
    semestre int,
    calle varchar(100),
    numero int,
    ciudad varchar(50),
    correo_electronico varchar(50),
    edad int
);

create table telefono_estudiante(
	id_telefono int auto_increment primary key,
    id_estudiante int, foreign key (id_estudiante) references estudiante(id_estudiante),
    numero varchar(20)
);

create table libro(
	id_libro int auto_increment primary key,
    titulo varchar(50),
    editorial varchar(20),
    categoria varchar(20),
    año_publicacion varchar(20)
);

create table bibliotecario(
	id_bibliotecario int auto_increment primary key,
    nombre varchar(50),
    apellido_paterno varchar(50),
    apellido_materno varchar(50),
    años_experiencia int,
    turno varchar(20),
    telefeno varchar(20)
);

create table autor(
	id_autor int auto_increment primary key,
	nombre varchar(50),
    apellido_paterno varchar(50),
    apellido_materno varchar(50)
);

create table prestamo(
	id_prestamo int auto_increment primary key,
    id_libro int, foreign key (id_libro) references libro(id_libro),
    id_bibliotecario int, foreign key (id_bibliotecario) references bibliotecario(id_bibliotecario),
    fecha_prestamo date,
    fecha_devolucion date,
    fecha_devolucion_prevista date
);

create table autor_libro(
	id_autor_libro int auto_increment primary key,
    id_autor int, foreign key (id_autor) references autor(id_autor),
    id_libro int, foreign key (id_libro) references libro(id_libro)
);
