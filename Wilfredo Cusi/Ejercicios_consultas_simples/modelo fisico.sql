CREATE DATABASE battlezone_db;
USE battlezone_db;
CREATE TABLE jugador (
 id_jugador INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100),
 nickname VARCHAR(50) UNIQUE,
 email VARCHAR(100),
 pais VARCHAR(50)
);
CREATE TABLE equipo (
 id_equipo INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100),
 fecha_creacion DATE
);
CREATE TABLE jugador_equipo (
 id_jugador INT,
 id_equipo INT,
 fecha_union DATE,
 
 PRIMARY KEY (id_jugador, id_equipo),
 
 FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador),
 FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);
CREATE TABLE juego (
 id_juego INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100),
 genero VARCHAR(50)
);
CREATE TABLE torneo (
 id_torneo INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100),
 fecha_inicio DATE,
 fecha_fin DATE,
 id_juego INT,
 
 FOREIGN KEY (id_juego) REFERENCES juego(id_juego)
);
CREATE TABLE partida (
 id_partida INT AUTO_INCREMENT PRIMARY KEY,
 id_torneo INT,
 fecha DATE,
 hora TIME,
 estado VARCHAR(50),
 
 FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);
CREATE TABLE participacion (
 id_partida INT,
 id_equipo INT,
 resultado VARCHAR(50),
 
 PRIMARY KEY (id_partida, id_equipo),
 
 FOREIGN KEY (id_partida) REFERENCES partida(id_partida),
 FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);
CREATE TABLE estadistica (
 id_estadistica INT AUTO_INCREMENT PRIMARY KEY,
 id_jugador INT,
 id_partida INT,
 kills INT,
 muertes INT,
 asistencias INT,
 
 FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador),
 FOREIGN KEY (id_partida) REFERENCES partida(id_partida)
);
CREATE TABLE premio (
 id_premio INT AUTO_INCREMENT PRIMARY KEY,
 id_torneo INT,
 posicion INT,
 monto DECIMAL(10,2),
 
 FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);
CREATE TABLE inscripcion (
 id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
 id_equipo INT,
 id_torneo INT,
 fecha_inscripcion DATE,
 
 FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo),
 FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);

-- 1
INSERT INTO jugador (nombre, nickname, email, pais)
VALUES ('Juan Perez', 'juanpro', 'juan@gmail.com', 'Bolivia');

-- 2
INSERT INTO jugador (nombre, nickname, email, pais)
VALUES ('Maria Lopez', 'marialol', 'maria@gmail.com', 'Peru');

-- 3
INSERT INTO equipo (nombre, fecha_creacion)
VALUES ('Team Alpha', '2024-01-10');

-- 4
INSERT INTO juego (nombre, genero)
VALUES ('Valorant', 'Shooter');

-- 5
INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego)
VALUES ('Torneo Apertura', '2025-05-01', '2025-05-10', 1);

-- 6
INSERT INTO partida (id_torneo, fecha, hora, estado)
VALUES (1, '2025-05-02', '18:00:00', 'Pendiente');

-- 7
INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion)
VALUES (1, 1, '2025-04-20');

-- 8
INSERT INTO premio (id_torneo, posicion, monto)
VALUES (1, 1, 1000.00);

-- 9
INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias)
VALUES (1, 1, 20, 5, 10);

-- Registra qué equipo participó en una partida y su resultado.
-- 10
INSERT INTO participacion (id_partida, id_equipo, resultado)
VALUES (1, 1, 'Ganador');

-- 11
UPDATE jugador
SET pais = 'Chile'				  
WHERE id_jugador = 1;
-- cambia el país de un jugador específico
-- solo afecta al jugador con id_jugador = 1

-- 12
UPDATE jugador
SET nickname = 'juan_master'
WHERE id_jugador = 1;
-- modifica el nombre de un jugador

-- 13
UPDATE equipo
SET nombre = 'Team Omega'
WHERE id_equipo = 1;
-- cambia el nombre de un equipo

-- 14
UPDATE juego
SET genero = 'FPS'
WHERE id_juego = 1;
-- modifica el genero de un juego de shooter a futbol

-- 15
UPDATE torneo
SET fecha_inicio = '2025-05-03'
WHERE id_torneo = 1;
-- cambia la fecha de inicio de un torneo.

-- 16
UPDATE partida
SET estado = 'Finalizado'
WHERE id_partida = 1;
-- Actualiza el estado de una partida como pendiente a Finalizado

-- 17
UPDATE premio
SET monto = 1500.00
WHERE id_premio = 1;
-- cambia el monto del premio de un torneo

-- 18
UPDATE estadistica
SET kills = 25
WHERE id_estadistica = 1;
-- Modifica el rendimiento de un jugador en una partida.

-- 19
UPDATE participacion
SET resultado = 'Perdedor'
WHERE id_partida = 1 AND id_equipo = 1;


-- 20
UPDATE inscripcion
SET fecha_inscripcion = '2025-04-25'
WHERE id_inscripcion = 1;
-- Modifica la fecha en la que un equipo se inscribió a un torneo.

-- 21
SELECT * FROM jugador
WHERE pais = 'Bolivia';
--  Muestra todos los jugadores de Bolivia 

-- 22
SELECT * FROM jugador
WHERE pais <> 'Bolivia';
-- Muestra jugadores que no son de Bolivia.

-- 23
SELECT * FROM equipo
WHERE fecha_creacion > '2024-01-01';
-- lista equipos creados después de una fecha

-- 24
SELECT * FROM juego
WHERE genero = 'FPS';
-- muestra juegos de un género específico

-- 25
SELECT * FROM torneo
WHERE fecha_inicio BETWEEN '2025-05-01' AND '2025-05-31';
-- lista torneos dentro de un rango de fechas

-- 26
SELECT * FROM partida
WHERE estado = 'Finalizado';
-- muestra partidas con un estado específico.

-- 27
SELECT * FROM premio
WHERE monto > 1000;
-- lista premios mayores a cierto monto

-- 28
SELECT * FROM estadistica
WHERE kills > 20;
-- muestra estadísticas donde un jugador hizo muchas kills

-- 29
SELECT * FROM participacion
WHERE resultado = 'Ganador';
-- muestra los equipos que ganaron partidas

-- 30
SELECT * FROM inscripcion
WHERE fecha_inscripcion BETWEEN '2025-04-01' AND '2025-04-30';
-- lista inscripciones hechas en un rango de fechas