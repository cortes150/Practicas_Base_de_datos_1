-- 1.- Lista todos los eventos y la cantidad de entradas vendidas para cada uno. Sugerencia: Usa una función de conteo y agrupa por evento.
select e.nombre as evento , count(c.id_entrada) as Entradas_vendidas
from evento e
join entrada en on e.id_evento = en.id_evento
join compra c on en.id_entrada = c.id_entrada
group by e.id_evento
order by Entradas_vendidas;

-- 2.- Muestra los nombres de los usuarios que realizaron pagos con tarjeta. Recuerda: Evita duplicados.
select u.nombre as Usuario , p.metodo 
from usuario u
join compra c on u.id_usuario = c.id_usuario
join pago p on c.id_compra = p.id_compra
where p.metodo = 'tarjeta'
order by u.id_usuario;

-- 3.-Muestra el total recaudado por cada método de pago
select p.metodo , sum(p.monto) as total_recaudado
from pago p
group by p.metodo;

-- 4.-Muestra los eventos que tienen al menos una entrada cancelada y cuántas fueron

-- 5.- Muestra los usuarios que compraron más de una entrada

-- 6.- Encuentra el evento con la entrada más cara del sistema.

-- 7.- Muestra los usuarios que asistieron al menos a un evento.
