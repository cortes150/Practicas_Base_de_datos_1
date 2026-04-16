DROP DATABASE IF EXISTS uniprojects1;
CREATE DATABASE uniprojects1;
USE uniprojects1;

CREATE TABLE materia (
  cod_materia INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NULL,
  PRIMARY KEY (cod_materia)
);

CREATE TABLE categoria (
  idcategoria INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NULL,
  PRIMARY KEY (idcategoria)
);

CREATE TABLE estudiante (
  cod_estudiante INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(25) NULL,
  apellido VARCHAR(25) NULL,
  telefono INT NULL,
  PRIMARY KEY (cod_estudiante)
);

CREATE TABLE jurado (
  cod_jurado INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(25) NULL,
  apellido VARCHAR(25) NULL,
  telefono INT NULL,
  PRIMARY KEY (cod_jurado)
);

CREATE TABLE evaluacion (
  idevaluacion INT NOT NULL AUTO_INCREMENT,
  criterio VARCHAR(120) NULL,
  puntaje INT NULL,
  observaciones VARCHAR(120) NULL,
  PRIMARY KEY (idevaluacion)
);

CREATE TABLE proyecto (
  cod_proy INT NOT NULL AUTO_INCREMENT,
  tema VARCHAR(120) NULL,
  fecha_presentacion DATE NULL,
  cod_materia INT NOT NULL,
  idcategoria INT NOT NULL,
  PRIMARY KEY (cod_proy),
  FOREIGN KEY (cod_materia) REFERENCES materia(cod_materia),
  FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria)
);

CREATE TABLE proyecto_estudiante (
  cod_estudiante INT NOT NULL,
  cod_proy INT NOT NULL,
  PRIMARY KEY (cod_estudiante, cod_proy),
  FOREIGN KEY (cod_estudiante) REFERENCES estudiante(cod_estudiante),
  FOREIGN KEY (cod_proy) REFERENCES proyecto(cod_proy)
);

CREATE TABLE proyecto_jurado_evaluacion (
  cod_jurado INT NOT NULL,
  idevaluacion INT NOT NULL,
  cod_proy INT NOT NULL,
  PRIMARY KEY (cod_jurado, idevaluacion, cod_proy),
  FOREIGN KEY (cod_jurado) REFERENCES jurado(cod_jurado),
  FOREIGN KEY (idevaluacion) REFERENCES evaluacion(idevaluacion),
  FOREIGN KEY (cod_proy) REFERENCES proyecto(cod_proy)
);

INSERT INTO materia (nombre) VALUES ('Tecnología Web'), ('Análisis de Sistemas');
INSERT INTO categoria (nombre) VALUES ('Desarrollo Web'), ('Sistemas Embebidos');
INSERT INTO estudiante (nombre, apellido, telefono) VALUES ('Walter', 'Aguilar', 79125100), ('Lucia', 'Mendoza', 71234567);
INSERT INTO jurado (nombre, apellido, telefono) VALUES ('Roberto', 'Caceres', 70011223), ('Marco', 'Cortes', 79988776);
INSERT INTO evaluacion (criterio, puntaje, observaciones) VALUES ('Arquitectura de Software', 85, 'Bien estructurado'), ('Innovación', 90, 'Interesante');

INSERT INTO proyecto (tema, fecha_presentacion, cod_materia, idcategoria) VALUES ('Robotica en la casa', '2026-05-15', 1, 1), ('ESP32 Sensor', '2026-06-20', 2, 2);

INSERT INTO proyecto_estudiante (cod_estudiante, cod_proy) VALUES (1, 1), (2, 2);
INSERT INTO proyecto_jurado_evaluacion (cod_jurado, idevaluacion, cod_proy) VALUES (1, 1, 1), (2, 2, 2);

UPDATE evaluacion SET puntaje = 95 WHERE idevaluacion = 1;

DELETE FROM proyecto_jurado_evaluacion WHERE cod_jurado = 2 AND cod_proy = 2;