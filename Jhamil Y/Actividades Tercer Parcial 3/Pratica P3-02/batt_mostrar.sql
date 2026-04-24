-- 1
SELECT j.nombre, j.nickname, e.nombre AS equipo
FROM jugador j
JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
JOIN equipo e ON je.id_equipo = e.id_equipo;

-- 2
SELECT t.nombre AS torneo, j.nombre AS juego
FROM torneo t
JOIN juego j ON t.id_juego = j.id_juego;

-- 3 
SELECT p.id_partida, t.nombre AS torneo
FROM partida p
JOIN torneo t ON p.id_torneo = t.id_torneo;

-- 4 
SELECT e.*, j.nombre
FROM estadistica e
JOIN jugador j ON e.id_jugador = j.id_jugador;

-- 5 
SELECT p.monto, t.nombre AS torneo
FROM premio p
JOIN torneo t ON p.id_torneo = t.id_torneo;

-- 6
SELECT j.nickname, e.nombre AS equipo, je.fecha_union
FROM jugador j
JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
JOIN equipo e ON je.id_equipo = e.id_equipo;

-- 7
SELECT e.nombre AS equipo, t.nombre AS torneo
FROM inscripcion i
JOIN equipo e ON i.id_equipo = e.id_equipo
JOIN torneo t ON i.id_torneo = t.id_torneo;

-- 8
SELECT j.nickname, p.id_partida, e.kills, e.muertes
FROM estadistica e
JOIN jugador j ON e.id_jugador = j.id_jugador
JOIN partida p ON e.id_partida = p.id_partida;

-- 9
SELECT j.nickname, p.id_partida, e.kills, e.muertes
FROM estadistica e
JOIN jugador j ON e.id_jugador = j.id_jugador
JOIN partida p ON e.id_partida = p.id_partida;

-- 10 
SELECT e.nombre AS equipo, p.id_partida, pa.resultado
FROM participacion pa
JOIN equipo e ON pa.id_equipo = e.id_equipo
JOIN partida p ON pa.id_partida = p.id_partida;

-- 11
SELECT j.nombre, e.nombre AS equipo
FROM jugador j
LEFT JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
LEFT JOIN equipo e ON je.id_equipo = e.id_equipo;

-- 12
SELECT t.nombre AS torneo, p.monto
FROM torneo t
LEFT JOIN premio p ON t.id_torneo = p.id_torneo;

-- 13
SELECT j.nombre AS juego, t.nombre AS torneo
FROM juego j
LEFT JOIN torneo t ON j.id_juego = t.id_juego;

-- 14
SELECT p.id_partida, p.fecha, pa.id_equipo, pa.resultado
FROM partida p
LEFT JOIN participacion pa ON p.id_partida = pa.id_partida;

-- 15
SELECT e.nombre AS equipo, j.nombre AS jugador
FROM equipo e
LEFT JOIN jugador_equipo je ON e.id_equipo = je.id_equipo
LEFT JOIN jugador j ON je.id_jugador = j.id_jugador;

-- 16
SELECT p.id_premio, p.monto, t.nombre AS torneo
FROM premio p
LEFT JOIN torneo t ON p.id_torneo = t.id_torneo;

-- 17
SELECT j.nickname, e.nombre AS equipo, t.nombre AS torneo
FROM jugador j
JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
JOIN equipo e ON je.id_equipo = e.id_equipo
JOIN inscripcion i ON e.id_equipo = i.id_equipo
JOIN torneo t ON i.id_torneo = t.id_torneo;

-- 18
SELECT p.id_partida, t.nombre AS torneo, j.nombre AS juego, p.estado
FROM partida p
JOIN torneo t ON p.id_torneo = t.id_torneo
JOIN juego j ON t.id_juego = j.id_juego;

-- 19
SELECT j.nickname, eq.nombre AS equipo, e.id_partida, e.kills
FROM estadistica e
JOIN jugador j ON e.id_jugador = j.id_jugador
JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
JOIN equipo eq ON je.id_equipo = eq.id_equipo;

-- 20
SELECT e.nombre AS equipo, t.nombre AS torneo, p.monto
FROM participacion pa
JOIN equipo e ON pa.id_equipo = e.id_equipo
JOIN partida par ON pa.id_partida = par.id_partida
JOIN torneo t ON par.id_torneo = t.id_torneo
JOIN premio p ON t.id_torneo = p.id_torneo;
