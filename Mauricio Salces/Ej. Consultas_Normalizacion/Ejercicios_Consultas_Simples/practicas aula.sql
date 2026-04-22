select * from jugador where pais = 'Bolivia';
select * from jugador where nickname like 'A%';
select * from estadistica where kills > 10;
select * from estadistica where kills between 10 and 20;
update torneo set fecha_inicio = '2026-06-11' where id_torneo =  7;
select * from jugador where pais != 'Bolivia';
select * from inscripcion where fecha_inscripcion between '2026-01-25' and '2026-03-25';
update jugador set pais = 'China' where id_jugador between 21 and 23;
update premio set monto = 500000.00 where id_premio =10;
select * from jugador limit 3 ;
select * from jugador order by nombre asc;
select * from jugador order by nombre desc;
insert into jugador(nombre,email)values('vacio','vacio@gmail.com');
insert into jugador(nombre,email)values('vacio2','vacio2@gmail.com');
insert into jugador(nombre,email)values('vacio3','vacio3@gmail.com');
select * from jugador where pais is null;

select count(*) as'numero de jugadores' from jugador;
select avg(muertes) as 'promedio muertes' from estadistica;
select pais,count(*) as'numero de jugadores por pais' from jugador group by (pais);


-- mostrar los torneos junto con sus juegos
select * from torneo inner join juego on torneo.id_juego = juego.id_juego;
select t.nombre as nombre_torneo ,j.nombre as nombre_juego
from torneo t
inner join juego j
on t.id_juego = j.id_juego;

-- mostrar stats con el nombre del jugador
select e.kills as estadistica_kills, j.nombre as nombre_jugador
from estadistica e
inner join jugador j
on e.id_jugador = j.id_jugador;

-- mostrar los jugadores junto con su equipo
select j.nombre as jugador,  e.nombre as equipo
from jugador j
inner join jugador_equipo je
on j.id_jugador = je.id_jugador
inner join equipo e
on e.id_equipo = je.id_equipo;

-- 