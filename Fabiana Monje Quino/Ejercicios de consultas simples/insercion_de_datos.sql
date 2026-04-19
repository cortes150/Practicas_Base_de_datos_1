--ejercicio1--
INSERT INTO jugador (nombre, nickname, email, pais)
VALUES ('Ricardo Flores', 'riflo', 'ricardo@mail.com', 'Bolivia');
--ejercicio2--
INSERT INTO jugador (nombre, nickname, email, pais)
VALUES ('Camila Ortiz', 'camort', 'camila@mail.com', 'Chile');
--ejercicio3--
INSERT INTO equipo (nombre, fecha_creacion)
VALUES ('Team Eclipse', '2022-05-15');
--ejercicio4--
INSERT INTO juego (nombre, genero)
VALUES ('Tekken 7', 'Pelea');
--ejercicio5--
INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego)
VALUES ('Torneo Especial', '2023-06-01', '2023-06-10', 1);
--ejercicio6--
INSERT INTO partida (id_torneo, fecha, hora, estado)
VALUES (1, '2023-06-02', '15:00', 'programado');
--ejercicio7--
INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion)
VALUES (1, 1, '2023-05-20');
--ejercicio8--
INSERT INTO premio (id_torneo, posicion, monto)
VALUES (1, 1, 5000.00);
--ejercicio9--
INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias)
VALUES (1, 1, 15, 3, 7);
--ejercicio10--
INSERT INTO participacion (id_partida, id_equipo, resultado)
VALUES (1, 2, 'ganador');