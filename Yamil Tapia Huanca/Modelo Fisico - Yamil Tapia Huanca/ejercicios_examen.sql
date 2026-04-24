-- 1
select ev.nombre as evento, count(e.id_entrada) as entrada
from evento ev
inner join entrada e on ev.id_evento = e.id_evento
group by ev.nombre;

-- 2
select u.nombre as usuario, p.metodo
from usuario u
inner join compra c on u.id_usuario = c.id_usuario
inner join pago p on c.id_compra = p.id_compra
where p.metodo = 'tarjeta';

-- 3
select p.metodo as metodo, sum(p.monto) as total
from pago p 
group by p.metodo;

-- 4
select e.nombre as evento, en.estado as estado_entrada, count(en.id_entrada) as totales
from evento e 
inner join entrada en on e.id_evento = en.id_evento
where estado = 'cancelada'
group by evento;

-- 5 
select u.nombre as usuario, count(c.id_compra) as total_compra_entradas
from usuario u 
inner join compra c on u.id_usuario = c.id_usuario
group by u.nombre
having COUNT(c.id_compra) > 1;

-- 6
select e.nombre, max(en.precio) as precio_maximo
from evento e
inner join entrada en on e.id_evento = en.id_evento
group by e.nombre
order by precio_maximo desc
limit 1;

-- 7
select  u.nombre as usuario, e.nombre as evento
from usuario u
inner join asistencia a on u.id_usuario = a.id_usuario
inner join evento e on e.id_evento = a.id_evento
where a.asistio = 1;

-- 8
select e.nombre, avg(en.precio) as promedio
from evento e
inner join entrada en on e.id_evento = en.id_evento
group by e.nombre;

-- 9
select u.nombre as usuario
from usuario u
inner join asistencia a on a.id_usuario = u.id_usuario
where a.asistio < 1;

-- 10
select u.nombre as usuario, sum(p.monto) as dinero_total
from usuario u
inner join compra c on u.id_usuario = c.id_usuario
inner join pago p on c.id_compra = p.id_compra
group by usuario
order by dinero_total desc;
