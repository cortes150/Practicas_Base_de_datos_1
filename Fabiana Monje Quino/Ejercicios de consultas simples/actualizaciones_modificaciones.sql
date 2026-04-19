--ejercicio11--
UPDATE jugador
SET pais = 'Argentina'
WHERE id_jugador = 1;
--ejercicio12--
UPDATE jugador
SET nickname = 'nuevo_nick'
WHERE id_jugador = 2;
--ejercicio13--
UPDATE equipo
SET nombre = 'Team Renegados'
WHERE id_equipo = 1;
--ejercicio14--
UPDATE juego
SET genero = 'Estrategia'
WHERE id_juego = 1;
--ejercicio15--
UPDATE torneo
SET fecha_inicio = '2024-01-01'
WHERE id_torneo = 1;
--ejercicio16--
UPDATE partida
SET estado = 'en curso'
WHERE id_partida = 1;
--ejercicio17--
UPDATE premio
SET monto = 7500.00
WHERE id_premio = 1;
--ejercicio18--
UPDATE estadistica
SET kills = 20
WHERE id_estadistica = 1;
--ejercicio19--
UPDATE participacion
SET resultado = 'perdedor'
WHERE id_partida = 1 AND id_equipo = 1;
--ejercicio20--
UPDATE inscripcion
SET fecha_inscripcion = '2024-02-01'
WHERE id_inscripcion = 1;
