create database Heroes;

use Heroes;

create table Entrenador(
id_entrenador int auto_increment primary key,
nombre varchar (50),
apellido_paterno varchar (50),
apellido_materno varchar (50),
especialidad varchar (50),
edad int,
años_experencia date,
direccion varchar (100)
);
create table Heroe(
id_heroe int auto_increment primary key,
nombre varchar(50),
apellido_paterno varchar(50),
apellido_materno varchar(50),
identidad_secreta varchar(50),
edad int,
direccion varchar(100),
id_entrenador int, foreign key (id_entrenador) references Entrenador (id_entrenador)
);
create table Heroe_Poder(
id_heroe_poder int auto_increment primary key,
id_heroe int, foreign key (id_heroe) references Heroe (id_heroe),
id_poder int, foreign key (id_poder) references Poder (id_poder)
);
create table Heroe_Mision(
id_heroe_mision int auto_increment primary key,
id_heroe int, foreign key (id_heroe) references Heroe (id_heroe),
id_mision int, foreign key (id_mision) references Mision (id_mision)
);
create table Poder(
id_poder int,
nombre_poder varchar (50),
tipo varchar (50)
);
create table Mision(
id_mision int primary key,
nombre_mision varchar (60),
nombre_nivel varchar(20),
ubicacion varchar(100)
);