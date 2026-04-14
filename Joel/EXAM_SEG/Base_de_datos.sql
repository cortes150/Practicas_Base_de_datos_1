
CREATE DATABASE Uniprojects_db;
USE Uniprojects_db;

CREATE TABLE estudiante(
id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR(50),
Apellido_Paterno VARCHAR(50),
Apellido_Materno VARCHAR(50),
Carrera VARCHAR (50),
Edad INT
);

CREATE TABLE jurado(
id_jurado INT AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR(50),
Apellido_Paterno VARCHAR(50),
Apellido_Materno VARCHAR(50),
Edad INT
);


CREATE TABLE materia(
id_materia INT AUTO_INCREMENT PRIMARY KEY,
Docente VARCHAR(50),
Nombre_materia VARCHAR(50)
);

CREATE TABLE evaluacion(
id_evaluacion INT AUTO_INCREMENT PRIMARY KEY,
Observacion VARCHAR(50),
Puntaje DOUBLE,
Criterio VARCHAR(50),
id_jurado INT,
FOREIGN KEY (id_jurado) REFERENCES jurado (id_jurado)
);

CREATE TABLE feria (
id_feria INT AUTO_INCREMENT PRIMARY KEY,
Fecha DATE,
Hora_inicio TIME,
Hora_final TIME
);



CREATE TABLE proyecto(
id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
Fecha_presentacion DATE,
Categoria VARCHAR(50),
Estado VARCHAR(50),
id_materia INT,
FOREIGN KEY (id_materia) REFERENCES materia (id_materia),
id_feria INT,
FOREIGN KEY (id_feria) REFERENCES feria (id_feria)
);

ALTER TABLE proyecto ADD observacion VARCHAR(50);
ALTER TABLE proyecto MODIFY Estado VARCHAR(30);


CREATE TABLE  estudiante_proyecto(
id_estudiante_proyecto INT AUTO_INCREMENT PRIMARY KEY,
id_estudiante INT,
FOREIGN KEY (id_estudiante) REFERENCES estudiante (id_estudiante),
id_proyecto INT,
FOREIGN KEY (id_proyecto) REFERENCES proyecto (id_proyecto)
);

CREATE TABLE  jurado_proyecto(
id_jurado_proyecto INT AUTO_INCREMENT PRIMARY KEY,
id_jurado INT,
FOREIGN KEY (id_jurado) REFERENCES jurado (id_jurado),
id_proyecto INT,
FOREIGN KEY (id_proyecto) REFERENCES proyecto (id_proyecto)
);



INSERT INTO  Estudiante( Nombre, Carrera) VALUES 
('Alex', 'Sistemas'),
('Maria', 'Automotriz');

INSERT INTO  jurado( Nombre, Edad) VALUES 
('Alex', '40'),
('Maria', '33');

INSERT INTO  materia( Docente, Nombre_materia) VALUES 
('Alexia', 'Base de datos I'),
('Mario', 'Programación I');

INSERT INTO  Estudiante( Nombre, Carrera) VALUES 
('Alex', 'Sistemas'),
('Maria', 'Automotriz');
