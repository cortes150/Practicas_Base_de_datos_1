
USE RoboBattle;
GO

CREATE TABLE Equipo (
    id_equipo int IDENTITY(1,1) PRIMARY KEY,
    nombre varchar(100) NOT NULL,
    ciudad_origen varchar(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    nombre_capitan varchar(100),
    correo_contacto varchar(100)
);


CREATE TABLE Telefono_Equipo (
    id_telefono_equipo int IDENTITY(1,1) PRIMARY KEY,
    numero varchar(20) NOT NULL,
    id_equipo int,
    FOREIGN KEY(id_equipo) REFERENCES Equipo(id_equipo)
);


CREATE TABLE Robot (
    id_robot int IDENTITY(1,1) PRIMARY KEY,
    id_equipo int,
    nombre varchar(100) NOT NULL,
    peso decimal(10,2),
    FOREIGN KEY(id_equipo) REFERENCES Equipo(id_equipo)
);


CREATE TABLE Perceptores (
    id_perceptores int IDENTITY(1,1) PRIMARY KEY,
    id_robot int,
    nombre varchar(100),
    FOREIGN KEY(id_robot) REFERENCES Robot(id_robot)
);


CREATE TABLE Batalla (
    id_batalla int IDENTITY(1,1) PRIMARY KEY,
    fecha_encuentro datetime NOT NULL,
    arena varchar(100),
    ambiente varchar(100),
    categoria varchar(50),
    duracion int
);


CREATE TABLE Resulta_batalla (
    id_resultado int IDENTITY(1,1) PRIMARY KEY,
    id_robot int,
    id_batalla int,
    puntos_obtenidos int,
    estado_final varchar(50),
    FOREIGN KEY(id_robot) REFERENCES Robot(id_robot),
    FOREIGN KEY(id_batalla) REFERENCES Batalla(id_batalla)
);
ALTER TABLE Equipo
DROP COLUMN fecha_nacimiento;
GO