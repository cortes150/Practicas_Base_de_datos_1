

-- Ejercicios

-- REPORTES SQL – COCA COLA
-- 1. TOP PRODUCTOS MÁS VENDIDOS (por cantidad)
SELECT p.nombre, SUM(dp.cantidad) AS total_vendido
FROM producto p
JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY total_vendido DESC;

-- 2. TOP PRODUCTOS POR INGRESOS 
SELECT p.nombre, SUM(dp.cantidad * dp.precio_unitario) AS total_ingresos
FROM producto p
JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY total_ingresos DESC;

-- 3. VENTAS POR CIUDAD 
SELECT c.ciudad, SUM(dp.cantidad * dp.precio_unitario) AS total_ventas
FROM cliente c
JOIN pedido pe ON c.id_cliente = pe.id_cliente
JOIN detalle_pedido dp ON pe.id_pedido = dp.id_pedido
GROUP BY c.ciudad;

-- 4. CLIENTES QUE MÁS COMPRAN 
SELECT c.nombre, COUNT(pe.id_pedido) AS numero_pedidos, SUM(dp.cantidad * dp.precio_unitario) AS total_gastado
FROM cliente c
JOIN pedido pe ON c.id_cliente = pe.id_cliente
JOIN detalle_pedido dp ON pe.id_pedido = dp.id_pedido
GROUP BY c.id_cliente, c.nombre
ORDER BY total_gastado DESC;

-- 5. PRODUCTOS MÁS VENDIDOS POR CANTIDAD (> 10 unidades por ejemplo)
SELECT p.nombre, SUM(dp.cantidad) AS total
FROM producto p
JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
HAVING SUM(dp.cantidad) > 10;

-- 6. DISTRIBUIDOR CON MÁS ENTREGAS 
SELECT d.nombre, COUNT(e.id_entrega) AS entregas_realizadas
FROM distribuidor d
JOIN ruta r ON d.id_distribuidor = r.id_distribuidor
JOIN pedido p ON r.id_ruta = p.id_ruta
JOIN entrega e ON p.id_pedido = e.id_pedido
WHERE e.estado = 'entregado'
GROUP BY d.id_distribuidor, d.nombre
ORDER BY entregas_realizadas DESC;

-- 7. PEDIDOS POR ESTADO
SELECT estado, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY estado;

-- 8. STOCK TOTAL POR PRODUCTO (Suma de todas las plantas)
SELECT p.nombre, SUM(i.stock) AS stock_total
FROM producto p
JOIN inventario i ON p.id_producto = i.id_producto
GROUP BY p.id_producto, p.nombre;

-- 9. PRODUCTOS CON BAJO STOCK (Menos de 50 unidades)
SELECT p.nombre, i.stock, pl.nombre AS planta
FROM producto p
JOIN inventario i ON p.id_producto = i.id_producto
JOIN planta pl ON i.id_planta = pl.id_planta
WHERE i.stock < 50;

-- 10. RUTAS CON MÁS PEDIDOS
SELECT r.nombre, COUNT(p.id_pedido) AS total_pedidos
FROM ruta r
JOIN pedido p ON r.id_ruta = p.id_ruta
GROUP BY r.id_ruta, r.nombre
ORDER BY total_pedidos DESC;

-- 11. VENTAS POR CATEGORÍA 
SELECT c.nombre_categoria, SUM(dp.cantidad * dp.precio_unitario) AS total_ventas
FROM categoria c
JOIN producto p ON c.id_categoria = p.id_categoria
JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
GROUP BY c.id_categoria, c.nombre_categoria;

-- 12. PROMEDIO DE COMPRA POR PEDIDO 
SELECT AVG(subtotal) AS promedio_pedido
FROM (
    SELECT id_pedido, SUM(cantidad * precio_unitario) AS subtotal
    FROM detalle_pedido
    GROUP BY id_pedido
) AS totales;

-- 13. CLIENTES SIN PEDIDOS 
SELECT nombre 
FROM cliente 
WHERE id_cliente NOT IN (SELECT id_cliente FROM pedido);

-- 14. PEDIDOS NO ENTREGADOS 
SELECT id_pedido, fecha, estado 
FROM pedido 
WHERE estado != 'entregado';

-- 15. PRODUCTO MÁS VENDIDO (TOP 1)
SELECT p.nombre, SUM(dp.cantidad) AS total
FROM producto p
JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY total DESC
LIMIT 1;
-- EJERCICIOS CON ERRORES (SQL)
-- 1. Enunciado: Mostrar los productos más vendidos.

SELECT p.nombre, SUM(dp.cantidad)
FROM detalle_pedido dp
JOIN producto p
GROUP BY p.nombre;

-- Pista: Falta una condición clave en el JOIN.

-- 2. Enunciado: Mostrar ventas por ciudad.

SELECT c.ciudad, SUM(dp.cantidad * dp.precio_unitario)
FROM cliente c
INNER JOIN pedido p ON c.id_cliente = p.id_cliente
INNER JOIN detalle_pedido dp
GROUP BY c.ciudad;

--  Pista: Una tabla no está correctamente relacionada.

-- 3. Enunciado: Mostrar clientes que más compran.

SELECT c.nombre, SUM(dp.cantidad * dp.precio_unitario) total
FROM cliente c
INNER JOIN pedido p ON c.id_cliente = p.id_cliente
INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
ORDER BY total DESC;

-- Pista: Falta una cláusula importante para agrupar.

-- 4.  Enunciado: Mostrar productos con ventas mayores a 10.

SELECT p.nombre, SUM(dp.cantidad) total
FROM detalle_pedido dp
INNER JOIN producto p ON dp.id_producto = p.id_producto
WHERE total > 10
GROUP BY p.nombre;

-- Pista: No puedes usar alias en WHERE con agregaciones.

-- 5. Enunciado: Mostrar pedidos con su cliente.

SELECT p.id_pedido, c.nombre
FROM pedido p
JOIN cliente c;

-- Pista: Falta la condición de unión.

-- 6. Enunciado: Mostrar todas las rutas con sus pedidos.

SELECT r.nombre, p.id_pedido
FROM ruta r
LEFT JOIN pedido p ON r.id_ruta = p.id_pedido;

--  Pista: Estás relacionando columnas incorrectas.

-- 7. Enunciado: Mostrar inventario total por producto.

SELECT p.nombre, SUM(stock)
FROM inventario i
JOIN producto p ON i.id_producto = p.id_producto;

-- Pista: Falta agrupar.

-- 8. Enunciado: Mostrar pedidos entregados.

SELECT *
FROM pedido
WHERE estado = entregado;

-- Pista: Problema con tipos de datos (string).

-- 9.Enunciado: Mostrar clientes sin pedidos.

SELECT c.nombre
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_cliente = NULL;

-- Pista: Comparación incorrecta con NULL.

-- 10.Enunciado: Mostrar ventas por producto ordenadas.

SELECT p.nombre, SUM(dp.cantidad) total
FROM detalle_pedido dp
INNER JOIN producto p ON dp.id_producto = p.id_producto
GROUP BY p.nombre
ORDER total DESC;

-- Pista: Error de sintaxis en ORDER BY.

-- 11. Enunciado: Mostrar productos con su categoría.

SELECT p.nombre, c.nombre_categoria
FROM producto p
INNER JOIN categoria c ON p.id_producto = c.id_categoria;

-- Pista: Relación incorrecta.

-- 12. Enunciado: Mostrar pedidos con total.

SELECT id_pedido, SUM(cantidad * precio_unitario)
FROM detalle_pedido;

-- Pista: Falta agrupar por pedido.

-- 13. Enunciado: Mostrar número de pedidos por cliente.

SELECT c.nombre, COUNT(p.id_pedido)
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY p.id_pedido;

-- Pista: Estás agrupando por la columna incorrecta.

-- 14. Enunciado: Mostrar productos que tengan stock mayor a 50.

SELECT p.nombre, i.stock
FROM producto p
INNER JOIN inventario i ON p.id_producto = i.id_producto
HAVING i.stock > 50;

-- Pista: Uso incorrecto de HAVING.

-- 15. Enunciado: Mostrar rutas sin pedidos.

SELECT r.nombre
FROM ruta r
LEFT JOIN pedido p ON r.id_ruta = p.id_ruta
WHERE p.id_ruta != NULL;