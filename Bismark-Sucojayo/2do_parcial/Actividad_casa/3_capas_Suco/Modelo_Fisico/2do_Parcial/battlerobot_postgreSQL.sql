
DROP TABLE IF EXISTS resultado CASCADE;
DROP TABLE IF EXISTS robot_batalla CASCADE;
DROP TABLE IF EXISTS robot CASCADE;
DROP TABLE IF EXISTS equipo CASCADE;
DROP TABLE IF EXISTS batalla CASCADE;

CREATE TABLE batalla(
    id_batalla SERIAL PRIMARY KEY,
    fecha DATE,
    ubicacion VARCHAR(50),
    categoria VARCHAR(50),
    hora TIME
);

CREATE TABLE equipo(
    id_equipo SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    cantidad_robot INT
);

CREATE TABLE robot(
    id_robot SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    tipo VARCHAR(50),
    peso VARCHAR(50),
    id_equipo INT,
    CONSTRAINT fk_equipo FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);

CREATE TABLE robot_batalla(
    id_robot_batalla SERIAL PRIMARY KEY,
    id_robot INT,
    id_batalla INT,
    CONSTRAINT fk_robot FOREIGN KEY (id_robot) REFERENCES robot(id_robot),
    CONSTRAINT fk_batalla FOREIGN KEY (id_batalla) REFERENCES batalla(id_batalla)
);

CREATE TABLE resultado(
    id_resultado SERIAL PRIMARY KEY,
    puntaje INT,
    ganador VARCHAR(50),
    id_robot INT,
    CONSTRAINT fk_robot_res FOREIGN KEY (id_robot) REFERENCES robot(id_robot)
);