INSERT INTO roles (nombre_rol, descripcion) VALUES
('guardia','Cuida el area del evento'),
('distribuidor','Se encargar de distribuir cosas');

INSERT INTO usuarios (usuario, contrasena, correo, nombre_completo, id_rol) VALUES
('kore','kore1234','kore@unifest.edu','Gustavo Quispe Torrez',4),
('ardi','koneko','ardi@unifest.edu','Alvin Fernando Tarifa Robles',4),
('rivan','dxd','rivan@unifest.edu','Mauricio Ivan Salces Sanchez',5);

-- insert del ej 4
INSERT INTO entradas (id_evento, id_tipo, id_comprador, codigo_qr, entrega, estado)
VALUES
(1, 1, 7, 'QR-006-KORE', 'fisica', 'vendida'),
(2, 2, 7, 'QR-007-KORE', 'digital', 'reservada'),
(2, 2, 8, 'QR-008-ARDI', 'digital', 'cancelada'),
(2, 2, 9, 'QR-009-RIVAN', 'digital', 'reservada');
INSERT INTO pagos (id_entrada, id_pagador, monto, metodo_pago)
VALUES
(6, 4, 40.00, 'efectivo'),
(7, 5, 15.00, 'online'),
(8, 4, 40.00, 'efectivo'),
(9, 5, 100.00, 'tarjeta');

Update usuarios
set correo = 'rivanrete@unifest.edu'
where id_usuario= 9;

-- Ejercicio 1
Update entradas
set estado = 'cancelada'
where id_entrada= 1;

-- Ejercicio 2
Update tipos_entrada
set precio = 250.50
where id_tipo= 2;

-- Ejercicio 3
Update eventos
set aforo_total = 600
where id_evento= 1;

-- Ejercicio 4
Update pagos
set metodo_pago = 'efectivo'
where id_pago= 9;

