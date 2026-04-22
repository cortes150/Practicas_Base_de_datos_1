
-- 1.Mostrar los jugadores junto con su equipo.
select j.nombre as Nombre_jugador, e1.nombre as nombre_equipo
from jugador j

inner join jugador_equipo je 
on j.id_jugador = je.id_jugador

inner join equipo e1
on je.id_equipo = e1.id_equipo;

-- 2.Mostrar los torneos junto con su juego.
select t.nombre as nombre_torneo, j.nombre as nombre_juego
from torneo t
inner join juego j
on t.id_juego = j.id_juego;

-- 3.Mostrar las partidas con su torneo.
select p.fecha as fecha_partida, p.hora as hora_partida, p.estado as estado_partida, t.nombre as nombre_torneo
from partida p
inner join torneo t 
on p.id_torneo = t.id_torneo;

-- 4.Mostrar estadísticas con el nombre del jugador.
select j.nombre as nombre_jugador, e.kills, e.muertes, e.asistencias
from estadistica e
inner join jugador j 
on e.id_jugador = j.id_jugador;

-- 5.Mostrar premios con su torneo.
select t.nombre as Nombre_torneo, p.posicion, p.monto
from premio p
inner join torneo t 
on p.id_torneo = t.id_torneo;

-- 6.Mostrar los jugadores y el equipo al que pertenecen.
select j.nombre as Nombre_jugador, e1.nombre as nombre_equipo
from jugador j

inner join jugador_equipo je 
on j.id_jugador = je.id_jugador

inner join equipo e1
on je.id_equipo = e1.id_equipo;

-- 7.Mostrar equipos inscritos en torneos.
select e.nombre as Nombre_equipo, t.nombre as Torneo
from equipo e 
inner join inscripcion i
on e.id_equipo = i.id_equipo
inner join torneo t 
on t.id_torneo = i.id_torneo;

-- 8.Mostrar partidas con su torneo y juego.
-- , p.fecha as fecha_partida, p.hora as hora_partida, p.estado as estado_partida
select p.id_partida as partida, t.nombre as nombre_torneo, j.nombre as nombre_juego
from partida p
inner join torneo t 
on p.id_torneo = t.id_torneo
inner join juego j 
on t.id_juego = J.id_juego;

-- 9.Mostrar estadísticas con jugador y partida.
select e.kills, e.muertes, e.asistencias, j.nombre, p.id_partida as partida
from estadistica e 
inner join partida p
on e.id_partida = p.id_partida
inner join jugador j 
on j.id_jugador = e.id_jugador;

-- 10.Mostrar participaciones con equipo y partida.
select p.resultado, e.nombre as nombre_equipo, pa.id_partida
from participacion p
inner join equipo e
on p.id_equipo = e.id_equipo
inner join partida pa 
on p.id_partida = pa.id_partida;

-- 11.Mostrar todos los jugadores y sus equipos (aunque no tengan).
select j.nombre as Nombre_jugador, e1.nombre as nombre_equipo
from jugador j
left join jugador_equipo je 
on j.id_jugador = je.id_jugador
left join equipo e1
on je.id_equipo = e1.id_equipo;

-- 12.Mostrar todos los torneos y sus premios.
select t.nombre as torneo, p.posicion, p.monto
from torneo t 
left join premio p
on t.id_torneo = p.id_torneo;

-- 13.Mostrar todos los juegos y sus torneos.
select j.nombre as nombre_juego, t.nombre as nombre_torneo
from juego j
left join torneo t
on t.id_juego = j.id_juego;

-- 14.Mostrar todas las partidas y participaciones.
select p.id_partida as partida, pa.resultado
from partida p
left join participacion pa 
on p.id_partida = pa.id_partida;

-- 15.Mostrar todos los equipos y sus jugadores.
select  e1.nombre as nombre_equipo, j.nombre as Nombre_jugador
from equipo e1
left join jugador_equipo je 
on je.id_equipo = e1.id_equipo
left join jugador j
on j.id_jugador = je.id_jugador;

-- 16.Mostrar todos los premios y sus torneos.
select p.posicion, p.monto, t.nombre
from premio p
left join torneo t
on p.id_torneo = t.id_torneo;

-- 17.Mostrar jugadores, equipo y torneo en el que están inscritos.
select j.nombre as Nombre_jugador, e.nombre as nombre_equipo, t.nombre as torneo
from jugador j 
left join jugador_equipo je
on j.id_jugador = je.id_jugador
left join equipo e
on je.id_equipo = e.id_equipo
left join inscripcion i 
on e.id_equipo = i.id_equipo
left join torneo t
on i.id_torneo = t.id_torneo;

-- 18.Mostrar partidas con torneo, juego y estado.
select p.id_partida as partida, t.nombre as Nombre_torneo, j.nombre as Nombre_juego, p.estado
from partida p 
inner join torneo t
on p.id_torneo = t.id_torneo
inner join juego j
on t.id_juego = j.id_juego;

-- 19.Mostrar estadísticas con jugador, equipo y partida.
select e.kills, e.muertes, e.asistencias, j.nombre as nombre_jugador, e1.nombre as nombre_equipo, p.id_partida as partida
from estadistica e
inner join jugador j 
on e.id_jugador = j.id_jugador
inner join jugador_equipo je
on j.id_jugador = je.id_jugador
inner join equipo e1
on je.id_equipo = e1.id_equipo
inner join partida p 
on p.id_partida = e.id_partida;

-- 20.Mostrar equipos, torneos y premios obtenidos.
select e.nombre as nombre_equipo, t.nombre as nombre_torneo, p.posicion as posicion_premio, p.monto as monto_premio
from equipo e
inner join inscripcion i
on e.id_equipo = i.id_equipo
inner join torneo t
on i.id_torneo = t.id_torneo
inner join premio p 
on p.id_torneo = t.id_torneo;
