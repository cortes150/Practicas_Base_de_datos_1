--1
SELECT pr.nombre, SUM(dp.cantidad) AS total_unidades
FROM producto pr
JOIN detalle_pedido dp ON pr.id_producto = dp.id_producto
GROUP BY pr.id_producto
ORDER BY total_unidades DESC;
--2
SELECT pr.nombre, SUM(dp.cantidad * dp.precio_unitario) AS total_ingresos
FROM producto pr
JOIN detalle_pedido dp ON pr.id_producto = dp.id_producto
GROUP BY pr.id_producto
ORDER BY total_ingresos DESC;
--3
SELECT c.ciudad, SUM(dp.cantidad * dp.precio_unitario) AS ingresos_ciudad
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY c.ciudad;
--4
SELECT c.nombre, COUNT(p.id_pedido) AS total_pedidos
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente
ORDER BY total_pedidos DESC;
--5
SELECT pr.nombre, SUM(dp.cantidad) AS cantidad_total
FROM producto pr
JOIN detalle_pedido dp ON pr.id_producto = dp.id_producto
GROUP BY pr.id_producto
HAVING cantidad_total > 10;
--6
SELECT d.nombre, COUNT(e.id_entrega) AS total_entregas
FROM distribuidor d
JOIN ruta r ON d.id_distribuidor = r.id_distribuidor
JOIN pedido p ON r.id_ruta = p.id_ruta
JOIN entrega e ON p.id_pedido = e.id_pedido
WHERE e.estado = 'entregado'
GROUP BY d.id_distribuidor
ORDER BY total_entregas DESC;
--7
SELECT estado, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY estado;
--8
SELECT pr.nombre, SUM(i.stock) AS stock_global
FROM producto pr
JOIN inventario i ON pr.id_producto = i.id_producto
GROUP BY pr.id_producto;
--9
SELECT pl.nombre AS planta, pr.nombre AS producto, i.stock
FROM inventario i
JOIN planta pl ON i.id_planta = pl.id_planta
JOIN producto pr ON i.id_producto = pr.id_producto
WHERE i.stock < 40;
--10
SELECT r.nombre AS ruta, COUNT(p.id_pedido) AS numero_pedidos
FROM ruta r
JOIN pedido p ON r.id_ruta = p.id_ruta
GROUP BY r.id_ruta
ORDER BY numero_pedidos DESC;
--11
SELECT cat.nombre_categoria, SUM(dp.cantidad * dp.precio_unitario) AS ingresos_categoria
FROM categoria cat
JOIN producto pr ON cat.id_categoria = pr.id_categoria
JOIN detalle_pedido dp ON pr.id_producto = dp.id_producto
GROUP BY cat.id_categoria;
--12
SELECT AVG(total_pedido) AS promedio_ticket
FROM (
    SELECT SUM(cantidad * precio_unitario) AS total_pedido
    FROM detalle_pedido
    GROUP BY id_pedido
) AS subconsulta;


