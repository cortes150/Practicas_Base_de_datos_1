create database HeroX;
use HeroX;

create table Heroe(
	id_Heroe int auto_increment primary key,
	Nombre varchar(100),
	A_P varchar(50),
	A_M varchar(50)
);

create table Poder(
	id_Poder int auto_increment primary key,
	Descripcion varchar(200)
);

create table Entrenador(
	id_Entrenador int auto_increment primary key,
	Nombre varchar(100),
	A_P varchar(50),
	A_M varchar(50),
	Anios_exp int,
	Especialidad varchar(100)
);

create table Mision(
	id_Mision int auto_increment primary key,
	Descripcion varchar(200),
	Dificultad varchar(50)
);

create table Poder_Heroe(
	id_Poder_Heroe int auto_increment primary key,
	id_Poder int, foreign key(id_Poder) references Poder(id_Poder),
	id_Heroe int, foreign key(id_Heroe) references Heroe(id_Heroe)
);

create table Mision_Heroe(
	id_Mision_Heroe int auto_increment primary key,
	id_Mision int, foreign key(id_Mision) references Mision(id_Mision),
	id_Heroe int, foreign key(id_Heroe) references Heroe(id_Heroe)
);
