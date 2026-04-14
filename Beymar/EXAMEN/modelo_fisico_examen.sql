create database UniProjects;
use UniProjects;
create table Estudiante(
id_estudiante int auto_increment primary key,
nombre varchar(50),
ap_paterno varchar(50),
ap_materno varchar(50),
edad int,
semestre_cursando varchar(50)
);

create table Proyecto(
id_proyecto int auto_increment primary key,
tema varchar(50),
categoria varchar(50),
fecha_presentacion date
);
alter table Proyecto add observaciones varchar(50);
alter table Proyecto add id_materia int;

create table P_E(
id_P_E int auto_increment primary key,
id_proyecto int,
id_estudiante int
);

create table Jurado(
id_jurado int auto_increment primary key,
nombre varchar(50),
ap_paterno varchar(50),
ap_materno varchar(50),
titulo_universitario varchar(50)
);

create table Evaluacion(
id_evaluacion int auto_increment primary key,
criterio varchar(50),
puntaje decimal,
observaciones varchar(50),
id_jurado int,
id_proyecto int
);

create table Materia(
id_materia int auto_increment primary key,
nombre_materia varchar(50),
id_carrera int
);

create table Carrera(
id_carrera int auto_increment primary key,
nombre_carrera varchar(50)
);

alter table Proyecto add constraint fk_id_materia
foreign key (id_materia) references Materia(id_materia);

alter table P_E add constraint fk_id_proyecto
foreign key (id_proyecto) references Proyecto(id_proyecto);

alter table P_E add constraint fk_id_estudiante
foreign key (id_estudiante) references Estudiante(id_estudiante);

alter table Evaluacion add constraint fk_id_jurado
foreign key (id_jurado) references Jurado(id_jurado);

alter table Evaluacion add constraint fk_id_proyectoo
foreign key (id_proyecto) references Proyecto(id_proyecto);

alter table Materia add constraint fk_id_carrera
foreign key (id_carrera) references Carrera(id_carrera);


