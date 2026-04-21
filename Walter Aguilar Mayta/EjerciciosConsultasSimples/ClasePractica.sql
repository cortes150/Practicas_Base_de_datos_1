-- Selecionar jugadores de un pais 
SELECT * FROM jugador WHERE pais="Bolivia";
-- Seleccionar jugadores con nicknames que comience con A
SELECT * FROM jugador WHERE nickname LIKE "A%" ;
-- Encontrar participaciones donde el resultado sea mayor a 10
SELECT * FROM estadistica WHERE kills > 10;
-- Mostrar las kills ENTRE 10 y 20 
SELECT * FROM estadistica WHERE kills BETWEEN 10 AND 20;
-- Actualiza la fecha de un inicio de torneo 
SELECT * FROM torneo;
UPDATE torneo SET fecha_inicio = "2026-04-20" WHERE id_torneo=7 ;
-- Mostrar los jugadores que no pertenecen a un pais determinado
SELECT *  FROM jugador WHERE NOT pais="Bolivia";
-- Participacion entre un rango de fechas
SELECT * FROM  inscripcion WHERE fecha_inscripcion BETWEEN "2026-03-01" AND "2026-04-20";
-- Modificar el monto de un premio
SELECT * FROM premio;
UPDATE premio SET monto=1666 WHERE id_premio="1";
-- LISTAR SOLO 3 Jugadores
SELECT * FROM jugador LIMIT 3;

-- ordenar el nombre del jugador ascendentemente
SELECT * FROM jugador ORDER BY nombre ASC;
SELECT * FROM jugador ORDER BY nombre DESC;

-- Seleccionar 2 jugadores que no tengan pais
INSERT INTO jugador (nombre, nickname, email) VALUES('Salces', 'ProPlayer','salces@gmail.com'), ('Jose','Jose123','jose@gmail.com');
SELECT * FROM jugador WHERE pais IS null;

-- Contar cuantos jugadores existen
SELECT COUNT(*) AS cantidad_jugadores FROM jugador ;
-- Sacar el promedio de todas las muertes de la tabla estadistica
SELECT avg(muertes) AS muertes_promedio FROM estadistica ;
-- listar los equipos creados despues de una fecha especifica
SELECT * FROM equipo WHERE fecha_creacion > '2026-04-01';
-- Contar la cantidad de jugadores por ciudad & oais
SELECT jugador.pais, COUNT(pais) AS jugadores_X_pais  FROM jugador GROUP BY pais ;
-- 