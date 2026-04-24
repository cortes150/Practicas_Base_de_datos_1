-- 1.- Lista todos los eventos y la cantidad de entradas vendidas para cada uno.
-- Sugerencia: Usa una función de conteo y agrupa por evento.
select e.nombre as evento , count(c.id_entrada) as Entradas_vendidas
from evento e
join entrada en on e.id_evento = en.id_evento
join compra c on en.id_entrada = c.id_entrada
group by e.id_evento
order by Entradas_vendidas;

-- 2.- Muestra los nombres de los usuarios que realizaron pagos con tarjeta.
-- Recuerda: Evita duplicados.
select u.nombre as Usuario , p.metodo
from usuario u
join compra c on u.id_usuario = c.id_usuario
join pago p on c.id_compra = p.id_compra
where p.metodo = 'tarjeta';

-- 3.-Muestra el total recaudado por cada método de pago
select p.metodo , sum(p.monto) as total_recaudado
from pago p
group by p.metodo;

-- 4.-Muestra los eventos que tienen al menos una entrada cancelada y cuántas fueron
select e.nombre as evento , en.estado , count(en.id_entrada) as cancelaciones_totales
from evento e
join entrada en on e.id_evento = en.id_evento
where en.estado = 'cancelada'
having cancelaciones_totales >= 1;

-- 5.- Muestra los usuarios que compraron más de una entrada
select u.nombre as Usuario , count(en.id_entrada) as entradas_adquiridas
from usuario u
join compra c on c.id_usuario = u.id_usuario
join entrada en on c.id_entrada = en.id_entrada
group by u.id_usuario
having entradas_adquiridas > 1;

-- 6.- Encuentra el evento con la entrada más cara del sistema.
select e.nombre as evento , en.precio
from evento e
join entrada en on e.id_evento = en.id_evento
group by en.precio desc
limit 1;


-- 7.- Muestra los usuarios que asistieron al menos a un evento.
select u.nombre as Usuario , a.asistio
from usuario u 
join asistencia a on u.id_usuario = a.id_usuario
where a.asistio = 1
order by u.id_usuario;


-- 8.- Muestra el promedio de precios de las entradas por cada evento.
select e.nombre as evento , avg(en.precio) as Promedio_precios
from entrada en
join evento e on en.id_evento = e.id_evento
group by e.id_evento;


-- 9.- Muestra los usuarios que no asistieron a ningún evento.
-- Pista: Puedes usar una subconsulta con NOT IN.
select u.nombre as Usuario , a.asistio
from usuario u 
join asistencia a on u.id_usuario = a.id_usuario
where a.asistio = 0
order by u.id_usuario;

-- 10.- Muestra cuánto dinero ha pagado en total cada usuario, ordenado de mayor a menor.
select u.nombre as Usuario , sum(p.monto) as Total_gastado
from usuario u 
join compra c on c.id_usuario = u.id_usuario
join pago p on c.id_compra = p.id_compra
group by u.id_usuario
order by Total_gastado desc;

select * from asistencia 