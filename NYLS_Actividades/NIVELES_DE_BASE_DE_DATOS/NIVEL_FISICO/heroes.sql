CREATE DATABASE SistemaHeroes;
USE SistemaHeroes;

CREATE TABLE Entrenador (
    id_entrenador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL
);

CREATE TABLE Heroe (
    id_heroe INT AUTO_INCREMENT PRIMARY KEY,
    nombre_heroe VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_entrenador INT,
    FOREIGN KEY (id_entrenador) REFERENCES Entrenador(id_entrenador)
);

CREATE TABLE Poder (
    id_poder INT AUTO_INCREMENT PRIMARY KEY,
    nombre_poder VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE Mision (
    id_mision INT AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT,
    rango_peligro VARCHAR(50)
);

CREATE TABLE Heroe_poder (
    id_heroe_poder INT AUTO_INCREMENT PRIMARY KEY,
    id_heroe INT,
    id_poder INT,
    FOREIGN KEY (id_heroe) REFERENCES Heroe(id_heroe),
    FOREIGN KEY (id_poder) REFERENCES Poder(id_poder)
);

CREATE TABLE Heroe_mision (
    id_heroe_mision INT AUTO_INCREMENT PRIMARY KEY,
    id_heroe INT,
    id_mision INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_heroe) REFERENCES Heroe(id_heroe),
    FOREIGN KEY (id_mision) REFERENCES Mision(id_mision)
);

CREATE TABLE Historial_misiones (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_mision INT,
    numero_mision INT,
    FOREIGN KEY (id_mision) REFERENCES Mision(id_mision)
);