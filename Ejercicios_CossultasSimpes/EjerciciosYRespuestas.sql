
1.Mostrar los jugadores junto con su equipo.

SELECT j.nombre, e.nombre AS equipo
FROM jugador j
INNER JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
INNER JOIN equipo e ON je.id_equipo = e.id_equipo;

2.Mostrar los torneos junto con su juego.

SELECT t.nombre, j.nombre AS juego
FROM torneo t
INNER JOIN juego j ON t.id_juego = j.id_juego;

3.Mostrar las partidas con su torneo.

SELECT p.id_partida, t.nombre
FROM partida p
INNER JOIN torneo t ON p.id_torneo = t.id_torneo;

-- 4.Mostrar estadísticas con el nombre del jugador.

SELECT j.nombre, e.kills
FROM estadistica e
INNER JOIN jugador j ON e.id_jugador = j.id_jugador;

-- 5.Mostrar premios con su torneo.

SELECT t.nombre, p.monto
FROM premio p
INNER JOIN torneo t ON p.id_torneo = t.id_torneo;

-- 6.Mostrar los jugadores y el equipo al que pertenecen.

SELECT j.nombre, e.nombre
FROM jugador j
INNER JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
INNER JOIN equipo e ON je.id_equipo = e.id_equipo;

-- 7.Mostrar equipos inscritos en torneos.

SELECT e.nombre AS equipo, t.nombre AS torneo
FROM inscripcion i
INNER JOIN equipo e ON i.id_equipo = e.id_equipo
INNER JOIN torneo t ON i.id_torneo = t.id_torneo;

-- 8.Mostrar partidas con su torneo y juego.

SELECT p.id_partida, t.nombre AS torneo, j.nombre AS juego
FROM partida p
INNER JOIN torneo t ON p.id_torneo = t.id_torneo
INNER JOIN juego j ON t.id_juego = j.id_juego;

-- 9.Mostrar estadísticas con jugador y partida.

SELECT j.nombre, e.kills, p.id_partida
FROM estadistica e
INNER JOIN jugador j ON e.id_jugador = j.id_jugador
INNER JOIN partida p ON e.id_partida = p.id_partida;

-- 10.Mostrar participaciones con equipo y partida.

SELECT e.nombre, p.id_partida, pa.resultado
FROM participacion pa
INNER JOIN equipo e ON pa.id_equipo = e.id_equipo
INNER JOIN partida p ON pa.id_partida = p.id_partida;

-- 11.Mostrar todos los jugadores y sus equipos (aunque no tengan).

SELECT j.nombre, e.nombre
FROM jugador j
LEFT JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
LEFT JOIN equipo e ON je.id_equipo = e.id_equipo;

-- 12.Mostrar todos los torneos y sus premios.

SELECT t.nombre, p.monto
FROM torneo t
LEFT JOIN premio p ON t.id_torneo = p.id_torneo;

-- 13.Mostrar todos los juegos y sus torneos.

SELECT j.nombre, t.nombre
FROM juego j
LEFT JOIN torneo t ON j.id_juego = t.id_juego;

-- 14.Mostrar todas las partidas y participaciones.

SELECT p.id_partida, pa.id_equipo
FROM partida p
LEFT JOIN participacion pa ON p.id_partida = pa.id_partida;

-- 15.Mostrar todos los equipos y sus jugadores.

SELECT j.nombre, e.nombre
FROM jugador j
RIGHT JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
RIGHT JOIN equipo e ON je.id_equipo = e.id_equipo;

-- 16.Mostrar todos los premios y sus torneos.

SELECT t.nombre, p.monto
FROM torneo t
RIGHT JOIN premio p ON t.id_torneo = p.id_torneo;

-- 17.Mostrar jugadores, equipo y torneo en el que están inscritos.

SELECT j.nombre, e.nombre AS equipo, t.nombre AS torneo
FROM jugador j
INNER JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
INNER JOIN equipo e ON je.id_equipo = e.id_equipo
INNER JOIN inscripcion i ON e.id_equipo = i.id_equipo
INNER JOIN torneo t ON i.id_torneo = t.id_torneo;

-- 18.Mostrar partidas con torneo, juego y estado.

SELECT p.id_partida, t.nombre, j.nombre, p.estado
FROM partida p
INNER JOIN torneo t ON p.id_torneo = t.id_torneo
INNER JOIN juego j ON t.id_juego = j.id_juego;

-- 19.Mostrar estadísticas con jugador, equipo y partida.

SELECT j.nombre, e.nombre AS equipo, p.id_partida, es.kills
FROM estadistica es
INNER JOIN jugador j ON es.id_jugador = j.id_jugador
INNER JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
INNER JOIN equipo e ON je.id_equipo = e.id_equipo
INNER JOIN partida p ON es.id_partida = p.id_partida;

-- 20.Mostrar equipos, torneos y premios obtenidos.

SELECT e.nombre, t.nombre, p.monto
FROM equipo e
INNER JOIN inscripcion i ON e.id_equipo = i.id_equipo
INNER JOIN torneo t ON i.id_torneo = t.id_torneo
LEFT JOIN premio p ON t.id_torneo = p.id_torneo;