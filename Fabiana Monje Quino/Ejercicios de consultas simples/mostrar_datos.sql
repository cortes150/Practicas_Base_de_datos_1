--ejercicio21--
SELECT *
FROM jugador
WHERE pais = 'Bolivia';
--ejercicio22--
SELECT *
FROM jugador
WHERE pais <> 'Bolivia';
--ejercicio23--
SELECT *
FROM equipo
WHERE fecha_creacion > '2020-06-01';
--ejercicio24--
SELECT *
FROM juego
WHERE genero = 'FPS';
--ejercicio25--
SELECT *
FROM torneo
WHERE fecha_inicio BETWEEN '2022-01-01' AND '2022-12-31';
--ejercicio26--
SELECT *
FROM partida
WHERE estado = 'finalizado';
--ejercicio27--
SELECT *
FROM premio
WHERE monto > 1500;
--ejercicio28--
SELECT *
FROM estadistica
WHERE kills > 10;
--ejercicio29--
SELECT *
FROM participacion
WHERE resultado = 'ganador';
--ejercicio30--
SELECT *
FROM inscripcion
WHERE fecha_inscripcion BETWEEN '2022-01-01' AND '2022-12-31';