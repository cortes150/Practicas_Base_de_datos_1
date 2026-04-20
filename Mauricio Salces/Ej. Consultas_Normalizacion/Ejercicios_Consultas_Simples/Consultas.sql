-- 1. Insertar un nuevo jugador con nombre, nickname, correo y país.
insert into jugador(nombre,nickname,email,pais)values('Ivan','RivanGoat','rivangoat@gmail.com','Ecuador');
-- 2. Insertar otro jugador con datos diferentes.
insert into jugador(nombre,nickname,email,pais)values('Beymar','Condor','beymar@gmail.com','Paraguay');
-- 3. Insertar un equipo con su nombre y fecha de creación.
insert into equipo(nombre,fecha_creacion)values('K.O.','2026-04-20');
-- 4. Insertar un juego indicando su nombre y género.
insert into juego(nombre,genero)values('Warcraft III','RTS');
-- 5. Insertar un torneo asociado a un juego existente.
insert into torneo(nombre, fecha_inicio, fecha_fin, id_juego) values('Battle for Azeroth','2026-04-25','2026-05-15',16);
-- 6. Insertar una partida para un torneo existente con fecha, hora y estado.
insert into partida(id_torneo, fecha, hora, estado)values('16','2026-04-25','12:00:00','pendiente');
-- 7. Registrar la inscripción de un equipo en un torneo.
insert into inscripcion(id_equipo, id_torneo, fecha_inscripcion) values(16,16,'2026-04-19');
-- 8. Insertar un premio para un torneo indicando posición y monto.
insert into premio(id_torneo,posicion,monto)values(16,1,1000.00);
-- 9. Insertar estadísticas de un jugador en una partida.
insert into estadistica(id_jugador, id_partida, kills, muertes, asistencias)values(16,16,0,2,5);
-- 10. Registrar la participación de un equipo en una partida con su resultado.
insert into participacion(id_partida, id_equipo, resultado)values(16,16,'perdedor');


-- 11. Actualizar el país de un jugador específico.
update jugador set pais = 'Hungria' where id_jugador = 16;
-- 12. Cambiar el nickname de un jugador.
update jugador set nickname = 'ARDI_do' where id_jugador = 2;
-- 13. Modificar el nombre de un equipo.
update equipo set nombre = 'JoJo_Bizarro' where id_equipo = 5;
-- 14. Cambiar el género de un juego.
update juego set genero = 'Souls' where id_juego = 7;
-- 15. Actualizar la fecha de inicio de un torneo.
update torneo set fecha_inicio = '2026-05-16' where id_torneo = 16;
-- 16. Cambiar el estado de una partida.
update partida set estado = 'cancelada' where id_partida = 16;
-- 17. Modificar el monto de un premio.
update premio set monto = 3500.00 where id_premio = 16;
-- 18. Actualizar el número de kills de una estadística.
update estadistica set kills = 1 where id_estadistica = 16;
-- 19. Cambiar el resultado de una participación específica.
update participacion set resultado = 'ganador' where id_partida = 16 and id_equipo = 16;
-- 20. Modificar la fecha de inscripción de un equipo en un torneo.
update inscripcion set fecha_inscripcion = '2026-04-20' where id_equipo = 16 and id_torneo = 16;


-- 21. Mostrar todos los jugadores de un país específico.
select * from jugador where pais = 'bolivia';
-- 22. Mostrar los jugadores que no pertenecen a un país determinado.
select * from jugador where pais != 'bolivia';
-- 23. Listar los equipos creados después de una fecha específica.
select * from equipo where fecha_creacion > '2025-08-08';
-- 24. Mostrar los juegos de un género determinado.
select * from juego where genero = 'fps';
-- 25. Listar los torneos que se realizan en un rango de fechas.
select * from torneo where fecha_inicio > '2026-04-12' && fecha_fin < '2026-07-08';
-- 26. Mostrar todas las partidas que tengan un estado específico.
select * from partida where estado = 'finalizada';
-- 27. Mostrar los premios cuyo monto sea mayor a un valor dado.
select * from premio where monto > '4500.00';
-- 28. Listar las estadísticas donde las kills superen un valor determinado.
select * from estadistica where kills > '9';
-- 29. Mostrar las participaciones con un resultado específico (ej. ganador).
select * from participacion where resultado = 'perdedor';
-- 30. Listar las inscripciones realizadas dentro de un rango de fechas.
select * from inscripcion where fecha_inscripcion > '2026-04-12' && fecha_inscripcion < '2026-07-08';