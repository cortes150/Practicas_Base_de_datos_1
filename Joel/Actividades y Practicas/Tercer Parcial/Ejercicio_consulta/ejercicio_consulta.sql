
CREATE DATABASE battlezone_db; 
USE battlezone_db; 

-- CREACIÓN DE TABLAS
CREATE TABLE jugador ( 
    id_jugador INT AUTO_INCREMENT PRIMARY KEY,     nombre VARCHAR(100),     nickname VARCHAR(50) UNIQUE,     email VARCHAR(100),     pais VARCHAR(50) 
); 

CREATE TABLE equipo ( 
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,     nombre VARCHAR(100),     fecha_creacion DATE 
); 

CREATE TABLE jugador_equipo (     id_jugador INT,     id_equipo INT,     fecha_union DATE, 
    PRIMARY KEY (id_jugador, id_equipo), 
    FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador), 
    FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo) 
); 

CREATE TABLE juego ( 
    id_juego INT AUTO_INCREMENT PRIMARY KEY,     nombre VARCHAR(100),     genero VARCHAR(50) 
); 

CREATE TABLE torneo ( 
    id_torneo INT AUTO_INCREMENT PRIMARY KEY,     nombre VARCHAR(100),     fecha_inicio DATE,     fecha_fin DATE,     id_juego INT, 
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego) 
); 

CREATE TABLE partida ( 
    id_partida INT AUTO_INCREMENT PRIMARY KEY,     id_torneo INT,     fecha DATE,     hora TIME,     estado VARCHAR(50), 
    FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo) 
); 

CREATE TABLE participacion (     id_partida INT,     id_equipo INT,     resultado VARCHAR(50), 
    PRIMARY KEY (id_partida, id_equipo), 
    FOREIGN KEY (id_partida) REFERENCES partida(id_partida), 
    FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo) 
); 

CREATE TABLE estadistica ( 
    id_estadistica INT AUTO_INCREMENT PRIMARY KEY,     id_jugador INT,     id_partida INT,     kills INT,     muertes INT,     asistencias INT, 
    FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador), 
    FOREIGN KEY (id_partida) REFERENCES partida(id_partida) 
); 

CREATE TABLE premio ( 
    id_premio INT AUTO_INCREMENT PRIMARY KEY,     id_torneo INT,     posicion INT,     monto DECIMAL(10,2), 
    FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo) 
); 

CREATE TABLE inscripcion ( 
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,     id_equipo INT,     id_torneo INT,     fecha_inscripcion DATE, 
    FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo), 
    FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo) 
); 

INSERT INTO juego (nombre, genero) VALUES 
('League of Legends', 'MOBA'), ('Valorant', 'FPS'), ('Dota 2', 'MOBA'), 
('Counter-Strike 2', 'FPS'), ('Fortnite', 'Battle Royale'), ('Rocket League', 'Deportes'), 
('Street Fighter 6', 'Lucha'), ('Apex Legends', 'Battle Royale'), ('FIFA 24', 'Deportes'), 
('Starcraft II', 'Estrategia'), ('Overwatch 2', 'Hero Shooter'), ('Tekken 8', 'Lucha'), 
('Halo Infinite', 'FPS'), ('Rainbow Six Siege', 'Táctico'), ('Mortal Kombat 1', 'Lucha');


-- 4. Insertar un juego
INSERT INTO juego (nombre, genero) VALUES ('Super Mario Bros Wonder', 'Plataformas');

INSERT INTO jugador (nombre, nickname, email, pais) VALUES 
('Carlos Perez', 'CarlitosWay', 'carlos@mail.com', 'Bolivia'),
('Ana Garcia', 'Aniquila', 'ana@mail.com', 'Argentina'),
('Joel Mamani', 'JMSys', 'joel@mail.com', 'Bolivia'),
('Luis Rojas', 'DragonBorn', 'luis@mail.com', 'Chile'),
('Maria Lopez', 'MarySky', 'maria@mail.com', 'Perú'),
('Kevin Soto', 'KevKiller', 'kevin@mail.com', 'Bolivia'),
('Sara Ruiz', 'Saritha', 'sara@mail.com', 'Colombia'),
('Diego Arce', 'DarkKnight', 'diego@mail.com', 'México'),
('Elena Paz', 'Elenix', 'elena@mail.com', 'Bolivia'),
('Bruno Diaz', 'BatPlayer', 'bruno@mail.com', 'España'),
('Hugo Vila', 'Huguito', 'hugo@mail.com', 'Uruguay'),
('Ines Toro', 'Inesica', 'ines@mail.com', 'Ecuador'),
('Raul Gil', 'Rulo', 'raul@mail.com', 'Paraguay'),
('Tania Sol', 'Tanita', 'tania@mail.com', 'Bolivia'),
('Omar Vera', 'Overa', 'omar@mail.com', 'Chile');

-- 1. Insertar un nuevo jugador
INSERT INTO jugador (nombre, nickname, email, pais) VALUES ('Roberto Gomez', 'ChespiritoGamer', 'roberto@mail.com', 'México');

-- 2. Insertar otro jugador con datos diferentes
INSERT INTO jugador (nombre, nickname, email, pais) VALUES ('Mariana Torres', 'LadySniper', 'mariana.t@mail.com', 'Bolivia');

INSERT INTO equipo (nombre, fecha_creacion) VALUES 
('Team Illimani', '2023-01-10'), ('Andes Esports', '2023-02-15'), ('Llama Gamers', '2023-03-20'), 
('Titanes LP', '2023-04-05'), ('Condor Strike', '2023-05-12'), ('Real Gaming', '2023-06-18'), 
('Cyber Squad', '2023-07-25'), ('Elite Team', '2023-08-30'), ('Shadow Hunters', '2023-09-05'), 
('Alpha Kings', '2023-10-10'), ('Omega Clan', '2023-11-15'), ('Phoenix Pro', '2023-12-20'), 
('Vipers', '2024-01-05'), ('Dragons Inc', '2024-01-20'), ('Neon Stars', '2024-02-10');

-- 3. Insertar un equipo
INSERT INTO equipo (nombre, fecha_creacion) VALUES ('La Paz Guardians', '2026-04-20');


INSERT INTO jugador_equipo (id_jugador, id_equipo, fecha_union) VALUES 
(1,1,'2023-01-11'), (2,1,'2023-01-12'), (3,2,'2023-02-16'), (4,2,'2023-02-17'),
(5,3,'2023-03-21'), (6,3,'2023-03-22'), (7,4,'2023-04-06'), (8,4,'2023-04-07'),
(9,5,'2023-05-13'), (10,5,'2023-05-14'), (11,6,'2023-06-19'), (12,7,'2023-07-26'),
(13,8,'2023-08-31'), (14,9,'2023-09-06'), (15,10,'2023-10-11');

INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES 
('Copa Verano', '2024-01-01', '2024-01-15', 1), ('Battle Zone Pro', '2024-02-01', '2024-02-10', 2),
('Invitacional Sopocachi', '2024-03-01', '2024-03-05', 3), ('Torneo Relampago', '2024-03-10', '2024-03-12', 4),
('Masters Bolivia', '2024-04-01', '2024-04-20', 5), ('Challenger Series', '2024-05-01', '2024-05-15', 6),
('King of Hill', '2024-06-01', '2024-06-05', 7), ('Cyber Cup', '2024-07-01', '2024-07-10', 8),
('Gamer Fest', '2024-08-01', '2024-08-05', 9), ('Ultimate Warrior', '2024-09-01', '2024-09-15', 10),
('E-Open', '2024-10-01', '2024-10-10', 11), ('Winter Clash', '2024-11-01', '2024-11-05', 12),
('Global Arena', '2024-12-01', '2024-12-20', 13), ('New Year Cup', '2024-12-25', '2025-01-05', 14),
('Pro League 2025', '2025-01-15', '2025-02-15', 15);

-- 5. Insertar un torneo asociado al juego anterior 
INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES ('Copa Chiti Gamer', '2026-05-10', '2026-05-15', 16);

INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES 
(1, '2024-01-02', '14:00:00', 'Finalizado'), (1, '2024-01-03', '16:00:00', 'Finalizado'),
(2, '2024-02-02', '18:00:00', 'Finalizado'), (2, '2024-02-03', '20:00:00', 'Pendiente'),
(3, '2024-03-02', '15:00:00', 'Finalizado'), (4, '2024-03-11', '10:00:00', 'Cancelado'),
(5, '2024-04-05', '21:00:00', 'Finalizado'), (6, '2024-05-02', '14:00:00', 'Finalizado'),
(7, '2024-06-02', '19:00:00', 'Finalizado'), (8, '2024-07-02', '17:00:00', 'Pendiente'),
(9, '2024-08-02', '22:00:00', 'Finalizado'), (10, '2024-09-05', '13:00:00', 'Finalizado'),
(11, '2024-10-02', '16:00:00', 'Finalizado'), (12, '2024-11-02', '20:00:00', 'Finalizado'),
(13, '2024-12-05', '18:00:00', 'Pendiente');

-- 6. Insertar una partida para el torneo anterior 
INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES (16, '2026-05-11', '14:00:00', 'Programada');

INSERT INTO participacion (id_partida, id_equipo, resultado) VALUES 
(1,1,'Ganador'), (1,2,'Perdedor'), (2,3,'Ganador'), (2,4,'Perdedor'),
(3,5,'Ganador'), (3,6,'Perdedor'), (5,7,'Empate'), (5,8,'Empate'),
(7,9,'Ganador'), (7,10,'Perdedor'), (8,11,'Ganador'), (9,12,'Ganador'),
(11,13,'Ganador'), (12,14,'Ganador'), (14,15,'Pendiente');

-- 10. Registrar participación de un equipo en una partida
INSERT INTO participacion (id_partida, id_equipo, resultado) VALUES (14, 16, 'Ganador');

INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias) VALUES 
(1,1,10,2,5), (2,1,15,5,8), (3,2,12,3,4), (4,2,8,10,2),
(5,3,20,1,10), (6,3,5,15,3), (7,5,11,11,0), (8,5,10,12,5),
(9,7,14,4,6), (10,7,2,18,1), (1,8,25,0,5), (3,9,18,7,9),
(5,11,9,9,12), (11,12,13,5,4), (15,14,0,0,0);

-- 9. Insertar estadísticas de un jugador en una partida
INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias) VALUES (16, 14, 15, 2, 10);

INSERT INTO premio (id_torneo, posicion, monto) VALUES 
(1,1,500.00), (1,2,250.00), (2,1,1000.00), (2,2,500.00), (3,1,300.00),
(4,1,150.00), (5,1,2000.00), (6,1,800.00), (7,1,400.00), (8,1,600.00),
(9,1,350.00), (10,1,1200.00), (11,1,750.00), (12,1,550.00), (13,1,2500.00);

-- 8. Insertar un premio para un torneo
INSERT INTO premio (id_torneo, posicion, monto) VALUES (16, 1, 5000.00);

INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion) VALUES 
(1,1,'2023-12-20'), (2,1,'2023-12-21'), (3,2,'2024-01-25'), (4,2,'2024-01-26'),
(5,3,'2024-02-20'), (6,3,'2024-02-21'), (7,5,'2024-03-25'), (8,5,'2024-03-26'),
(9,7,'2024-05-20'), (10,7,'2024-05-21'), (11,8,'2024-06-25'), (12,9,'2024-07-20'),
(13,11,'2024-09-25'), (14,12,'2024-10-20'), (15,13,'2024-11-25');

-- 7. Registrar inscripción de un equipo en un torneo
INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion) VALUES (16, 16, '2026-04-21');




-- 11. Actualizar el país de un jugador específico
UPDATE jugador SET pais = 'España' WHERE id_jugador = 1;

-- 12. Cambiar el nickname de un jugador
UPDATE jugador SET nickname = 'Elite_Carlitos' WHERE id_jugador = 1;

-- 13. Modificar el nombre de un equipo
UPDATE equipo SET nombre = 'Illimani Pro Team' WHERE id_equipo = 1;

-- 14. Cambiar el género de un juego
UPDATE juego SET genero = 'FPS Competitivo' WHERE id_juego = 2;

-- 15. Actualizar la fecha de inicio de un torneo
UPDATE torneo SET fecha_inicio = '2024-01-05' WHERE id_torneo = 1;

-- 16. Cambiar el estado de una partida
UPDATE partida SET estado = 'En Juego' WHERE id_partida = 4;

-- 17. Modificar el monto de un premio
UPDATE premio SET monto = 600.00 WHERE id_premio = 1;

-- 18. Actualizar el número de kills de una estadística
UPDATE estadistica SET kills = 12 WHERE id_estadistica = 1;

-- 19. Cambiar el resultado de una participación
UPDATE participacion SET resultado = 'Descalificado' WHERE id_partida = 5 AND id_equipo = 7;

-- 20. Modificar la fecha de inscripción
UPDATE inscripcion SET fecha_inscripcion = '2023-12-15' WHERE id_inscripcion = 1;

-- 21. Mostrar todos los jugadores de un país específico
SELECT * FROM jugador WHERE pais = 'Bolivia';

-- 22. Mostrar jugadores que no pertenecen a un país determinado
SELECT * FROM jugador WHERE pais <> 'Argentina';

-- 23. Listar equipos creados después de una fecha específica
SELECT * FROM equipo WHERE fecha_creacion > '2023-06-01';

-- 24. Mostrar juegos de un género determinado
SELECT * FROM juego WHERE genero = 'MOBA';

-- 25. Listar torneos en un rango de fechas
SELECT * FROM torneo WHERE fecha_inicio BETWEEN '2024-01-01' AND '2024-06-30';

-- 26. Mostrar partidas con un estado específico
SELECT * FROM partida WHERE estado = 'Finalizado';

-- 27. Mostrar premios con monto mayor a un valor dado
SELECT * FROM premio WHERE monto > 1000;

-- 28. Listar estadísticas donde kills superen un valor determinado
SELECT * FROM estadistica WHERE kills > 15;

-- 29. Mostrar participaciones con resultado específico
SELECT * FROM participacion WHERE resultado = 'Ganador';

-- 30. Listar inscripciones realizadas en un rango de fechas
SELECT * FROM inscripcion WHERE fecha_inscripcion BETWEEN '2024-01-01' AND '2024-12-31';