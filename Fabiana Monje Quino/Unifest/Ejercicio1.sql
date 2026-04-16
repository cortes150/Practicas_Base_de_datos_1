
-- 1) Tabla de roles (opcional para diferenciar permisos)
CREATE TABLE roles (
  id_rol SERIAL PRIMARY KEY,
  nombre_rol VARCHAR(50) NOT NULL UNIQUE,
  descripcion VARCHAR(255)
);


-- 2) Tabla de usuarios (login) - contraseñas en texto plano (solo demo)
CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(100) NOT NULL, -- Nota: Se recomienda usar pgcrypto para hasear esto después
    correo VARCHAR(150),
    nombre_completo VARCHAR(150),
    id_rol INT NOT NULL DEFAULT 3,
    activo SMALLINT NOT NULL DEFAULT 1,
    creado_en TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP WITH TIME ZONE NULL,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

-- 3) Tabla de eventos
CREATE TABLE eventos (
  id_evento SERIAL PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  descripcion TEXT,
  fecha_evento DATE NOT NULL,
  hora_evento TIME,
  lugar VARCHAR(150),
  aforo_total INT NOT NULL,
  creado_por INT NULL,
  creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_evento_creador FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario)
);

-- 4) Tabla de tipos de entrada
CREATE TABLE tipos_entrada (
  id_tipo SERIAL PRIMARY KEY,
  id_evento INT NOT NULL,
  nombre_tipo VARCHAR(50) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  cantidad_total INT NOT NULL,
  CONSTRAINT fk_tipo_evento FOREIGN KEY (id_evento) REFERENCES eventos(id_evento)
);
CREATE TYPE tipo_entrega AS ENUM ('digital', 'fisica');
CREATE TYPE estado_entrada AS ENUM ('reservada', 'vendida', 'cancelada');
-- 5) Tabla de entradas (boleto)
CREATE TABLE entradas (
  id_entrada SERIAL PRIMARY KEY,
  id_evento INT NOT NULL,
  id_tipo INT NOT NULL,
  id_comprador INT NULL, 
  codigo_qr VARCHAR(200) NULL UNIQUE,
  entrega tipo_entrega DEFAULT 'digital',
  estado estado_entrada DEFAULT 'vendida',
  creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_entrada_evento FOREIGN KEY (id_evento) REFERENCES eventos(id_evento),
  CONSTRAINT fk_entrada_tipo FOREIGN KEY (id_tipo) REFERENCES tipos_entrada(id_tipo),
  CONSTRAINT fk_entrada_comprador FOREIGN KEY (id_comprador) REFERENCES usuarios(id_usuario)
);

-- 6) Tabla de pagos (una entrada puede recibir varios pagos parciales)
CREATE TYPE tipo_metodo_pago AS ENUM ('efectivo', 'tarjeta', 'online');

-- 2. Ahora creamos la tabla usando ese tipo
CREATE TABLE pagos (
  id_pago SERIAL PRIMARY KEY,
  id_entrada INT NOT NULL,
  id_pagador INT NULL,
  monto DECIMAL(10,2) NOT NULL,
  fecha_pago TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  metodo_pago tipo_metodo_pago DEFAULT 'efectivo',
  CONSTRAINT fk_pago_entrada FOREIGN KEY (id_entrada) REFERENCES entradas(id_entrada),
  CONSTRAINT fk_pago_pagador FOREIGN KEY (id_pagador) REFERENCES usuarios(id_usuario)
);

-- 7) Tabla de asistencia (historial)
CREATE TABLE asistencia (
  id_asistencia SERIAL PRIMARY KEY,
  id_evento INT NOT NULL,
  id_usuario INT NOT NULL,
  id_entrada INT NULL,
  asistio SMALLINT NOT NULL DEFAULT 0,
  fecha_registro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_asist_evento FOREIGN KEY (id_evento) REFERENCES eventos(id_evento),
  CONSTRAINT fk_asist_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_asist_entrada FOREIGN KEY (id_entrada) REFERENCES entradas(id_entrada)
);

-- 1) Roles
INSERT INTO roles (nombre_rol, descripcion) VALUES
('admin','Administrador del sistema'),
('organizador','Organizador de eventos'),
('usuario','Asistente/usuario normal');

-- 2) Usuarios
INSERT INTO usuarios (usuario, contrasena, correo, nombre_completo, id_rol) VALUES
('admin','admin123','admin@unifest.edu','Administrador UniFest',1),
('javier','org2025','javier.morales@unifest.edu','Javier Morales',2),
('ana','ana2025','ana.alvarez@unifest.edu','Ana Álvarez',3),
('carlos','carlos2025','carlos.rivera@unifest.edu','Carlos Rivera',3),
('luis', 'luis2025', 'luis.mendez@unifest.edu', 'Luis Méndez', 3),
('sofia', 'sofia2025', 'sofia.fernandez@unifest.edu', 'Sofía Fernández', 3);

-- 3) Eventos
INSERT INTO eventos (titulo, descripcion, fecha_evento, hora_evento, lugar, aforo_total, creado_por) VALUES
('Concierto Rock Universitario','Bandas locales en vivo','2025-11-15','19:00:00','Auditorio Principal',500,2),
('Festival de Jazz','Noche de jazz con invitados','2025-12-05','20:30:00','Plaza Central',300,2);

-- 4) Tipos de entrada
INSERT INTO tipos_entrada (id_evento, nombre_tipo, precio, cantidad_total) VALUES
(1,'General',40.00,400),
(1,'VIP',120.00,50),
(2,'General',30.00,250),
(2,'VIP',100.00,30);

-- 5) Entradas
INSERT INTO entradas (id_evento, id_tipo, id_comprador, codigo_qr, entrega, estado) VALUES
(1, 1, 3, 'QR-001-ANA', 'digital', 'vendida'),
(1, 2, 3, 'QR-002-ANA', 'digital', 'vendida'),
(1, 1, 4, 'QR-003-LUIS', 'fisica', 'vendida'),
(2, 3, 5, 'QR-004-SOFIA', 'digital', 'reservada'),
(2, 4, 5, 'QR-005-SOFIA', 'digital', 'cancelada');

-- 6) Pagos
INSERT INTO pagos (id_entrada, id_pagador, monto, metodo_pago) VALUES
(1, 3, 40.00, 'tarjeta'),
(2, 3, 60.00, 'tarjeta'),
(3, 4, 40.00, 'efectivo'),
(4, 5, 15.00, 'online'),
(5, 5, 100.00, 'tarjeta');

-- 7) Asistencia
INSERT INTO asistencia (id_evento, id_usuario, id_entrada, asistio) VALUES
(1, 3, 1, 1),
(1, 4, 3, 0),
(2, 5, 4, 0),
(2, 5, 5, 1);

select * from pagos
select * from pagos where metodo_pago = 'efectivo'
select * from eventos
--3 usuarios mas update usuarios set 
insert into roles (nombre_rol, descripcion) VALUES
('admin_entradas','Administrador de entradas'),
('Asistencia','Organizador de asistencia')
select * from roles

INSERT INTO usuarios (usuario, contrasena, correo, nombre_completo, id_rol) VALUES
('jhon','jhon123','jhon@unifest.edu','Admin_entradas',4),
('javiermontes','montes2025','montes@unifest.edu','Javier Montes',5),
('maria','maria2024','maria@unifest.edu','Maria Limachi',4)
select * from entradas
update usuarios set correo ='mariamontes@unifest.edu' where id_usuario = 9

--EJERCICIO 1--
--cambiar el precio de la entrada a vip
select * from tipos_entrada
update tipos_entrada set nombre_tipo ='vip'
--cambiar el estado de una entrada a cancelada
--actualizar el aforo del evento rock que sea 600
--cambiar el metodo de pago tarjeta por efectivo donde el identificador es 9
--actualizar la asistencia del evento 2
