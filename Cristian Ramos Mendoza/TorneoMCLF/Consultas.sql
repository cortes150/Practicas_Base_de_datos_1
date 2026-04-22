#9
-- 9. PRODUCTOS CON BAJO STOCK

select p.nombre, i.stock
from producto p
inner join inventario i on p.id_producto = i.id_producto
where i.stock < 50;

#10
-- 10. RUTAS CON MÁS PEDIDOS
select r.nombre, COUNT(pe.id_pedido) as total_pedidos
from ruta r
left join pedido pe on r.id_ruta = pe.id_ruta
group by r.nombre
order by total_pedidos desc;



#9
-- 9.Enunciado: Mostrar clientes sin pedidos.

SELECT c.nombre
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido  IS NULL;

-- Pista: Comparación incorrecta con NULL.


#10
-- 10.Enunciado: Mostrar ventas por producto ordenadas.

SELECT p.nombre, SUM(dp.cantidad) AS total
FROM detalle_pedido dp
INNER JOIN producto p ON dp.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY total DESC;

-- Pista: Error de sintaxis en ORDER BY. 



