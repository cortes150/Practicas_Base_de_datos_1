# C) Consultas 1 al 30 
-- 1. Insertar un nuevo jugador con nombre, nickname, correo y país.
INSERT INTO jugador (nombre, nickname, email, pais) VALUES ('Nuevo Jugador', 'NewPro', 'new@mail.com', 'USA');
-- 2. Insertar otro jugador con datos diferentes.
INSERT INTO jugador (nombre, nickname, email, pais) VALUES ('Jugador Dos', 'ProTwo', 'two@mail.com', 'Brasil');
-- 3. Insertar un equipo con su nombre y fecha de creación.
INSERT INTO equipo (nombre, fecha_creacion) VALUES ('Team Z', '2026-04-01');
-- 4. Insertar un juego indicando su nombre y género.
INSERT INTO juego (nombre, genero) VALUES ('Test Game', 'Plataformas');
-- 5. Insertar un torneo asociado a un juego existente.
INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES ('Torneo Prueba', '2026-06-01', '2026-06-05', 16);
-- 6. Insertar una partida para un torneo existente con fecha, hora y estado.
INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES (16, '2026-06-01', '14:00:00', 'Programada');
-- 7. Registrar la inscripción de un equipo en un torneo.
INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion) VALUES (16, 16, CURDATE());
-- 8. Insertar un premio para un torneo indicando posición y monto.
INSERT INTO premio (id_torneo, posicion, monto) VALUES (16, 1, 1000.00);
-- 9. Insertar estadísticas de un jugador en una partida.
INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias) VALUES (1, 9, 12, 2, 5);
-- 10. Registrar la participación de un equipo en una partida con su resultado.
INSERT INTO participacion (id_partida, id_equipo, resultado) VALUES (9, 1, 'Pendiente');

-- 11. Actualizar el país de un jugador específico.
UPDATE jugador SET pais = 'Costa Rica' WHERE id_jugador = 1;
-- 12. Cambiar el nickname de un jugador.
UPDATE jugador SET nickname = 'ShadowMaster' WHERE id_jugador = 1;
-- 13. Modificar el nombre de un equipo.
UPDATE equipo SET nombre = 'Team Omega Pro' WHERE id_equipo = 1;
-- 14. Cambiar el género de un juego.
UPDATE juego SET genero = 'Shooter Táctico' WHERE id_juego = 1;
-- 15. Actualizar la fecha de inicio de un torneo.
UPDATE torneo SET fecha_inicio = '2026-07-01' WHERE id_torneo = 1;
-- 16. Cambiar el estado de una partida.
UPDATE partida SET estado = 'En curso' WHERE id_partida = 1;
-- 17. Modificar el monto de un premio.
UPDATE premio SET monto = 7500.00 WHERE id_premio = 1;
-- 18. Actualizar el número de kills de una estadística.
UPDATE estadistica SET kills = 20 WHERE id_estadistica = 1;
-- 19. Cambiar el resultado de una participación específica.
UPDATE participacion SET resultado = 'Ganador' WHERE id_partida = 1 AND id_equipo = 1;
-- 20. Modificar la fecha de inscripción de un equipo en un torneo.
UPDATE inscripcion SET fecha_inscripcion = '2025-11-01' WHERE id_inscripcion = 1;

-- 21. Mostrar todos los jugadores de un país específico.
SELECT * FROM jugador WHERE pais = 'México';
-- 22. Mostrar los jugadores que no pertenecen a un país determinado.
SELECT * FROM jugador WHERE pais != 'España';
-- 23. Listar los equipos creados después de una fecha específica.
SELECT * FROM equipo WHERE fecha_creacion > '2024-01-01';
-- 24. Mostrar los juegos de un género determinado.
SELECT * FROM juego WHERE genero = 'FPS Táctico';
-- 25. Listar los torneos que se realizan en un rango de fechas.
SELECT * FROM torneo WHERE fecha_inicio BETWEEN '2026-05-01' AND '2026-10-31';
-- 26. Mostrar todas las partidas que tengan un estado específico.
SELECT * FROM partida WHERE estado = 'Finalizada';
-- 27. Mostrar los premios cuyo monto sea mayor a un valor dado.
SELECT * FROM premio WHERE monto > 3000.00;
-- 28. Listar las estadísticas donde las kills superen un valor determinado.
SELECT * FROM estadistica WHERE kills > 15;
-- 29. Mostrar las participaciones con un resultado específico(ej. ganador).
SELECT * FROM participacion WHERE resultado = 'Ganador';
-- 30. Listar las inscripciones realizadas dentro de un rango de fechas.
SELECT * FROM inscripcion WHERE fecha_inscripcion BETWEEN '2025-10-01' AND '2026-03-31';