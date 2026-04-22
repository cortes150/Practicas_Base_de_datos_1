-- MODELO FÍSICO – MYSQL

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