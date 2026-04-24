-- 1.- Lista todos los eventos y la cantidad de entradas vendidas para cada uno. Sugerencia: 
-- Usa una función de conteo y agrupa por evento.  

select e.nombre , count(en.id_entrada) as vendidas
from evento e 
left join entrada en on e.id_evento = en.id_evento and en.estado = 'vendida'
group by e.id_evento ,e.nombre;    



-- 2.- Muestra los nombres de los usuarios que realizaron pagos con tarjeta. Recuerda: Evita duplicados. 

 
 select distinct u.nombre
 from usuario u 
 inner join compra c on u.id_usuario = c.id_usuario
 inner join pago p on c.id_compra = p.id_compra
 where p.metodo ='tarjeta';  
 
 
 -- 3.-Muestra el total recaudado por cada método de pago.  
 
 select metodo , sum(monto) as total
 from pago 
 group by metodo;  
 
 
 
 -- 4.-Muestra los eventos que tienen al menos una entrada cancelada y cuántas fueron.  
 
 select e.nombre , count(en.id_entrada) as canceladas 
 from evento e 
 inner join entrada en on e.id_evento = en.id_evento 
 where en.estado = 'cancelada'
 group by e.id_evento , e.nombre; 
  
 
 
 -- 5.- Muestra los usuarios que compraron más de una entrada.  
 
 select u.nombre , count(c.id_compra) as total_entradas
 from usuario u
 inner join compra c on u.id_usuario = c.id_usuario
 group by u.id_usuario , u.nombre 
 having count(c.id_compra) > 1;  
 
 
 
 -- 6.- Encuentra el evento con la entrada más cara del sistema. 

select e.nombre , en.precio as entrada_max 
from evento e 
inner join entrada en on e.id_evento = en.id_evento 
order by en.precio desc
limit 1;  



-- 7.- Muestra los usuarios que asistieron al menos a un evento. 
 
 select distinct u.nombre 
 from usuario u
 inner join asistencia a on  u.id_usuario = a.id_usuario
 where a.asistio = 1;  
 
 
 
 -- 8.- Muestra el promedio de precios de las entradas por cada evento.  
 
 select e.nombre ,avg(en.precio) as promedio
 from evento e 
 inner join entrada en on e.id_evento = en.id_evento
 group by e.id_evento ,e.nombre;  
 
 
 -- 9.- Muestra los usuarios que no asistieron a ningún evento.  Pista: Puedes usar una subconsulta con NOT IN.
 
  select nombre 
  from usuario u
  left join asistencia a on u.id_usuario = a.id_usuario and a.asistio = 1 
  where a.id_asistencia is null; 
  
  
  
  -- 10.- Muestra cuánto dinero ha pagado en total cada usuario, ordenado de mayor a menor. 
  
  select u.nombre , sum(p.monto) as total_pagado
  from usuario u
  inner join compra c on u.id_usuario = c.id_usuario
  inner join pago p on c.id_compra = p.id_compra 
  group by u.id_usuario , u.nombre 
  order by total_pagado desc; 
  
  
  