-- EJERCICIOS CON ERRORES (SQL)
-- 1. Enunciado: Mostrar los productos más vendidos.

SELECT p.nombre, SUM(dp.cantidad) AS total_vendido
FROM detalle_pedido dp
JOIN producto p ON dp.id_producto = p.id_producto
GROUP BY p.nombre;

-- Pista: Falta una condición clave en el JOIN.

-- 2. Enunciado: Mostrar ventas por ciudad.

SELECT c.ciudad, SUM(dp.cantidad * dp.precio_unitario) AS total_ventas
FROM cliente c
INNER JOIN pedido p ON c.id_cliente = p.id_cliente
INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY c.ciudad;

--  Pista: Una tabla no está correctamente relacionada.

-- 3. Enunciado: Mostrar clientes que más compran.

SELECT c.nombre, SUM(dp.cantidad * dp.precio_unitario) AS total
FROM cliente c
INNER JOIN pedido p ON c.id_cliente = p.id_cliente
INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY c.nombre
ORDER BY total DESC;

-- Pista: Falta una cláusula importante para agrupar.

-- 4.  Enunciado: Mostrar productos con ventas mayores a 10.

SELECT p.nombre, SUM(dp.cantidad) AS total
FROM detalle_pedido dp
INNER JOIN producto p ON dp.id_producto = p.id_producto
GROUP BY p.nombre
HAVING total > 10;

-- Pista: No puedes usar alias en WHERE con agregaciones.

-- 5. Enunciado: Mostrar pedidos con su cliente.

SELECT p.id_pedido, c.nombre
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente;

-- Pista: Falta la condición de unión.

-- 6. Enunciado: Mostrar todas las rutas con sus pedidos.

SELECT r.nombre, p.id_pedido
FROM ruta r
LEFT JOIN pedido p ON r.id_ruta = p.id_ruta;

--  Pista: Estás relacionando columnas incorrectas.

-- 7. Enunciado: Mostrar inventario total por producto.

SELECT p.nombre, SUM(i.stock) AS total_stock
FROM inventario i
JOIN producto p ON i.id_producto = p.id_producto
GROUP BY p.nombre;

-- Pista: Falta agrupar.

-- 8. Enunciado: Mostrar pedidos entregados.

SELECT *
FROM pedido
WHERE estado = 'entregado';

-- Pista: Problema con tipos de datos (string).

-- 9.Enunciado: Mostrar clientes sin pedidos.

SELECT c.nombre
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_cliente IS NULL;

-- Pista: Comparación incorrecta con NULL.

-- 10.Enunciado: Mostrar ventas por producto ordenadas.

SELECT p.nombre, SUM(dp.cantidad) AS total
FROM detalle_pedido dp
INNER JOIN producto p ON dp.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY total DESC;

-- Pista: Error de sintaxis en ORDER BY.

-- 11. Enunciado: Mostrar productos con su categoría.

SELECT p.nombre, SUM(dp.cantidad) AS total
FROM detalle_pedido dp
INNER JOIN producto p ON dp.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY total DESC;

-- Pista: Relación incorrecta.

-- 12. Enunciado: Mostrar pedidos con total.

SELECT id_pedido, SUM(cantidad * precio_unitario) AS total_pedido
FROM detalle_pedido
GROUP BY id_pedido;

-- Pista: Falta agrupar por pedido.

-- 13. Enunciado: Mostrar número de pedidos por cliente.

SELECT c.nombre, COUNT(p.id_pedido) AS num_pedidos
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.nombre;

-- Pista: Estás agrupando por la columna incorrecta.

-- 14. Enunciado: Mostrar productos que tengan stock mayor a 50.

SELECT p.nombre, i.stock
FROM producto p
INNER JOIN inventario i ON p.id_producto = i.id_producto
WHERE i.stock > 50;

-- Pista: Uso incorrecto de HAVING.

-- 15. Enunciado: Mostrar rutas sin pedidos.

SELECT r.nombre, p.estado as r_nombre
FROM ruta r
left JOIN pedido p ON r.id_ruta = p.id_ruta
where p.id_ruta is null;