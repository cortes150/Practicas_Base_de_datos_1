create database Academia_Superheroe;
use Academia_Superheroe;
create table Entrenador (
id_entrenador int auto_increment primary key,
nombre_entrenador varchar(50),
edad int,
años_experiencia int,
titulo_academico varchar(50)
);
create table Heroe (
id_heroe int auto_increment primary key,
nombre varchar(50),
Apellido_Paterno varchar(50),
Apellido_Materno varchar(50),
grado varchar(50),
edad int,
id_entrenador int, foreign key (id_entrenador) references Entrenador(id_entrenador)
);
create table Poder (
id_poder int auto_increment primary key,
nombre_poder varchar(50),
nivel int
);
create table H_P(
id_H_P int auto_increment primary key,
id_heroe int, foreign key (id_heroe) references Heroe(id_heroe),
id_poder int, foreign key (id_poder) references Poder(id_poder)
);
create table Mision (
id_mision int auto_increment primary key,
categoria varchar(50),
prioridad varchar(50),
nombre_mision varchar(50)
);
create table Asignacion (
id_asignacion int auto_increment primary key,
id_heroe int, foreign key (id_heroe) references Heroe(id_heroe),
id_mision int, foreign key (id_mision) references Mision(id_mision)
);