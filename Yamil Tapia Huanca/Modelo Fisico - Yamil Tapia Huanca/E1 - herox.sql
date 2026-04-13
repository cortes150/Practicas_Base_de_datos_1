CREATE DATABASE herox;
USE herox;

CREATE TABLE entrenador(
id_entrenador INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
especialidad VARCHAR(50),
experiencia INT
);

CREATE TABLE telefono_entrenador(
id_telefono INT AUTO_INCREMENT PRIMARY KEY,
numero VARCHAR(20),
id_entrenador INT,
FOREIGN KEY (id_entrenador) REFERENCES entrenador(id_entrenador)
);

CREATE TABLE heroe(
id_heroe INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
alias VARCHAR(50),
edad INT,
ciudad VARCHAR(50),
id_entrenador INT,
FOREIGN KEY (id_entrenador) REFERENCES entrenador(id_entrenador)
);

CREATE TABLE poder(
id_poder INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
tipo VARCHAR(50),
nivel INT,
descripcion VARCHAR(100)
);

CREATE TABLE mision(
id_mision INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
dificultad VARCHAR(20),
ubicacion VARCHAR(50),
fecha DATE
);

-- N:M
CREATE TABLE heroe_poder(
id_hp INT AUTO_INCREMENT PRIMARY KEY,
id_heroe INT,
id_poder INT,
FOREIGN KEY (id_heroe) REFERENCES heroe(id_heroe),
FOREIGN KEY (id_poder) REFERENCES poder(id_poder)
);

CREATE TABLE heroe_mision(
id_hm INT AUTO_INCREMENT PRIMARY KEY,
id_heroe INT,
id_mision INT,
FOREIGN KEY (id_heroe) REFERENCES heroe(id_heroe),
FOREIGN KEY (id_mision) REFERENCES mision(id_mision)
);