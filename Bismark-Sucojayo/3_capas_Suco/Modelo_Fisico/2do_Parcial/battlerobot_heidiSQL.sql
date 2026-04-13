drop database if exists battlerobot;
CREATE database battlerobot;
USE battlerobot;

CREATE TABLE batalla(
id_batalla INT AUTO_INCREMENT PRIMARY KEY,
fecha DATE,
ubicacion VARCHAR(50),
categoria VARCHAR(50),
hora time
);

CREATE TABLE equipo(
id_equipo INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
cantidad_robot int
);

CREATE TABLE robot(
id_robot INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
tipo VARCHAR(50),
peso VARCHAR(50),
id_equipo INT,
FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);

CREATE TABLE robot_batalla(
id_robot_batalla INT AUTO_INCREMENT PRIMARY KEY,
id_robot INT,
id_batalla INT,
FOREIGN KEY (id_robot) REFERENCES robot(id_robot),
FOREIGN KEY (id_batalla) REFERENCES batalla(id_batalla)
);
CREATE TABLE resultado(
id_resultado INT AUTO_INCREMENT PRIMARY KEY,
puntaje INT,
ganador VARCHAR(50),
id_robot INT,
FOREIGN KEY (id_robot) REFERENCES robot(id_robot)
);