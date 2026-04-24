USE unifest_db;

-- 1.- Lista todos los eventos y la cantidad de entradas vendidas para cada uno. 
-- Sugerencia: Usa una función de conteo y agrupa por evento. 
select nombre as 'evento',count(nombre) as 'cantidad_vendida'
from evento e
inner join entrada en
on e.id_evento = en.id_evento
where en.estado = 'vendida'
group by (nombre);

-- 2.- Muestra los nombres de los usuarios que realizaron pagos con tarjeta. 
-- Recuerda: Evita duplicados.
select nombre, metodo
from usuario u 
inner join compra c 
on u.id_usuario = c.id_usuario
inner join pago p 
on c.id_compra = p.id_compra
where p.metodo = 'tarjeta';

-- 3.-Muestra el total recaudado por cada método de pago.
select metodo,sum(monto) as 'total_recaudado'
from pago
group by (metodo);

-- 4.-Muestra los eventos que tienen al menos una entrada cancelada y cuántas fueron. 
select nombre as 'evento',count(estado) as 'cant_entradas-canceladas'
from evento e
inner join entrada en
on e.id_evento = en.id_evento
where estado = 'cancelada'
group by(nombre);

-- 5.- Muestra los usuarios que compraron más de una entrada.
select nombre,count(nombre) as 'entrada_comprada'
from usuario u 
inner join compra c 
on u.id_usuario = c.id_usuario
inner join entrada e
on c.id_entrada = e.id_entrada
where estado = 'vendida'
group by (nombre)
having entrada_comprada >1;

-- 6.- Encuentra el evento con la entrada más cara del sistema.
select nombre,precio
from evento e
inner join entrada en
on e.id_evento = en.id_entrada
order by precio desc
limit 1;

-- 7.- Muestra los usuarios que asistieron al menos a un evento. 
select nombre, asistio
from usuario u
inner join asistencia a 
on u.id_usuario = a. id_usuario
where asistio >=1;

-- 8.- Muestra el promedio de precios de las entradas por cada evento.
select nombre,avg(precio) as 'promedio'
from entrada e
inner join evento ev
on e.id_evento = ev.id_evento
group by(nombre);

-- 9.- Muestra los usuarios que no asistieron a ningún evento. 
-- Pista: Puedes usar una subconsulta con NOT IN.
select nombre, asistio
from usuario u
inner join asistencia a 
on u.id_usuario = a. id_usuario
where asistio < 1;

-- 10.- Muestra cuánto dinero ha pagado en total cada usuario, ordenado de mayor a menor.
select nombre,sum(monto) as 'pago_total'
from usuario u 
inner join compra c
on u.id_usuario = c.id_usuario
inner join pago p 
on p.id_compra = c.id_compra
group by(nombre)
order by pago_total desc;

