
CREATE DATABASE cocacola_db;
USE cocacola_db;

-- 1. CATEGORIA
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);
-- 2. PRODUCTO
CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    tamano VARCHAR(50),
    id_categoria INT,
    
    CONSTRAINT fk_producto_categoria
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- 3. PLANTA
CREATE TABLE planta (
    id_planta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    ciudad VARCHAR(100)
);

-- 4. INVENTARIO (N:M)
CREATE TABLE inventario (
    id_planta INT,
    id_producto INT,
    stock INT NOT NULL,
    
    PRIMARY KEY (id_planta, id_producto),
    
    CONSTRAINT fk_inv_planta
    FOREIGN KEY (id_planta) REFERENCES planta(id_planta),
    
    CONSTRAINT fk_inv_producto
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);
-- 5. DISTRIBUIDOR
CREATE TABLE distribuidor (
    id_distribuidor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20)
);
-- 6. RUTA
CREATE TABLE ruta (
    id_ruta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    ciudad VARCHAR(100),
    id_distribuidor INT,
    
    CONSTRAINT fk_ruta_distribuidor
    FOREIGN KEY (id_distribuidor) REFERENCES distribuidor(id_distribuidor)
);
-- 7. CLIENTE
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo ENUM('tienda','supermercado','restaurante'),
    ciudad VARCHAR(100)
);
-- 8. PEDIDO
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    estado ENUM('pendiente','en_ruta','entregado'),
    id_cliente INT,
    id_ruta INT,
    
    CONSTRAINT fk_pedido_cliente
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    
    CONSTRAINT fk_pedido_ruta
    FOREIGN KEY (id_ruta) REFERENCES ruta(id_ruta)
);
-- 9. DETALLE_PEDIDO (N:M)
CREATE TABLE detalle_pedido (
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2),
    
    PRIMARY KEY (id_pedido, id_producto),
    
    CONSTRAINT fk_dp_pedido
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    
    CONSTRAINT fk_dp_producto
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);
-- 10. ENTREGA
CREATE TABLE entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    fecha_entrega DATE,
    estado ENUM('pendiente','en_ruta','entregado'),
    id_pedido INT UNIQUE,
    
    CONSTRAINT fk_entrega_pedido
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- llenado de datos
-- 1. CATEGORIA
INSERT INTO categoria (nombre_categoria) VALUES
('Gaseosas'),
('Energizantes'),
('Jugos'),
('Agua'),
('Bebidas isotónicas');
-- 2. PRODUCTO
INSERT INTO producto (nombre, precio, tamano, id_categoria) VALUES
('Coca Cola 500ml', 5.00, '500ml', 1),
('Coca Cola 1L', 8.00, '1L', 1),
('Fanta 500ml', 4.50, '500ml', 1),
('Sprite 500ml', 4.50, '500ml', 1),
('Powerade 600ml', 6.00, '600ml', 5),
('Burn 250ml', 7.00, '250ml', 2),
('Minute Maid Naranja', 6.50, '1L', 3),
('Del Valle Mango', 6.50, '1L', 3),
('Agua Vital 500ml', 3.00, '500ml', 4),
('Agua Vital 1L', 4.50, '1L', 4);
-- 3. PLANTA
INSERT INTO planta (nombre, ciudad) VALUES
('Planta La Paz', 'La Paz'),
('Planta Santa Cruz', 'Santa Cruz'),
('Planta Cochabamba', 'Cochabamba');
-- 4. INVENTARIO
INSERT INTO inventario (id_planta, id_producto, stock) VALUES
(1,1,100),(1,2,80),(1,3,60),(1,4,70),
(2,5,90),(2,6,50),(2,7,40),(2,8,60),
(3,9,120),(3,10,100),
(1,5,30),(2,1,40),(3,2,50),(1,9,60),(2,10,70);
-- 5. DISTRIBUIDOR
INSERT INTO distribuidor (nombre, telefono) VALUES
('Distribuidor Norte','70011111'),
('Distribuidor Sur','70022222'),
('Distribuidor Centro','70033333');
-- 6. RUTA
INSERT INTO ruta (nombre, ciudad, id_distribuidor) VALUES
('Ruta 1','La Paz',1),
('Ruta 2','La Paz',1),
('Ruta 3','Santa Cruz',2),
('Ruta 4','Cochabamba',3),
('Ruta 5','Santa Cruz',2);
-- 7. CLIENTE
INSERT INTO cliente (nombre, tipo, ciudad) VALUES
('Tienda Don Pepe','tienda','La Paz'),
('Supermercado Max','supermercado','Santa Cruz'),
('Restaurante Sabor','restaurante','Cochabamba'),
('Tienda Central','tienda','La Paz'),
('Mini Market Sur','tienda','Santa Cruz');
-- 8. PEDIDO
INSERT INTO pedido (fecha, estado, id_cliente, id_ruta) VALUES
('2026-05-01','pendiente',1,1),
('2026-05-02','entregado',2,3),
('2026-05-03','en_ruta',3,4),
('2026-05-04','entregado',4,2),
('2026-05-05','pendiente',5,5);
-- 9. DETALLE_PEDIDO
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1,1,10,5.00),
(1,3,5,4.50),
(2,2,8,8.00),
(2,6,6,7.00),
(3,5,7,6.00),
(3,7,4,6.50),
(4,1,12,5.00),
(4,9,10,3.00),
(5,10,15,4.50),
(5,4,5,4.50);
-- 10. ENTREGA
INSERT INTO entrega (fecha_entrega, estado, id_pedido) VALUES
('2026-05-02','pendiente',1),
('2026-05-03','entregado',2),
('2026-05-04','en_ruta',3),
('2026-05-05','entregado',4),
('2026-05-06','pendiente',5);


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

-- --- ------ ------------------------------------ ----------------------------------------------
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