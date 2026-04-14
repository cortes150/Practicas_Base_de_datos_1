CREATE DATABASE Uni_proyects;
USE Uni_proyects;

create table proyecto(
	id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    tema VARCHAR(40),
	fecha_inicio date,
    fecha_final date
);

##falta
ALTER TABLE proyecto
ADD id_materia INT,
ADD CONSTRAINT fk_materia
FOREIGN KEY (id_materia) REFERENCES materia(id_materia);

ALTER TABLE proyecto
ADD id_feria INT,
ADD CONSTRAINT fk_feria
FOREIGN KEY (id_feria) REFERENCES feria(id_feria);

create table estudiante(
	id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    Apellido_paterno VARCHAR(40),
	Apellido_materno VARCHAR(40),
    edad int,
    semestre int,
    carrera varchar(50)
);

create table jurado(
	id_jurado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20),
    Apellido_paterno VARCHAR(20),
	Apellido_materno VARCHAR(20),
    correo varchar(255)
);

create table evaluacion(
	id_evaluacion INT AUTO_INCREMENT PRIMARY KEY,
    puntaje int,
    observaciones VARCHAR(20)
);

ALTER TABLE evaluacion
ADD id_jurado INT,
ADD CONSTRAINT fk_jurado
FOREIGN KEY (id_jurado) REFERENCES jurado(id_jurado);

CREATE TABLE feria (
    id_feria INT AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(50),
    inicio datetime,
    final datetime
);

CREATE TABLE materia (
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    duracion int,
    semestre int
);


CREATE TABLE proyecto_estudiante (
    id_proyecto INT,
    id_estudiante INT
);

ALTER TABLE proyecto_estudiante
ADD PRIMARY KEY (id_proyecto, id_estudiante);

ALTER TABLE proyecto_estudiante
ADD CONSTRAINT fk_pe_proyecto
FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto),
ADD CONSTRAINT fk_pe_estudiante
FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante);

CREATE TABLE proyecto_jurado (
    id_proyecto INT,
    id_jurado INT
);

ALTER TABLE proyecto_jurado
ADD PRIMARY KEY (id_proyecto, id_jurado);

ALTER TABLE proyecto_jurado
ADD CONSTRAINT fk_pj_proyecto
FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto),
ADD CONSTRAINT fk_pj_jurado
FOREIGN KEY (id_jurado) REFERENCES jurado(id_jurado);
##añadir
ALTER TABLE proyecto
ADD observaciones varchar(100);

ALTER TABLE proyecto
ADD estado varchar(10);

ALTER TABLE proyecto
MODIFY estado varchar(30);