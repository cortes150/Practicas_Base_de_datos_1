DROP DATABASE battlezone_db;
CREATE DATABASE battlezone_db;
USE battlezone_db;

CREATE TABLE jugador (
    id_jugador INT AUTO_INCREMENT PRIMARY KEY,
    nombre     VARCHAR(100),
    nickname   VARCHAR(50) UNIQUE,
    email      VARCHAR(100),
    pais       VARCHAR(50)
);

CREATE TABLE equipo (
    id_equipo       INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100),
    fecha_creacion  DATE
);

CREATE TABLE jugador_equipo (
    id_jugador  INT,
    id_equipo   INT,
    fecha_union DATE,
    PRIMARY KEY (id_jugador, id_equipo),
    FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador),
    FOREIGN KEY (id_equipo)  REFERENCES equipo(id_equipo)
);

CREATE TABLE juego (
    id_juego INT AUTO_INCREMENT PRIMARY KEY,
    nombre   VARCHAR(100),
    genero   VARCHAR(50)
);

CREATE TABLE torneo (
    id_torneo    INT AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin    DATE,
    id_juego     INT,
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego)
);

CREATE TABLE partida (
    id_partida INT AUTO_INCREMENT PRIMARY KEY,
    id_torneo  INT,
    fecha      DATE,
    hora       TIME,
    estado     VARCHAR(50),
    FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);

CREATE TABLE participacion (
    id_partida INT,
    id_equipo  INT,
    resultado  VARCHAR(50),
    PRIMARY KEY (id_partida, id_equipo),
    FOREIGN KEY (id_partida) REFERENCES partida(id_partida),
    FOREIGN KEY (id_equipo)  REFERENCES equipo(id_equipo)
);

CREATE TABLE estadistica (
    id_estadistica INT AUTO_INCREMENT PRIMARY KEY,
    id_jugador     INT,
    id_partida     INT,
    kills          INT,
    muertes        INT,
    asistencias    INT,
    FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador),
    FOREIGN KEY (id_partida) REFERENCES partida(id_partida)
);

CREATE TABLE premio (
    id_premio INT AUTO_INCREMENT PRIMARY KEY,
    id_torneo INT,
    posicion  INT,
    monto     DECIMAL(10,2),
    FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);

CREATE TABLE inscripcion (
    id_inscripcion    INT AUTO_INCREMENT PRIMARY KEY,
    id_equipo         INT,
    id_torneo         INT,
    fecha_inscripcion DATE,
    FOREIGN KEY (id_equipo)  REFERENCES equipo(id_equipo),
    FOREIGN KEY (id_torneo)  REFERENCES torneo(id_torneo)
);

