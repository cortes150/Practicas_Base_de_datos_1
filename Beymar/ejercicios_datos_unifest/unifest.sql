CREATE DATABASE unifest_es CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE unifest_es;

-- 1) Tabla de roles (opcional para diferenciar permisos)
CREATE TABLE roles (
  id_rol INT AUTO_INCREMENT PRIMARY KEY,
  nombre_rol VARCHAR(50) NOT NULL UNIQUE,
  descripcion VARCHAR(255)
);
select * from roles;
INSERT INTO roles (nombre_rol, descripcion) VALUES
('admin','Administrador del sistema'),
('organizador','Organizador de eventos'),
('usuario','Asistente/usuario normal');
##2
insert into roles (nombre_rol, descripcion) values
('amplificacion', 'encargado del sonido y luces'),
('seguridad', 'controlar a las personas');

-- 2) Tabla de usuarios (login) - contraseñas en texto plano (solo demo)
CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  usuario VARCHAR(50) NOT NULL UNIQUE,
  contrasena VARCHAR(100) NOT NULL, -- texto plano intencionalmente
  correo VARCHAR(150),
  nombre_completo VARCHAR(150),
  id_rol INT NOT NULL DEFAULT 3,
  activo TINYINT(1) NOT NULL DEFAULT 1,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ultimo_acceso DATETIME NULL,
  CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

INSERT INTO usuarios (usuario, contrasena, correo, nombre_completo, id_rol) VALUES
('admin', 'admin123', 'admin@unifest.edu', 'Administrador UniFest', 1),
('javier', 'org2025', 'javier.morales@unifest.edu', 'Javier Morales', 2),
('ana', 'ana2025', 'ana.alvarez@unifest.edu', 'Ana Álvarez', 3),
('carlos', 'carlos2025', 'carlos.rivera@unifest.edu', 'Carlos Rivera', 3),
('luis', 'luis2025', 'luis.mendez@unifest.edu', 'Luis Méndez', 3),
('sofia', 'sofia2025', 'sofia.fernandez@unifest.edu', 'Sofía Fernández', 3);
##3
insert into usuarios (usuario, contrasena, correo, nombre_completo, id_rol) values
('angel', 'angel2060', 'angel.huanca@unifest.edu', 'Angel Huanca', 3),
('wilfredo', 'ampli2025', 'wilfredo.cusi@unifest.edu', 'Wilfredo Cusi', 4),
('david', 'david2025', 'david.perez@unifest.edu', 'David Perez', 5);
select * from usuarios;
select usuario from usuarios;

  

-- 3) Tabla de eventos
CREATE TABLE eventos (
  id_evento INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  descripcion TEXT,
  fecha_evento DATE NOT NULL,
  hora_evento TIME,
  lugar VARCHAR(150),
  aforo_total INT NOT NULL,
  creado_por INT NULL,
  creado_en DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_evento_creador FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario)
);
select * from eventos;
INSERT INTO eventos (titulo, descripcion, fecha_evento, hora_evento, lugar, aforo_total, creado_por) VALUES
('Concierto Rock Universitario', 'Bandas locales en vivo', '2025-11-15', '19:00:00', 'Auditorio Principal', 500, 2),
('Festival de Jazz', 'Noche de jazz con invitados', '2025-12-05', '20:30:00', 'Plaza Central', 300, 2);

-- 4) Tabla de tipos de entrada (por evento)
CREATE TABLE tipos_entrada (
  id_tipo INT AUTO_INCREMENT PRIMARY KEY,
  id_evento INT NOT NULL,
  nombre_tipo VARCHAR(50) NOT NULL, -- General, VIP, etc.
  precio DECIMAL(10,2) NOT NULL,
  cantidad_total INT NOT NULL,
  CONSTRAINT fk_tipo_evento FOREIGN KEY (id_evento) REFERENCES eventos(id_evento)
);
select * from tipos_entrada;
INSERT INTO tipos_entrada (id_evento, nombre_tipo, precio, cantidad_total) VALUES
(1, 'General', 40.00, 400),
(1, 'VIP', 120.00, 50),
(2, 'General', 30.00, 250),
(2, 'VIP', 100.00, 30);

-- 5) Tabla de entradas (boleto)
CREATE TABLE entradas (
  id_entrada INT AUTO_INCREMENT PRIMARY KEY,
  id_evento INT NOT NULL,
  id_tipo INT NOT NULL,
  id_comprador INT NULL, -- referencia a usuarios (nullable si venta en taquilla)
  codigo_qr VARCHAR(200) NULL UNIQUE,
  entrega ENUM('digital','fisica') DEFAULT 'digital',
  estado ENUM('reservada','vendida','cancelada') DEFAULT 'vendida',
  creado_en DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_entrada_evento FOREIGN KEY (id_evento) REFERENCES eventos(id_evento),
  CONSTRAINT fk_entrada_tipo FOREIGN KEY (id_tipo) REFERENCES tipos_entrada(id_tipo),
  CONSTRAINT fk_entrada_comprador FOREIGN KEY (id_comprador) REFERENCES usuarios(id_usuario)
);
select * from entradas;
INSERT INTO entradas (id_evento, id_tipo, id_comprador, codigo_qr, entrega, estado) VALUES
(1, 1, 3, 'QR-001-ANA', 'digital', 'vendida'),    -- ID 1
(1, 2, 3, 'QR-002-ANA', 'digital', 'vendida'),    -- ID 2
(1, 1, 5, 'QR-003-LUIS', 'fisica', 'vendida'),    -- ID 3 (Luis es ID 5)
(2, 3, 6, 'QR-004-SOFIA', 'digital', 'reservada'), -- ID 4 (Sofía es ID 6)
(2, 4, 6, 'QR-005-SOFIA', 'digital', 'cancelada'); -- ID 5

-- 6) Tabla de pagos (una entrada puede recibir varios pagos parciales)
CREATE TABLE pagos (
  id_pago INT AUTO_INCREMENT PRIMARY KEY,
  id_entrada INT NOT NULL,
  id_pagador INT NULL,
  monto DECIMAL(10,2) NOT NULL,
  fecha_pago DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  metodo_pago ENUM('efectivo','tarjeta','online') DEFAULT 'efectivo',
  CONSTRAINT fk_pago_entrada FOREIGN KEY (id_entrada) REFERENCES entradas(id_entrada),
  CONSTRAINT fk_pago_pagador FOREIGN KEY (id_pagador) REFERENCES usuarios(id_usuario)
);
select * from pagos;
INSERT INTO pagos (id_entrada, id_pagador, monto, metodo_pago) VALUES
(1, 3, 40.00, 'tarjeta'),
(2, 3, 60.00, 'tarjeta'),
(3, 5, 40.00, 'efectivo'), -- Pago de Luis
(4, 6, 15.00, 'online');   -- Pago parcial de Sofía

-- 7) Tabla de asistencia (historial)
CREATE TABLE asistencia (
  id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
  id_evento INT NOT NULL,
  id_usuario INT NOT NULL,
  id_entrada INT NULL,
  asistio TINYINT(1) DEFAULT 0,
  fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_asist_evento FOREIGN KEY (id_evento) REFERENCES eventos(id_evento),
  CONSTRAINT fk_asist_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_asist_entrada FOREIGN KEY (id_entrada) REFERENCES entradas(id_entrada)
);
select * from asistencia;
INSERT INTO asistencia (id_evento, id_usuario, id_entrada, asistio) VALUES
(1, 3, 1, 1), -- Ana asistió
(1, 5, 3, 0), -- Luis no ha llegado
(2, 6, 4, 0); -- Sofía no ha llegado

##EJERCICIOS
## 1. cambiar una entrada su estado a cancelada
update entradas set estado = 'cancelada' where id_entrada = 4;
##cambiar el precio de la entrada VIP
##actualizar el aforo del evento rock universitario que sea 600
##cambiar el metodo de pago tarjeta por ejectivo donde el indentificador es 9
##actualizar la asistencia del evento 2 