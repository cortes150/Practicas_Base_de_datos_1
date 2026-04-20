CREATE TABLE jugador (
    id_jugador SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    nickname VARCHAR(50) UNIQUE,
    email VARCHAR(100),
    pais VARCHAR(50)
);

CREATE TABLE equipo (
    id_equipo SERIAL PRIMARY KEY,
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
    id_juego SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    genero VARCHAR(50)
);

CREATE TABLE torneo (
    id_torneo SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE,
    id_juego INT,
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego)
);

CREATE TABLE partida (
    id_partida SERIAL PRIMARY KEY,
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
id_estadistica SERIAL PRIMARY KEY,
id_jugador INT,
id_partida INT,
kills INT,
muertes INT,
asistencias INT,
FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador),
FOREIGN KEY (id_partida) REFERENCES partida(id_partida)
);

CREATE TABLE premio (
id_premio SERIAL PRIMARY KEY,
id_torneo INT,
posicion INT,
monto DECIMAL(10,2),
FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);

CREATE TABLE inscripcion (
id_inscripcion SERIAL PRIMARY KEY,
id_equipo INT,
id_torneo INT,
fecha_inscripcion DATE,
FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo),
FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);
--1 y 2
INSERT INTO jugador (nombre, nickname, email, pais) 
VALUES ('Cruz', 'Cruz_ADS', 'cruz@unandes.edu.bo', 'Bolivia'),
('Ana', 'ANgy', 'ana@unandes.edu.bo', 'Ecuador');
INSERT INTO jugador (nombre, nickname, email, pais) 
VALUES ('Carlos', 'Carlitos', 'carlos@unandes.edu.bo', 'Bolivia'),
('Amelia', 'AFTS', 'amelia@unandes.edu.bo', 'Ecuador'),
('Juan', 'Ln91', 'juan@unandes.edu.bo', 'Brazil'),
('Daniel', 'Doknow', 'dknow@unandes.edu.bo', 'Peru'),
('Carla', 'Americ1', 'Amer@unandes.edu.bo', 'Chile'),
('Jhovana', 'Jhovi223', 'joan@unandes.edu.bo', 'Bolivia'),
('Katerin', 'K4ty', 'ktrn@unandes.edu.bo', 'Ecuador'),
('Sabrina', 'C4rp1', 'SabCa@unandes.edu.bo', 'Brazil'),
('Lessa', 'Lesserafim', 'Less4@unandes.edu.bo', 'Peru'),
('Danielle', 'D40m', 'spcr@unandes.edu.bo', 'Chile'),
('Ross', 'UNDEFEATED', 'UNDross@unandes.edu.bo', 'Bolivia'),
('Aneliz', 'Anlz', 'anl1z@unandes.edu.bo', 'Ecuador'),
('Robert', 'Apolo', 'ApArt@unandes.edu.bo', 'Brazil');
--3
INSERT INTO equipo (nombre, fecha_creacion) VALUES ('Los Guerreros de la Unandes', '2026-01-15')
INSERT INTO equipo (nombre, fecha_creacion) VALUES('Left&Right', '2026-01-15'),
('XGALX', '2026-02-15'),
('TWICE', '2026-03-16'),
('BP', '2026-04-17'),
('SKZ', '2026-05-18'),
('ATEEZ', '2026-06-19'),
('NCT', '2026-07-20'),
('GOT7', '2026-08-21'),
('KDA', '2026-09-22'),
('DREAMCATCHER', '2026-10-23'),
('MOMOLAND', '2026-11-24'),
('MAMAMOO', '2026-11-25'),
('NJ', '2026-12-26'),
('SNSD', '2026-01-27');
--4
INSERT INTO juego (nombre, genero) VALUES ('Valorant', 'Shooter');
INSERT INTO juego (nombre, genero) VALUES 
('League of Legends', 'MOBA'),
('Dota 2', 'MOBA'),
('Counter-Strike 2', 'Shooter'),
('Fortnite', 'Battle Royale'),
('Apex Legends', 'Battle Royale'),
('Minecraft', 'Sandbox'),
('Rocket League', 'Deportes'),
('FIFA 24', 'Deportes'),
('Street Fighter 6', 'Lucha'),
('Mortal Kombat 1', 'Lucha'),
('StarCraft II', 'Estrategia'),
('Age of Empires IV', 'Estrategia'),
('Overwatch 2', 'Hero Shooter'),
('Genshin Impact', 'ARPG');
--5
INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES ('Copa Unandes 2026', '2026-05-01', '2026-05-15', 1);
INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES 
('Copa Verano', '2026-01-10', '2026-01-20', 2),
('Masters Santa Cruz', '2026-02-15', '2026-02-28', 3),
('Invitacional K-Pop', '2026-03-05', '2026-03-15', 4),
('Gamer Zone Cochabamba', '2026-04-20', '2026-04-30', 5),
('BattleZone Season 1', '2026-05-15', '2026-05-30', 6),
('Torneo Relampago', '2026-06-01', '2026-06-05', 7),
('Liga Universitaria', '2026-07-10', '2026-07-25', 8),
('Championship ADS', '2026-08-05', '2026-08-20', 9),
('Copa Diamante', '2026-09-12', '2026-09-22', 10),
('Winter Open', '2026-10-01', '2026-10-15', 11),
('Circuit Pro', '2026-11-05', '2026-11-15', 12),
('Ultimate Battle', '2026-12-01', '2026-12-10', 13),
('Finals 2026', '2026-12-20', '2026-12-30', 14),
('New Year Cup', '2027-01-01', '2027-01-05', 15);
--6
INSERT INTO partida (fecha, hora, estado) VALUES ('2026-4-19', '09:15:00', 'En juego');
INSERT INTO partida (fecha, hora, estado) VALUES ('2026-4-19', '08:15:00', 'Descanso');
INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES (1, '2026-4-19', '10:15:00', 'Entrando');
INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES 
(2, '2026-01-12', '10:00:00', 'Finalizada'),
(3, '2026-02-16', '18:00:00', 'Finalizada'),
(4, '2026-03-06', '20:00:00', 'Finalizada'),
(5, '2026-04-21', '15:30:00', 'Finalizada'),
(6, '2026-05-16', '17:00:00', 'Programada'),
(7, '2026-06-02', '13:00:00', 'Programada'),
(8, '2026-07-11', '19:45:00', 'Programada'),
(9, '2026-08-06', '21:00:00', 'Programada'),
(10, '2026-09-13', '14:00:00', 'Programada'),
(11, '2026-10-02', '16:00:00', 'Programada'),
(12, '2026-11-06', '11:00:00', 'Programada'),
(13, '2026-12-02', '22:00:00', 'Programada'),
(14, '2026-12-21', '09:00:00', 'Programada'),
(15, '2027-01-02', '12:00:00', 'Programada');
--7
INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion) VALUES (1, 1, '2026-04-19');
INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion) VALUES 
(2, 2, '2026-04-02'),
(3, 3, '2026-04-03'),
(4, 4, '2026-04-04'),
(5, 5, '2026-04-05'),
(6, 6, '2026-04-06'),
(7, 7, '2026-04-07'),
(8, 8, '2026-04-08'),
(9, 9, '2026-04-09'),
(10, 10, '2026-04-10'),
(11, 11, '2026-04-11'),
(12, 12, '2026-04-12'),
(13, 13, '2026-04-13'),
(14, 14, '2026-04-14'),
(15, 15, '2026-04-15');
--8
INSERT INTO premio (id_torneo, posicion, monto) VALUES (1, 1, 5000.50);
INSERT INTO premio (id_torneo, posicion, monto) VALUES 
(2, 1, 3000.00),
(3, 1, 4500.50),
(4, 1, 1200.00),
(5, 1, 2500.00),
(6, 1, 6000.00),
(7, 1, 850.00),
(8, 1, 1500.00),
(9, 1, 3200.00),
(10, 1, 950.00),
(11, 1, 2100.00),
(12, 1, 5500.00),
(13, 1, 4000.00),
(14, 1, 7000.00),
(15, 1, 10000.00);
-- 9
INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias) VALUES (1, 1, 15, 5, 10);
INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias) VALUES 
(2, 2, 18, 10, 5),
(3, 3, 30, 2, 8),
(4, 4, 12, 12, 4),
(5, 5, 22, 7, 9),
(6, 1, 15, 8, 12),
(7, 2, 28, 4, 6),
(8, 3, 10, 15, 2),
(9, 4, 35, 1, 5),
(10, 5, 20, 10, 10),
(11, 1, 5, 20, 1),
(12, 2, 24, 6, 8),
(13, 3, 19, 9, 11),
(14, 4, 27, 3, 7),
(15, 5, 33, 0, 10);
--10
INSERT INTO participacion (id_partida, id_equipo, resultado) VALUES (1, 1, 'Ganador');
INSERT INTO participacion (id_partida, id_equipo, resultado) VALUES 
(2, 2, 'Eliminado'),
(3, 3, 'Ganador'),
(4, 4, 'Finalista'),
(5, 5, 'Ganador'),
(6, 6, 'Pendiente'),
(7, 7, 'Eliminado'),
(8, 8, 'Ganador'),
(9, 9, 'Eliminado'),
(10, 10, 'Ganador'),
(11, 11, 'Eliminado'),
(12, 12, 'Ganador'),
(13, 13, 'Eliminado'),
(14, 14, 'Ganador'),
(15, 15, 'Pendiente');
-- 11
UPDATE jugador SET pais = 'Chile' WHERE id_jugador = 2;
-- 12
UPDATE jugador SET nickname = 'Ghost_Killer' WHERE id_jugador = 1;
-- 13
UPDATE equipo SET nombre = 'Bolivia Esports' WHERE id_equipo = 1;
-- 14
UPDATE juego SET genero = 'Battle Royale' WHERE id_juego = 1;
-- 15
UPDATE torneo SET fecha_inicio = '2026-06-01' WHERE id_torneo = 1;
-- 16
UPDATE partida SET estado = 'Finalizada' WHERE id_partida = 1;
--17
UPDATE premio SET monto = 7500.00 WHERE id_premio = 1;
-- 18
UPDATE estadistica SET kills = 30 WHERE id_estadistica = 1;
-- 19
INSERT INTO equipo (nombre, fecha_creacion) VALUES ('XG', '2026-02-15');
UPDATE participacion SET resultado = 'Eliminado' WHERE id_partida = 1 AND id_equipo = 1;
-- 20
UPDATE inscripcion SET fecha_inscripcion = '2026-04-20' WHERE id_equipo = 1 AND id_torneo = 1;
-- 21
SELECT * FROM jugador WHERE pais = 'Bolivia';
-- 22 
SELECT * FROM jugador WHERE pais <> 'Brasil';
-- 23.
SELECT * FROM equipo WHERE fecha_creacion > '2026-01-01';
-- 24
SELECT * FROM juego WHERE genero = 'Shooter';
-- 25
SELECT * FROM torneo WHERE fecha_inicio >= '2026-01-01' AND fecha_fin <= '2026-12-31';
-- 26
SELECT * FROM partida WHERE estado = 'Finalizada';
-- 27
SELECT * FROM premio WHERE monto > 1500.00;
-- 28
SELECT * FROM estadistica WHERE kills > 20;
-- 29
SELECT * FROM participacion WHERE resultado = 'Ganador';
-- 30.
SELECT * FROM inscripcion WHERE fecha_inscripcion BETWEEN '2026-04-01' AND '2026-04-30';

SELECT * FROM jugador_equipo;

