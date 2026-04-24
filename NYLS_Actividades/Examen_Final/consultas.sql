
-- 1
select evento.nombre, count(entrada.id_entrada) as cantidad_entradas from evento inner join entrada
on evento.id_evento=entrada.id_evento
group by evento.nombre;

-- 2
select usuario.nombre from usuario inner join compra 
on usuario.id_usuario = compra.id_usuario
inner join pago 
on compra.id_compra = pago.id_compra
where pago.metodo = 'tarjeta';

-- 3
select pago.metodo, sum(pago.monto) as total_recaudado from pago 
group by pago.metodo;

-- 4

-- 5 
select usuario.nombre, count(entrada.id_entrada) as cantidad_entradas from usuario inner join compra
on usuario.id_usuario=compra.id_usuario
inner join entrada
on compra.id_entrada=entrada.id_entrada
group by usuario.nombre;

-- 6
select evento.nombre, max(entrada.precio) as precio_maximo from evento inner join entrada 
on evento.id_evento = entrada.id_evento
group by evento.id_evento
order by precio_maximo desc
limit 1;

-- 7


-- 8
select evento.nombre, avg(entrada.precio) as promedio_precios from entrada inner join evento 
on entrada.id_evento = evento.id_evento 
group by evento.nombre;

-- 9 
select usuario.nombre, asistencia.asistio from usuario inner join asistencia
on usuario.id_usuario=asistencia.id_usuario
where asistencia.asistio=0
order by usuario.id_usuario;

-- 10 
select usuario.id_usuario, usuario.nombre, sum(pago.monto) as total_pagado from usuario inner join compra 
on usuario.id_usuario = compra.id_usuario inner join pago  