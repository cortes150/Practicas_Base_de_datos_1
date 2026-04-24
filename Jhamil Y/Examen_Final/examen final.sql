-- Nombre: Jhamil Guido Mamani Yujra  --- Codigo: 23698 --- Fecha: 24/04/26

--  Ejercicio 1: Lista todos los eventos y la cantidad de entradas vendidas para cada uno. Sugerencia: Usa una función de conteo y agrupa por evento. 
select e.nombre as nombre_evento, count(en.id_entrada) as cantidad_vendida
from evento e
left join entrada en on e.id_evento = en.id_evento
where en.estado = 'vendida' or en.estado is null
group by e.id_evento, e.nombre;

-- Ejercicio 2: Muestra los nombres de los usuarios que realizaron pagos con tarjetas. Recuerda: Evita duplicados.
select distinct u.nombre
from usuario u
join compra c on u.id_usuario = c.id_usuario
join pago p on c.id_compra = p.id_compra
where p.metodo = 'tarjeta';

-- Ejercicio 3: Muestra total recaudado por cada método de pago.
select metodo, sum(monto) as total_recaudado
from pago
group by metodo;
 
-- EJercicio 4: Muestra los eventos que tienen al menos una entrada cancelada y cuántas fueron. 
select e.nombre as nombre_evento, count(en.id_entrada) as total_canceladas
from evento e
join entrada en on e.id_evento = en.id_evento
where en.estado = 'cancelada'
group by e.id_evento, e.nombre;

-- Ejercicio 5: Muestra los usuarios que compraron más de una entrada.
select u.nombre, count(c.id_entrada) as total_entradas
from usuario u
join compra c on u.id_usuario = c.id_usuario
group by u.id_usuario, u.nombre 
having total_entradas > 1;

-- Ejercicio 6: Encuntra el evento con la entrada más cara del sistema.
select e.nombre, en.precio
from evento e
join entrada en on e.id_evento = en.id_evento
order by en.precio desc
limit 1;

-- Ejercicio 7: Muestra los usuarios que asistieron al menos un evento.
select distinct u.nombre
from usuario u
join asistencia a on u.id_usuario = a.id_usuario
where a.asistio = 1;

-- Ejercicio 8: Muestra el promedio de precios de las entradas por cada evento.
select e.nombre, avg(en.precio) as precio_promedio
from evento e
join entrada en on e.id_evento = en.id_evento
group by e.id_evento, e.nombre;

-- Ejercicio 9: Muestra Los usuarios que no asistieron a ningún evento. Pista: Puedes una subconsulta con NOT IN. 
select nombre 
from usuario
where id_usuario not in (
select id_usuario
from asistencia 
where asistio = 1);

-- Ejercicio 10: Muestra cuánto dinero ha pagado en total cada usuario, ordenado de mayor a menor.
select u.nombre, sum(p.monto) as total_pagado
from usuario u
join compra c on u.id_usuario = c.id_usuario
join pago p on c.id_compra = p.id_compra
group by u.id_usuario, u.nombre
order by total_pagado desc;