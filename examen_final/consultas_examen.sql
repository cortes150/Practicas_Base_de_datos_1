-- 1.- Lista todos los eventos y la cantidad de entradas vendidas para cada uno. Sugerencia: Usa una función de conteo y agrupa por evento.
select e.nombre as evento , count(c.id_entrada) as Entradas_vendidas
from evento e
join entrada en on e.id_evento = en.id_evento
join compra c on en.id_entrada = c.id_entrada
group by e.id_evento
order by Entradas_vendidas;
