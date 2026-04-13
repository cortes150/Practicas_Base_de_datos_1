drop database if exists heroes_gestion;
create database heroes_gestion;
use heroes_gestion;

create table entrenador(
id_entrenador int auto_increment primary key,
nombre varchar(50),
Apellido_paterno varchar(50),
Apellido_materno varchar(50)
);

create table heroe(
id_heroe int auto_increment primary key,
nombre varchar(50),
Apellido_paterno varchar(50),
Apellido_materno varchar(50),
Habilidades_especiales varchar(100),
id_entrenador int,
foreign key (id_entrenador) references entrenador(id_entrenador)
);

create table poder(
id_poder int auto_increment primary key,
nombre varchar(50)
);

create table heroe_poder(
id_heroe_poder int auto_increment primary key,
id_heroe int,
id_poder int,
foreign key (id_heroe) references heroe(id_heroe),
foreign key (id_poder) references poder(id_poder)
);

create table mision(
id_mision int auto_increment primary key,
nombre varchar(50)
);

create table heroe_mision(
id_heroe_mision int auto_increment primary key,
id_heroe int,
id_mision int,
foreign key (id_heroe) references heroe(id_heroe),
foreign key (id_mision) references mision(id_mision)
);