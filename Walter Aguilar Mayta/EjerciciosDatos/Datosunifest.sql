
-- Ejercicio 1: Insertar 2 roles
INSERT INTO roles (nombre_rol, descripcion) VALUES
('supervisor','Supervisor en el evento '),
('guardia','Guardia en el evento');

-- Ejercicio 2: Insertar 3 usuarios
INSERT INTO usuarios (usuario, contrasena, correo, nombre_completo, id_rol) VALUES
('apaza','apaza123','rocks@unifest.edu','Administrador UniFest',4),
('salces','salces2025','salces@unifest.edu','Ana Álvarez',5),
('pepito','pepito2025','pepito@unifest.edu','Carlos Rivera',5);
-- Ejercicio 3: Cancelar una entrada
UPDATE entradas SET estado="cancelada" WHERE id_entrada = 1;
-- Ejercicio 4: cambiar precio entrada vip

UPDATE tipos_entrada SET precio=160 WHERE nombre_tipo="VIP" ;
-- UPDATE tipos_entrada SET precio=160 WHERE id_tipo=2 ; 

-- Ejercicio 5: actualizar el aforo del evento : rock universitario , nuevo aforo a 600
UPDATE eventos SET aforo_total=600 WHERE titulo='Concierto Rock Universitario';

-- Ejercicio 6: cambiar el metodo de pago tarjeta por efectivo donde el identificador es 9

UPDATE pagos SET metodo_pago="efectivo" WHERE id_pago = 9;

-- Ejercicio 7: actualizar la asistencia del evento 2 

