USE cocacola_db;
-- Ejercicios

-- REPORTES SQL – COCA COLA

-- 1. TOP PRODUCTOS MÁS VENDIDOS  x (por cantidad)
 SELECT p.nombre AS nombre_producto, dp.cantidad AS cantidad FROM producto p 
 INNER JOIN detalle_pedido dp ON p.id_producto=dp.id_producto ORDER BY dp.cantidad DESC;
 
-- 2. TOP PRODUCTOS POR INGRESOS 
 
--  3. VENTAS POR CIUDAD 
 
-- 4. CLIENTES QUE MÁS COMPRAN 
 
-- 5. PRODUCTOS MÁS VENDIDOS POR CANTIDAD (> X)
 
-- 6. DISTRIBUIDOR CON MÁS ENTREGAS 
 
-- 7. PEDIDOS POR ESTADO
 
-- 8. STOCK TOTAL POR PRODUCTO
 
-- 9. PRODUCTOS CON BAJO STOCK 

--  10. RUTAS CON MÁS PEDIDOS
 
-- 11. VENTAS POR CATEGORÍA 

 
-- 12. PROMEDIO DE COMPRA POR PEDIDO 
 
--  13. CLIENTES SIN PEDIDOS 
 
-- 14. PEDIDOS NO ENTREGADOS 

 
-- 15. PRODUCTO MÁS VENDIDO (TOP 1) 


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