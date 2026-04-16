INSERT INTO roles (nombre_rol, descripcion) VALUES
('guardia','Cuida el area del evento'),
('distribuidor','Se encargar de distribuir cosas');

INSERT INTO usuarios (usuario, contrasena, correo, nombre_completo, id_rol) VALUES
('kore','kore1234','kore@unifest.edu','Gustavo Quispe Torrez',4),
('ardi','koneko','ardi@unifest.edu','Alvin Fernando Tarifa Robles',4),
('rivan','dxd','rivan@unifest.edu','Mauricio Ivan Salces Sanchez',5);

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
where id_evento= 2;