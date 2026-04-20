-- #1 Insertar un nuevo jugador
INSERT INTO jugador (nombre, nickname, email, pais) VALUES
('Elias Choque','eliasC','elias@gmail.com','Bolivia');

-- #2 Insertar otro jugador
INSERT INTO jugador (nombre, nickname, email, pais) VALUES 
('Ruben Mamani','rubenM','ruben@gmail.com','Peru');

-- #3 Insertar un equipo
INSERT INTO equipo (nombre, fecha_creacion) VALUES 
('Los Guerreros Andinos','2022-05-10');

-- #4 Insertar un juego
INSERT INTO juego (nombre, genero) VALUES 
('Batalla del Altiplano','Estrategia');

-- #5 Insertar un torneo
INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES 
('Torneo Supremo','2024-04-01','2024-04-10',1);

-- #6 Insertar una partida
INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES 
(1,'2024-04-02','15:00:00','pendiente');

-- #7 Inscripción de equipo
INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion) VALUES 
(1,1,'2024-03-01');

-- #8 Insertar premio
INSERT INTO premio (id_torneo, posicion, monto) VALUES 
(1,1,5000);

-- #9 Insertar estadística
INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias) VALUES 
(1,1,12,3,5);

-- #10 Participación
INSERT INTO participacion (id_partida, id_equipo, resultado) VALUES
 (1,1,'ganador');

-- #11 Actualizar país
UPDATE jugador
SET pais='Chile' 
WHERE id_jugador=1;

-- #12 Cambiar nickname
UPDATE jugador 
SET nickname='nuevoNickBol' 
WHERE id_jugador=2;

-- #13 Modificar equipo
UPDATE equipo 
SET nombre='Andes Elite' 
WHERE id_equipo=1;

-- #14 Cambiar género juego
UPDATE juego 
SET genero='Acción' 
WHERE id_juego=1;

-- #15 Actualizar fecha torneo
UPDATE torneo 
SET fecha_inicio='2024-04-05' 
WHERE id_torneo=1;

-- #16 Cambiar estado partida
UPDATE partida 
SET estado='finalizado' 
WHERE id_partida=1;

-- #17 Modificar premio
UPDATE premio 
SET monto=6000 
WHERE id_premio=1;

-- #18 Actualizar kills
UPDATE estadistica 
SET kills=20 
WHERE id_estadistica=1;

-- #19 Cambiar resultado
UPDATE participacion 
SET resultado='empate' 
WHERE id_partida=1 AND id_equipo=1;

-- #20 Modificar inscripción
UPDATE inscripcion 
SET fecha_inscripcion='2024-02-20' 
WHERE id_inscripcion=1;

-- #21 Jugadores de un país
SELECT * FROM jugador 
WHERE pais='Bolivia';

-- #22 Jugadores que no son de Bolivia
SELECT * FROM jugador 
WHERE pais <> 'Bolivia';

-- #23 Equipos después de fecha
SELECT * FROM equipo 
WHERE fecha_creacion > '2021-01-01';

-- #24 Juegos por género
SELECT * FROM juego 
WHERE genero='FPS';

-- #25 Torneos en rango
SELECT * FROM torneo 
WHERE fecha_inicio BETWEEN '2024-01-01' AND '2024-03-01';

-- #26 Partidas por estado
SELECT * FROM partida 
WHERE estado='finalizado';

-- #27 Premios mayores
SELECT * FROM premio 
WHERE monto > 1500;

-- #28 Estadísticas con kills altas
SELECT * FROM estadistica 
WHERE kills > 10;

-- #29 Participaciones ganadoras
SELECT * FROM participacion 
WHERE resultado='ganador';

-- #30 Inscripciones en rango
SELECT * FROM inscripcion 
WHERE fecha_inscripcion BETWEEN '2023-12-01' AND '2024-01-31';





update participacion
set resultado= 'perdedor'
where id_partida=10;