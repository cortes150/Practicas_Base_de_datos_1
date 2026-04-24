-- only full group deactivated 
 SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '') );
-- 3er Parcial
-- Caso: El Sistema del UniFest 2025
-- 1.- Lista todos los eventos y la cantidad de entradas vendidas para cada uno.
-- Sugerencia: Usa una función de conteo y agrupa por evento.
use unifest_db;
SELECT ev.nombre, SUM(en.estado='vendida') AS cantidad_vendidos
FROM evento ev
JOIN entrada en ON en.id_evento=ev.id_evento
GROUP BY ev.nombre , ev.id_evento
;
 
-- 2.- Muestra los nombres de los usuarios que realizaron pagos con tarjeta.
-- Recuerda: Evita duplicados.
SELECT u.nombre 
FROM usuario u
JOIN compra c ON u.id_usuario=c.id_usuario
JOIN pago p ON c.id_compra=p.id_compra 
WHERE p.metodo='tarjeta'
GROUP BY u.id_usuario, u.nombre
;
 

-- 3.-Muestra el total recaudado por cada método de pago.
SELECT metodo  ,SUM(monto) AS total_metodo_pago -- p.monto 
FROM pago
group by metodo
;

-- 4.-Muestra los eventos que tienen al menos una entrada cancelada y cuántas fueron.
SELECT ev.nombre, SUM(en.estado = 'cancelada') AS cantidad_canceladas
FROM evento ev
JOIN entrada en ON ev.id_evento=en.id_evento
WHERE en.estado = 'cancelada'
GROUP BY ev.id_evento, ev.nombre
;
-- 5.- Muestra los usuarios que compraron más de una entrada.
-- deben haber 3 registros, juan perez maria y carlos 2 ana y luis 1 por lo que solo esos 3 son los indicados
SELECT u.nombre, count(u.id_usuario) AS compras 
FROM usuario u
JOIN compra c ON u.id_usuario=c.id_usuario
GROUP BY u.id_usuario, u.nombre
HAVING compras > 1
;

-- 6.- Encuentra el evento con la entrada más cara del sistema.
SELECT ev.nombre, MAX(en.precio) AS mas_caro
FROM evento ev
JOIN entrada en ON en.id_evento=ev.id_evento

;
-- 7.- Muestra los usuarios que asistieron al menos a un evento.
SELECT u.nombre, ev.nombre, asistio
FROM usuario u 
JOIN asistencia a ON u.id_usuario=a.id_usuario
JOIN evento ev ON ev.id_evento=a.id_evento
WHERE asistio > 0
GROUP BY u.id_usuario, u.nombre -- agrupara de forma unanime si alguien asistio al menos una ves 
;
-- 8.- Muestra el promedio de precios de las entradas por cada evento.
SELECT ev.nombre , AVG(precio) AS promedio
FROM evento ev
JOIN entrada en ON en.id_evento=ev.id_evento
GROUP BY ev.id_evento, ev.nombre
;
-- 9.- Muestra los usuarios que no asistieron a ningún evento.
-- Pista: Puedes usar una subconsulta con NOT IN.
SELECT u.nombre, ev.nombre, asistio
FROM usuario u 
JOIN asistencia a ON u.id_usuario=a.id_usuario
JOIN evento ev ON ev.id_evento=a.id_evento
WHERE asistio =  0
GROUP BY u.id_usuario, u.nombre -- agrupara de forma unanime si alguien asistio al menos una ves 
;
-- 10.- Muestra cuánto dinero ha pagado en total cada usuario, ordenado de mayor a menor.
-- Juan perez 220 
SELECT u.nombre , SUM(p.monto) AS total_pagados
FROM usuario u
JOIN compra c ON u.id_usuario=c.id_usuario
JOIN pago p ON c.id_compra=p.id_compra 
GROUP BY u.nombre, u.id_usuario
ORDER BY total_pagados DESC
;