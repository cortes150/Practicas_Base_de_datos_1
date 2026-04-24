-- 1.- Lista todos los eventos y la cantidad de entradas vendidas para cada uno. Sugerencia: Usa una función de conteo y agrupa por evento.
select ev.nombre, COUNT(en.precio) as total_entradas_vendidas
from evento ev
left join entrada en 
on ev.id_evento = en.id_evento
group by ev.id_evento
order by total_entradas_vendidas desc;
select * from evento;
select * from entrada;
-- 2.- Muestra los nombres de los usuarios que realizaron pagos con tarjeta. Recuerda: Evita duplicados.
select us.nombre as usuario, pa.metodo as metodo_pago
from usuario us
inner join compra com
on us.id_usuario = com.id_usuario
inner join pago pa
on com.id_compra = pa.id_compra
where pa.metodo = "tarjeta";
select * from pago;
-- 3.-Muestra el total recaudado por cada método de pago.
SELECT pa.metodo, sum(pa.monto) AS total_recaudado
FROM pago pa
group by pa.metodo;
select*from pago;
-- 4.-Muestra los eventos que tienen al menos una entrada cancelada y cuántas fueron.
select ev.nombre as evento, en.estado, count(en.estado) as Nro_entradas_canceladas
from evento ev
inner join entrada en
on ev.id_evento = en.id_evento
where en.estado = "cancelada"
group by ev.nombre;
select * from evento;
select * from entrada;
-- 5.- Muestra los usuarios que compraron más de una entrada.
-- 6.- Encuentra el evento con la entrada más cara del sistema.
-- 7.- Muestra los usuarios que asistieron al menos a un evento.
-- 8.- Muestra el promedio de precios de las entradas por cada evento.
-- 9.- Muestra los usuarios que no asistieron a ningún evento. Pista: Puedes usar una subconsulta con NOT IN.
-- 10.- Muestra cuánto dinero ha pagado en total cada usuario, ordenado de mayor a menor