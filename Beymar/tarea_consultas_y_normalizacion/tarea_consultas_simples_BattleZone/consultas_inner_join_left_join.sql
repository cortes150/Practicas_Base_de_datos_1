select * from estadistica e
inner join jugador j
on e.id_jugador = j.id_jugador;
-- 1. Mostrar los jugadores junto con su equipo.
select ju.nombre as jugador, eq.nombre as equipo
from jugador ju
inner join jugador_equipo ju_eq
on ju.id_jugador = ju_eq.id_jugador
inner join equipo eq
on eq.id_equipo = eq.id_equipo;
-- 2. Mostrar los torneos junto con su juego.
select tor.nombre as torneo, ju.nombre as juego
from torneo tor
inner join juego ju
on tor.id_juego = ju.id_juego;
-- 3. Mostrar las partidas con su torneo.
select pa.id_partida as partida, tor.nombre as torneo
from partida pa
inner join torneo tor
on pa.id_torneo = tor.id_torneo;
select*from torneo;
-- 4. Mostrar estadísticas con el nombre del jugador.
select kills, muertes, asistencias, ju.nombre
from estadistica es
inner join jugador ju
on es.id_jugador = ju.id_jugador;
-- 5. Mostrar premios con su torneo.
select monto, posicion, nombre
from premio pr
inner join torneo tor 
on pr.id_torneo = tor.id_torneo;
-- 6. Mostrar los jugadores y el equipo al que pertenecen.
select ju.nombre as jugador, eq.nombre as equipo
from jugador ju
inner join jugador_equipo ju_eq
on ju.id_jugador = ju_eq.id_jugador
inner join equipo eq
on eq.id_equipo = ju_eq.id_equipo;
-- 7. Mostrar equipos inscritos en torneos.
select eq.nombre as equipo, tor.nombre as torneo
from equipo eq
inner join inscripcion ins
on eq.id_equipo = ins.id_equipo
inner join torneo tor
on tor.id_torneo = ins.id_torneo;
-- 8. Mostrar partidas con su torneo y juego.
select id_partida, hora, fecha, estado, tor.nombre as torneo, ju.nombre as juego
from partida pa
inner join torneo tor
on pa.id_torneo = tor.id_torneo
inner join juego ju
on ju.id_juego = tor.id_juego;
-- 9. Mostrar estadísticas con jugador y partida.
select kills, muertes, asistencias, ju.nombre as jugador, pa.id_partida as partida
from estadistica es
inner join jugador ju
on es.id_jugador = ju.id_jugador
inner join partida pa
on es.id_partida = pa.id_partida;
-- 10. Mostrar participaciones con equipo y partida.
select resultado, eq.nombre as equipo, par.id_partida as partida
from participacion pa
inner join equipo eq
on pa.id_equipo = eq.id_equipo
inner join partida par
on par.id_partida = pa.id_partida;
-- 11. Mostrar todos los jugadores y sus equipos (aunque no tengan).
insert into jugador(nombre, nickname, email, pais)values
('Raquel Vergara', 'raqueta', 'raquel@gmail.com', 'Bolivia'),
('Roberto Ticona', 'robertito', 'robert@gmail.com', 'Chile'),
('Fernando Avalos', 'fercho', 'fernando@gmail.com', 'Bolivia');

select * from jugador;

select ju.nombre as jugadores, eq.nombre as equipo
from jugador ju
left join jugador_equipo ju_eq
on ju.id_jugador = ju_eq.id_jugador
left join equipo eq
on eq.id_equipo = ju_eq.id_equipo;
-- 12. Mostrar todos los torneos y sus premios.
select tor.nombre as torneo, posicion, monto as premio
from torneo tor
left join premio pr
on tor.id_torneo = pr.id_torneo;
-- 13. Mostrar todos los juegos y sus torneos.
insert into juego (nombre, genero)values
('F1 25', 'Deportes'),
('Gran Turismo', 'Deportes');

select * from juego;

select ju.nombre as juego, genero, tor.nombre as torneo
from juego ju
left join torneo tor
on ju.id_juego = tor.id_juego;
-- 14. Mostrar todas las partidas y participaciones.
select pa.id_partida, pa.estado as estado_partida, par.resultado
from partida pa
left join participacion par
on pa.id_partida = par.id_partida;
-- 15. Mostrar todos los equipos y sus jugadores.
select eq.nombre as equipo, ju.nombre as jugador
from equipo eq
left join jugador_equipo ju_eq
on eq.id_equipo = ju_eq.id_equipo
left join jugador ju
on ju.id_jugador = ju_eq.id_jugador;
-- 16. Mostrar todos los premios y sus torneos.
insert into premio (id_torneo, posicion, monto)values
(8, 2, 700.00);
select monto as premio, posicion, tor.nombre as torneo
from premio pr
left join torneo tor
on pr.id_torneo = tor.id_torneo;
select*from premio;
-- 17.Mostrar jugadores, equipo y torneo en el que están inscritos.
select ju.nombre as jugador, eq.nombre as equipo, tor.nombre as torneo
from jugador ju
inner join jugador_equipo ju_eq
on ju.id_jugador = ju_eq.id_jugador
inner join equipo eq
on eq.id_equipo = ju_eq.id_equipo 
inner join inscripcion ins
on eq.id_equipo = ins.id_equipo
inner join torneo tor
on ins.id_torneo = tor.id_torneo;
-- 18.Mostrar partidas con torneo, juego y estado.
select pa.id_partida as partida, pa.fecha, tor.nombre as torneo, ju.nombre as juego, pa.estado
from partida pa
inner join torneo tor
on pa.id_torneo = tor.id_torneo
inner join juego ju
on tor.id_juego = ju.id_juego;
-- 19.Mostrar estadísticas con jugador, equipo y partida.
select es.kills, es.muertes, es.asistencias, ju.nombre as jugador, eq.nombre as equipo, pa.id_partida as partida
from estadistica es
inner join jugador ju
on es.id_jugador = ju.id_jugador
inner join partida pa
on es.id_partida = pa.id_partida
inner join jugador_equipo ju_eq
on ju.id_jugador = ju_eq.id_jugador
inner join equipo eq 
on ju_eq.id_equipo = eq.id_equipo;
-- 20.Mostrar equipos, torneos y premios obtenidos.
select eq.nombre as equipo, tor.nombre as torneo, pr.monto as premio_obtenido, posicion
from equipo eq
inner join inscripcion ins
on eq.id_equipo = ins.id_equipo
inner join torneo tor
on ins.id_torneo = tor.id_torneo
inner join premio pr
on tor.id_torneo = pr.id_torneo;
select *from equipo;
