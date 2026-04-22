-- 1.Mostrar los jugadores junto con su equipo.
select j.nombre as nombre_jugador, e.nombre as equipo
from jugador j 
inner join jugador_equipo je on j.id_jugador = je.id_jugador
inner join equipo e on e.id_equipo = je.id_equipo;

-- 2.Mostrar los torneos junto con su juego.
select t.nombre as torneos, j.nombre as juegos
from torneo t
inner join juego j on  t.id_juego = j.id_juego;

-- 3.Mostrar las partidas con su torneo.
select p.id_partida as numero_partida, p.estado, t.nombre as torneo
from partida p
inner join torneo t on p.id_torneo = t.id_torneo;

-- 4.Mostrar estadísticas con el nombre del jugador.
select j.nombre as nombre_jugador, e.kills,e.muertes,e.asistencias
from estadistica e
inner join jugador j on e.id_jugador = j.id_jugador;

-- 5.Mostrar premios con su torneo.
select t.nombre as torneo, p.posicion,p.monto
from premio p
inner join torneo t on p.id_torneo = t.id_torneo;

-- 6.Mostrar los jugadores y el equipo al que pertenecen.
select j.nombre as nombre_jugador, e.nombre as equipo
from jugador j
inner join jugador_equipo je on j.id_jugador = je.id_jugador
inner join equipo e on e.id_equipo = je.id_equipo;

-- 7.Mostrar equipos inscritos en torneos.
select e.nombre as equipo,i.fecha_inscripcion,t.nombre as torneo
from equipo e
inner join inscripcion i on e.id_equipo = i.id_equipo
inner join torneo t on t.id_torneo = i.id_torneo;

-- 8.Mostrar partidas con su torneo y juego.
select p.id_partida as numero_partida, t.nombre as torneos, j.nombre as juegos
from partida p
inner join torneo t on p.id_torneo = t.id_torneo
inner join juego j on j.id_juego = t.id_juego; 

-- 9.Mostrar estadísticas con jugador y partida.
select j.nombre as jugador, e.kills,e.muertes,e.asistencias, p.id_partida as numero_partida
from jugador j
inner join estadistica e on j.id_jugador = e.id_jugador
inner join partida p on p.id_partida = e.id_partida;

-- 10.Mostrar participaciones con equipo y partida.
select p.id_partida as numero_partida, e.nombre as equipo, par.resultado
from participacion par
inner join partida p on p.id_partida = par.id_partida
inner join equipo e on e.id_equipo = par.id_equipo;

-- 11.Mostrar todos los jugadores y sus equipos (aunque no tengan).
insert jugador(nombre,nickname,email,pais)values('Mauricio','Rivan','riv@gmail.com','Bolivia');
select j.nombre as jugador, e.nombre as equipo
from jugador j
left join jugador_equipo je on j.id_jugador = je.id_jugador
left join equipo e on je.id_equipo = e.id_equipo ;

-- 12.Mostrar todos los torneos y sus premios.
select * from torneo;

-- 13.Mostrar todos los juegos y sus torneos.


-- 14.Mostrar todas las partidas y participaciones.


-- 15.Mostrar todos los equipos y sus jugadores.


-- 16.Mostrar todos los premios y sus torneos.


-- 17.Mostrar jugadores, equipo y torneo en el que están inscritos.


-- 18.Mostrar partidas con torneo, juego y estado.


-- 19.Mostrar estadísticas con jugador, equipo y partida.


-- 20.Mostrar equipos, torneos y premios obtenidos.

