create database uniproyects;

use uniproyects;

create table evaluacion (
    id_evaluacion int auto_increment primary key,
    criterio varchar(100),
    observacion varchar(100),
    puntaje int
);

create table proyecto (
    id_proyecto int auto_increment primary key,
    n_proeycto varchar(100),
    tipo varchar(50),
    id_evaluacion int,
    foreign key (id_evaluacion) references evaluacion (id_evaluacion)
);

alter table proyecto add column observaciones varchar (100);
alter table proyecto modify column tipo varchar(30);

create table estudiante (
    id_estudiante int auto_increment primary key,
    nombre varchar(100),
    a_paterno varchar(50),
    a_materno varchar(50),
    contacto int,
    edad int,
    id_proyecto int,
    foreign key (id_proyecto) references proyecto (id_proyecto)
);

create table presentacion (
    id_presentacion int auto_increment primary key,
    tema varchar(100),
    fecha date,
    categoria varchar(50)
);

create table materia (
    id_materia int auto_increment primary key,
    nombre varchar(100),
    id_estudiante int, foreign key (id_estudiante) references estudiante (id_estudiante),
    id_presentacion int, foreign key (id_presentacion) references presentacion (id_presentacion)
);

create table jurado (
    id_jurado int auto_increment primary key,
    nombre varchar(100),
    a_paterno varchar(50),
    a_materno varchar(50),
    edad int,
    contacto int
);

create table proyecto_jurado (
    id_jurado int,
    id_proyecto int,
    primary key (id_proyecto, id_jurado),
    foreign key (id_proyecto) references proyecto (id_proyecto),
    foreign key (id_jurado) references jurado (id_jurado)
);

create table proyecto_materia (
    id_materia int,
    id_proyecto int,
    primary key (id_proyecto, id_materia),
    foreign key (id_proyecto) references proyecto (id_proyecto),
    foreign key (id_materia) references materia (id_materia)
);