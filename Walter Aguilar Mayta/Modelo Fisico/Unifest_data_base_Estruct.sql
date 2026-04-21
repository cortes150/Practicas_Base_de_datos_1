CREATE DATABASE unifest_es CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE unifest_es;

-- 1) Tabla de roles (opcional para diferenciar permisos)
CREATE TABLE roles (
  id_rol INT AUTO_INCREMENT PRIMARY KEY,
  nombre_rol VARCHAR(50) NOT NULL UNIQUE,
  descripcion VARCHAR(255)
);


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

-- 4) Tabla de tipos de entrada (por evento)
CREATE TABLE tipos_entrada (
  id_tipo INT AUTO_INCREMENT PRIMARY KEY,
  id_evento INT NOT NULL,
  nombre_tipo VARCHAR(50) NOT NULL, -- General, VIP, etc.
  precio DECIMAL(10,2) NOT NULL,
  cantidad_total INT NOT NULL,
  CONSTRAINT fk_tipo_evento FOREIGN KEY (id_evento) REFERENCES eventos(id_evento)
);

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