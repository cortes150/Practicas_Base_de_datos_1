INSERT INTO roles (nombre_rol, descripcion,id_usuario) VALUES
('admin','Administrador del sistema'),
('organizador','Organizador de eventos'),
('usuario','Asistente/usuario normal');

-- 8) Datos de ejemplo (usuarios)
INSERT INTO usuarios (usuario, contrasena, corre, nombre_completo, id_rol) VALUES
('admin','admin123','admin@unifest.edu','Administrador UniFest',1),
('javier','org2025','javier.morales@unifest.edu','Javier Morales',2),
('ana','ana2025','ana.alvarez@unifest.edu','Ana Álvarez',3),
('carlos','carlos2025','carlos.rivera@unifest.edu','Carlos Rivera',3);

-- 9 Eventos de ejemplo
INSERT INTO eventos (titulo, descripcion, fecha_evento, hora_evento, lugar, aforo_total, creado_por) VALUES
('Concierto Rock Universitario','Bandas locales en vivo','2025-11-15','19:00:00','Auditorio Principal',500,2),
('Festival de Jazz','Noche de jazz con invitados','2025-12-05','20:30:00','Plaza Central',300,2);

-- 10) Tipos de entrada de ejemplo
INSERT INTO tipos_entrada (id_evento, nombre_tipo, precio, cantidad_total) VALUES
(1,'General',40.00,400),
(1,'VIP',120.00,50),
(2,'General',30.00,250),
(2,'VIP',100.00,30);

-- 11) Entradas de ejemplo (ventas)
-- Ana compra 1 entrada general y 1 VIP para evento 1
INSERT INTO entradas (id_evento, id_tipo, id_comprador, codigo_qr, entrega, estado)
VALUES
(1, 1, 3, 'QR-001-ANA', 'digital', 'vendida'),
(1, 2, 3, 'QR-002-ANA', 'digital', 'vendida');                             

-- 12) Pagos de ejemplo
INSERT INTO pagos (id_entrada_, id_pagador, monto, metodo_pago) VALUES
(1, 3, 40.00, 'tarjeta'),
(2, 3, 60.00, 'tarjeta'); -- pago parcial (ejemplo)

-- 13) Asistencia (registro inicial vacío o con ejemplo)
INSERT INTO asistencia (id_evento, id_usuario, id_entrada, asistio)
VALUES
(1, 3, 1, 0);

INSERT INTO usuarios (usuario, contrasena, correo, nombre_completo, id_rol)
VALUES
('luis', 'luis2025', 'luis.mendez@unifest.edu', 'Luis Méndez', 3),
('sofia', 'sofia2025', 'sofia.fernandez@unifest.edu', 'Sofía Fernández', 3);

INSERT INTO entradas (id_evento, id_tipo, id_comprador, codigo_qr, entrega, estado)
VALUES
(1, 1, 4, 'QR-003-LUIS', 'fisica', 'vendida'),
(2, 3, 5, 'QR-004-SOFIA', 'digital', 'reservada'),
(2, 4, 5, 'QR-005-SOFIA', 'digital', 'cancelada');


INSERT INTO pagos (id_entrada, id_pagador, monto, metodo_pago,id_asistencia)
VALUES
(3, 4, 40.00, 'efectivo'),
(4, 5, 15.00, 'online'),
(5, 5, 100.00, 'tarjeta');


INSERT INTO asistencia (id_evento, id_usuario, id_entrada, asistio)
VALUES
(1, 3, 1, 1),
(1, 4, 3, 0),
(2, 5, 4, 0),
(2, 5, 5, 1);