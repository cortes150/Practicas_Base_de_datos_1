CREATE TABLE Equipo (
id_equipo INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
cantidad_personas INT
);

CREATE TABLE Robot (
id_robot INT AUTO_INCREMENT PRIMARY KEY,
tipo_robot VARCHAR(50),
peso VARCHAR(50),
nombre VARCHAR(50),
id_equipo INT, FOREIGN KEY (id_equipo) REFERENCES Equipo(id_equipo)
);

CREATE TABLE Batalla (
id_batalla INT AUTO_INCREMENT PRIMARY KEY,
categoria VARCHAR(50),
fecha DATE,
hora TIME,
lugar VARCHAR(50)
);

CREATE TABLE R_B (
   id_robot INT,
   id_batalla INT,
   PRIMARY KEY (id_robot, id_batalla),
   FOREIGN KEY (id_robot) REFERENCES Robot(id_robot),
   FOREIGN KEY (id_batalla) REFERENCES Batalla(id_batalla)
);

CREATE TABLE Resultado (
   id_resultado INT AUTO_INCREMENT PRIMARY KEY,
   id_batalla INT UNIQUE,
   id_robot_ganador INT,
   FOREIGN KEY (id_batalla) REFERENCES Batalla(id_batalla),
   FOREIGN KEY (id_robot_ganador) REFERENCES Robot(id_robot)
);