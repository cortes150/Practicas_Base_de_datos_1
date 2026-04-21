INSERT INTO roles (nombre_rol, descripcion) VALUES
('supervisor','Supervisor en el evento '),
('guardia','Guardia en el evento');

-- 8) Datos de ejemplo (usuarios)
INSERT INTO usuarios (usuario, contrasena, correo, nombre_completo, id_rol) VALUES
('apaza','apaza123','rocks@unifest.edu','Administrador UniFest',4),
('salces','salces2025','salces@unifest.edu','Ana Álvarez',5),
('pepito','pepito2025','pepito@unifest.edu','Carlos Rivera',5);
