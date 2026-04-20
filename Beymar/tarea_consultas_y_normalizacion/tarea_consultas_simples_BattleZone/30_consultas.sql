USE battlezone_db;
-- 1
insert into jugador (nombre, nickname, email, pais) values
("jose", "josesitopro", "jose321@gmail.com", "Argentina");
-- 2
insert into jugador (nombre, nickname, email, pais) values
("nicole", "malacopa", "nicki@gmail.com", "Colombia");
-- 3
insert into equipo (nombre, fecha_creacion) values
("putifresas", "2026-04-20");
-- 4
insert into juego (nombre, genero)values
('Free_Fire', 'Battle_Royale');
-- 5 
insert into torneo (nombre, fecha_inicio, fecha_fin, id_juego)values
('Ratones', '2026-09-22', '2026-09-30', 16);
-- 6
insert into partida (id_torneo, fecha, hora, estado)values
(16, '2026-09-22', '13:00:00', 'Programada');
-- 7
insert into inscripcion (id_equipo, id_torneo, fecha_inscripcion)values
(16, 16, '2026-04-25');
-- 8 
insert into premio (id_torneo, posicion, monto)values
(16, 1, 3000.00);
-- 9
insert into estadistica (id_jugador, id_partida, kills, muertes, asistencias)values
(16, 16, 23, 1, 3);
-- 10
insert into participacion (id_partida, id_equipo, resultado)values
(16, 16, 'Pendiente');
-- 11
update jugador set pais = "Argentina" where id_jugador = 1;
-- 12
update jugador set  nickname = "mataviejas2000" where id_jugador = 3;
-- 13 
update equipo set nombre = "chefsitos" where id_equipo = 4;
-- 14
update juego set genero = "crimenes_y_accion" where id_juego = 1;
-- 15
update torneo set fecha_inicio = "2026-06-11" where id_torneo = 4;
-- 16
update partida set estado = "cancelada" where id_partida = 7;
-- 17
update premio set monto = 5000 where id_premio = 4;
-- 18 
update estadistica set kills = 10 where id_estadistica = 16;
-- 19 
update participacion set resultado = "Victoria" where id_partida = 1 and id_equipo =1;
-- 20 
update inscripcion set fecha_inscripcion = "2026-04-24" where id_inscripcion = 16; 
-- 21
select * from jugador where pais = "Argentina"; 
-- 22
select * from jugador where not pais = "Bolivia";  -- o tambien puede ser where pais != "Bolivia"
-- 23
select * from equipo where fecha_creacion >= "2026-04-11"; -- puede ser solo > o lo que puse 
-- 24 
select * from juego where genero = "Battle_Royale";
-- 25 
select * from torneo where fecha_inicio between "2026-05-01" and "2026-06-30";
-- 26 
select * from partida where estado = "cancelada";
-- 27
select * from premio where monto > 2000;
-- 28 
select * from estadistica where kills > 15;
-- 29 
select * from participacion where resultado = "Victoria"; 
-- 30 
select * from inscripcion where fecha_inscripcion between "2026-04-23" and "2026-04-24";