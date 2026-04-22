create database ejercicios_consim;
use ejercicios_consim; 
# 1. Mostrar los jugadores junto con su equipo  
SELECT 
    j.nombre AS jugador, 
    e.nombre AS equipo
FROM jugador j
JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
JOIN equipo e ON je.id_equipo = e.id_equipo; 

#Explicación: jugador_equipo es la tabla puente. Unimos jugador → jugador_equipo → equipo.


# 2. Mostrar los torneos junto con su juego
SELECT 
    t.nombre AS torneo, 
    j.nombre AS juego
FROM torneo t
JOIN juego j ON t.id_juego = j.id_juego; 

#Explicación: torneo guarda la clave id_juego. La unimos directamente con juego. 

# 3. Mostrar las partidas con su torneo
SELECT 
    p.id_partida, 
    p.fecha, 
    t.nombre AS torneo
FROM partida p
JOIN torneo t ON p.id_torneo = t.id_torneo; 

#Explicación: partida contiene id_torneo. Unimos para mostrar a qué torneo pertenece. 

# 4. Mostrar estadísticas con el nombre del jugador 
SELECT 
    j.nombre AS jugador, 
    s.kills, 
    s.muertes, 
    s.asistencias
FROM estadistica s
JOIN jugador j ON s.id_jugador = j.id_jugador;

#Explicación: estadistica tiene id_jugador. Lo vinculamos con jugador para sacar el nombre. 

# 5. Mostrar premios con su torneo 
SELECT 
    t.nombre AS torneo, 
    p.posicion, 
    p.monto
FROM premio p
JOIN torneo t ON p.id_torneo = t.id_torneo; 

#Explicación: Relación directa 1:N: premio → torneo mediante id_torneo. 

# 6. Mostrar los jugadores y el equipo al que pertenecen
SELECT 
    j.nombre AS jugador, 
    e.nombre AS equipo
FROM jugador j
JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
JOIN equipo e ON je.id_equipo = e.id_equipo; 

# 7. Mostrar equipos inscritos en torneos
SELECT 
    e.nombre AS equipo, 
    t.nombre AS torneo, 
    i.fecha_inscripcion
FROM equipo e
JOIN inscripcion i ON e.id_equipo = i.id_equipo
JOIN torneo t ON i.id_torneo = t.id_torneo; 

#Explicación: Cadena: equipo → inscripcion (tabla puente) → torneo.

# 8. Mostrar partidas con su torneo y juego 
SELECT 
    p.id_partida, 
    t.nombre AS torneo, 
    j.nombre AS juego, 
    p.estado
FROM partida p
JOIN torneo t ON p.id_torneo = t.id_torneo
JOIN juego j ON t.id_juego = j.id_juego; 

#Explicación: partida → torneo → juego. Unimos 3 tablas en cadena. 

# 9. Mostrar estadísticas con jugador y partida 
SELECT 
    j.nombre AS jugador, 
    p.id_partida, 
    s.kills, 
    s.muertes, 
    s.asistencias
FROM estadistica s
JOIN jugador j ON s.id_jugador = j.id_jugador
JOIN partida p ON s.id_partida = p.id_partida; 

#Explicación: estadistica tiene ambas claves foráneas (id_jugador, id_partida). Unimos ambas tablas. 

# 10. Mostrar participaciones con equipo y partida 
SELECT 
    e.nombre AS equipo, 
    p.id_partida, 
    pa.resultado
FROM participacion pa
JOIN equipo e ON pa.id_equipo = e.id_equipo
JOIN partida p ON pa.id_partida = p.id_partida; 

#Explicación: participacion es tabla puente entre equipo y partida. 

# 11. Mostrar todos los jugadores y sus equipos (aunque no tengan) 
SELECT 
    j.nombre AS jugador, 
    e.nombre AS equipo
FROM jugador j
LEFT JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
LEFT JOIN equipo e ON je.id_equipo = e.id_equipo; 

#Explicación: Usamos LEFT JOIN para que aparezcan todos los jugadores, incluso si no tienen registro en jugador_equipo.

# 12. Mostrar todos los torneos y sus premios 
SELECT 
    t.nombre AS torneo, 
    p.posicion, 
    p.monto
FROM torneo t
LEFT JOIN premio p ON t.id_torneo = p.id_torneo; 

#Explicación: LEFT JOIN desde torneo garantiza que se muestren torneos sin premios asignados.

# 13. Mostrar todos los juegos y sus torneos
SELECT 
    j.nombre AS juego, 
    t.nombre AS torneo
FROM juego j
LEFT JOIN torneo t ON j.id_juego = t.id_juego; 

#Explicación: Igual que el anterior. LEFT JOIN conserva juegos que aún no tienen torneos creados.

# 14. Mostrar todas las partidas y participaciones
SELECT 
    p.id_partida, 
    e.nombre AS equipo, 
    pa.resultado
FROM partida p
LEFT JOIN participacion pa ON p.id_partida = pa.id_partida
LEFT JOIN equipo e ON pa.id_equipo = e.id_equipo; 

#Explicación: Mostramos partidas aunque no tengan equipos inscritos aún (LEFT JOIN).

# 15. Mostrar todos los equipos y sus jugadores
SELECT 
    e.nombre AS equipo, 
    j.nombre AS jugador
FROM equipo e
LEFT JOIN jugador_equipo je ON e.id_equipo = je.id_equipo
LEFT JOIN jugador j ON je.id_jugador = j.id_jugador; 

#Explicación: LEFT JOIN desde equipo muestra equipos vacíos (sin jugadores asignados). 

# 16. Mostrar todos los premios y sus torneos
SELECT 
    p.posicion, 
    p.monto, 
    t.nombre AS torneo
FROM premio p
JOIN torneo t ON p.id_torneo = t.id_torneo; 

#Explicación: Como todo premio pertenece obligatoriamente a un torneo (id_torneo es FK), JOIN normal es suficiente.

# 17. Mostrar jugadores, equipo y torneo en el que están inscritos 
SELECT 
    j.nombre AS jugador, 
    e.nombre AS equipo, 
    t.nombre AS torneo
FROM jugador j
JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
JOIN equipo e ON je.id_equipo = e.id_equipo
JOIN inscripcion i ON e.id_equipo = i.id_equipo
JOIN torneo t ON i.id_torneo = t.id_torneo;

#Explicación: Cadena de 5 tablas: jugador → jugador_equipo → equipo → inscripcion → torneo.

# 18. Mostrar partidas con torneo, juego y estado
SELECT 
    p.id_partida, 
    t.nombre AS torneo, 
    j.nombre AS juego, 
    p.estado
FROM partida p
JOIN torneo t ON p.id_torneo = t.id_torneo
JOIN juego j ON t.id_juego = j.id_juego;

#Explicación: Similar al #8, pero destacando explícitamente el campo estado de partida.

# 19. Mostrar estadísticas con jugador, equipo y partida
SELECT 
    j.nombre AS jugador, 
    e.nombre AS equipo, 
    p.id_partida, 
    s.kills, 
    s.muertes, 
    s.asistencias
FROM estadistica s
JOIN jugador j ON s.id_jugador = j.id_jugador
JOIN jugador_equipo je ON j.id_jugador = je.id_jugador
JOIN equipo e ON je.id_equipo = e.id_equipo
JOIN partida p ON s.id_partida = p.id_partida; 

#Explicación: estadistica → jugador → jugador_equipo → equipo. Unimos partida por separado para mostrar el ID de la partida.

# 20. Mostrar equipos, torneos y premios obtenidos
SELECT 
    e.nombre AS equipo, 
    t.nombre AS torneo, 
    pr.posicion, 
    pr.monto
FROM equipo e
JOIN inscripcion i ON e.id_equipo = i.id_equipo
JOIN torneo t ON i.id_torneo = t.id_torneo
JOIN premio pr ON t.id_torneo = pr.id_torneo;  

#Explicación: equipo → inscripcion → torneo → premio. Muestra los premios disponibles en los torneos donde el equipo se inscribió. 

