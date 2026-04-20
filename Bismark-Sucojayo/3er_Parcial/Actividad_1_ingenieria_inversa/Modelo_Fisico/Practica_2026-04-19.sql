-- 1. Insertar un nuevo jugador con nombre, nickname, correo y país.
insert into jugador(nombre, nickname, email, pais) values
('abisai','vico','abisai123@gmail.com','chile');

-- 2. Insertar otro jugador con datos diferentes.
insert into jugador(nombre, nickname, email, pais) values
('Javier','mentarosa','javi123@gmail.com','chile');

-- 3. Insertar un equipo con su nombre y fecha de creación.  
insert into equipo(nombre, fecha_creacion) values
('Los_inmortales','2026-04-20');

-- 4. Insertar un juego indicando su nombre y género. 
insert into juego(nombre, genero) values
('Serios_Sam','supervivencia');

-- 5. Insertar un torneo asociado a un juego existente.  
insert into torneo(nombre, fecha_inicio, fecha_fin, id_juego) values
('Unandes_games','2026-03-14','2026-07-03',1);

-- 6. Insertar una partida para un torneo existente con fecha, hora y estado.  
insert into partida(id_torneo,fecha,hora,estado) values
(1,'2026-05-25','10:30','en_curso');

-- 7. Registrar la inscripción de un equipo en un torneo. 
insert into inscripcion(id_equipo,id_torneo,fecha_inscripcion) values
(2,1,'2026-03-15');
 
-- 8. Insertar un premio para un torneo indicando posición y monto. 
 insert into premio(id_torneo,posicion,monto) values
 (1,2,250.0);
 
-- 9. Insertar estadísticas de un jugador en una partida.  
insert into estadistica(id_jugador,id_partida,kills,muertes,asistencias) values
-- (2,1,4,2,10),
(1,1,10,0,2);

-- 10. Registrar la participación de un equipo en una partida con su resultado. 
insert into participacion(id_partida, id_equipo, resultado) values
(1,2,'derrota');

-- 11. Actualizar el país de un jugador específico.
update jugador
set pais = 'Argentina'
where id_jugador = 2;

-- 12. Cambiar el nickname de un jugador.  
update jugador
set nickname = 'Trivilin'
where id_jugador = 1;

-- 13. Modificar el nombre de un equipo.
update equipo
set nombre = 'The_pros'
where id_equipo = 2;

-- 14. Cambiar el género de un juego.  
update juego
set genero = 'MOBA'
where id_juego = 1;

-- 15. Actualizar la fecha de inicio de un torneo.
update torneo
set fecha_inicio = '2026-01-05'
where id_torneo = 1;

-- 16. Cambiar el estado de una partida.
update partida
set estado = 'comenzada'
where id_partida = 2;

-- 17. Modificar el monto de un premio.
update premio
set monto = 100.0
where id_premio = 3;

-- 18. Actualizar el número de kills de una estadística. 
update estadistica
set kills = 12
where id_estadistica = 2;
 
-- 19. Cambiar el resultado de una participación específica.  
update participacion
set resultado = 'victoria'
where id_equipo = 1;

-- 20. Modificar la fecha de inscripción de un equipo en un torneo.
update inscripcion
set fecha_inscripcion = '2026-02-02'
where id_inscripcion = 1;

-- 21. Mostrar todos los jugadores de un país específico.  
select nombre, nickname,email, pais
from jugador
where pais = 'Chile';

-- 22. Mostrar los jugadores que no pertenecen a un país determinado.
select nombre, nickname,email, pais
from jugador
where pais != 'Bolivia';

-- 23. Listar los equipos creados después de una fecha específica.
select nombre, fecha_creacion
from equipo
where fecha_creacion > '2026-02-02';
  
-- 24. Mostrar los juegos de un género determinado.  
select nombre, genero
from juego
where genero = 'moba';

-- 25. Listar los torneos que se realizan en un rango de fechas.  
select nombre, fecha_inicio, fecha_fin, id_juego
from torneo 
where fecha_inicio >='2026-02-01' and fecha_fin<='2026-08-12';

-- 26. Mostrar todas las partidas que tengan un estado específico.  
select id_partida,id_torneo, fecha,hora,estado
from partida
where estado = 'comenzada';

-- 27. Mostrar los premios cuyo monto sea mayor a un valor dado.  
select id_premio,id_torneo, posicion, monto
from premio
where monto > 2000.0;

-- 28. Listar las estadísticas donde las kills superen un valor determinado.  
select id_jugador, id_partida, kills, muertes, asistencias
from estadistica
where kills > 21;

-- 29. Mostrar las participaciones con un resultado específico (ej. ganador).  
select id_partida, id_equipo, resultado
from participacion
where resultado = 'victoria';

-- 30. Listar las inscripciones realizadas dentro de un rango de fechas.
select id_inscripcion, id_equipo, id_torneo, fecha_inscripcion
from inscripcion
where fecha_inscripcion>'2026-03-03' and fecha_inscripcion<'2026-06-06';

