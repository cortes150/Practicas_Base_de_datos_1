USE cocacola_db;
-- Ejercicios
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