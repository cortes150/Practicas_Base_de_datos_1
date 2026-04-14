-- Creación de tablas
CREATE TABLE estudiante(
    Id_estudiante SERIAL PRIMARY KEY,
    Nombre VARCHAR(50),
    Ap_paterno VARCHAR(50),
    Ap_materno VARCHAR(50),
    Carnet_identidad VARCHAR(50),
    edad INT,
    Carrera VARCHAR(50),
    Calle VARCHAR(50),
    Av VARCHAR(50)
);

CREATE TABLE telefono_estudiante(
    Id_telefeno_estudiante SERIAL PRIMARY KEY,
    id_estudiante int,
    numero varchar(50),
    foreign key (id_estudiante) references estudiante(id_estudiante)
);

CREATE TABLE materia(
    id_materia SERIAL PRIMARY KEY,
    nombre varchar(50)
);

CREATE TABLE proyecto(
    Id_proyecto SERIAL PRIMARY KEY,
    Nombre_tema varchar(50), 
    Fecha date,
    Id_materia int,
    categoria varchar(50),
    estado varchar(50),
    foreign key (id_materia) references materia(id_materia)
);

CREATE TABLE jurado (
    Id_jurado SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    Titulo_academico VARCHAR(50)
);

CREATE TABLE telefono_jurado(
    Id_telefeno_jurado SERIAL PRIMARY KEY,
    id_jurado INT,
    numero VARCHAR(50),
    foreign key (id_jurado) references jurado(id_jurado)
);

CREATE TABLE materia_jurado(
    Id_materia_jurado SERIAL PRIMARY KEY,
    id_jurado int,
    materia_que_dicta varchar (50),
    foreign key (id_jurado) references jurado(id_jurado)
);

CREATE TABLE evaluacion(
    id_evaluacion SERIAL PRIMARY KEY,
    id_jurado int,
    id_proyecto int,
    observacion text,
    foreign key (id_jurado) references jurado(id_jurado),
    foreign key (id_proyecto) references proyecto(id_proyecto)
);

CREATE TABLE estudiante_proyecto(
    id_estudiante_proyecto SERIAL PRIMARY KEY,
    id_proyecto int,
    id_estudiante int,
    foreign key (id_proyecto) references proyecto(id_proyecto),
    foreign key (id_estudiante) references estudiante(id_estudiante)
);

CREATE TABLE criterio(
    id_criterio SERIAL PRIMARY KEY,
    nombre_criterio varchar(50),
    puntaje int
);

CREATE TABLE criterio_evaluacion (
    id_criterio_evaluacion SERIAL PRIMARY KEY,
    Id_criterio int,
    Id_evaluacion int,
    foreign key (id_criterio) references criterio(id_criterio),
    foreign key (id_evaluacion) references evaluacion(id_evaluacion)
);

-- Modificaciones de tabla
ALTER TABLE proyecto ADD COLUMN observaciones varchar(50);
ALTER TABLE proyecto ALTER COLUMN estado TYPE varchar(30);

-- Inserción de datos iniciales
INSERT INTO estudiante (Nombre, Ap_paterno, Ap_materno, Carnet_identidad, edad, Carrera, Calle, Av)
VALUES 
('Cruz', 'poma', 'jurado', '13765299', 22, 'ing.sistemas', 'Pando', 'villa salvador'),
('Carlos', 'montes', 'quino', '65435299', 23, 'ing.sistemas', 'buch', 'villa fatima');