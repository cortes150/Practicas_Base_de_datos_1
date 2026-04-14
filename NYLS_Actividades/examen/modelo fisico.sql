create database segundo_examen;
use segundo_examen;

create table calificacion_final (
    total decimal(5, 2) not null,
    id_calificacion_final int auto_increment primary key
);

create table estudiante (
    id_estudiante int auto_increment primary key,
    nombre varchar(50) not null,
    carrera varchar(50) not null,
    edad int not null
);

create table calificacion_final (
    total decimal(5, 2) not null,
    id_calificacion_final int auto_increment primary key
);

create table proyecto_estudiante (
    id_proyecto int,
    id_estudiante int,
    id_proyectoestudiante int auto_increment primary key,
    foreign key (id_proyecto) references proyecto(id_proyecto),
    foreign key (id_estudiante) references estudiante(id_estudiante)
);

create table proyecto (
    id_proyecto int auto_increment primary key,
    id_materia int,
    tema varchar(50) not null,
    estado varchar(50) not null,
    fecha_presentacion date not null,
    foreign key (id_materia) references materia(id_materia)
);

create table materia (
    id_materia int auto_increment primary key,
    nombre varchar(50) not null,
    horario varchar(50),
    creditos int not null
);

create table proyecto_jurado (
    id_proyecto int,
    id_jurado int,
    id_proyecto_jurado int auto_increment primary key,
    foreign key (id_proyecto) references proyecto(id_proyecto),
    foreign key (id_jurado) references jurado(id_jurado)
);

create table jurado (
    id_jurado int auto_increment primary key,
    nombre varchar(50) not null,
    especialidad varchar(50) not null,
    id_criterios_de_evaluacion int,
    foreign key (id_criterios_de_evaluacion) references criterio_evaluacion(id_criterio_evaluacion)
);

create table criterio_evaluacion (
    id_criterio_evaluacion int auto_increment primary key,
    descripcion varchar(255) not null,
    puntaje decimal(3, 1),
    observaciones varchar(50),
    id_calificacion_final int,
    foreign key (id_calificacion_final) references calificacion_final(id_calificacion_final)
);

alter table proyecto 
add column observaciones varchar(50);

alter table proyecto 
modify column estado varchar(30);

insert into estudiante (nombre, carrera, edad) VALUES
('Juan Pérez', 'Ing. Electrónica', 22),
('Ana Gómez', 'Ing. Industrial', 25),
('Carlos Rodríguez', 'Ing. Mecánica', 30);

insert into proyecto_estudiante (id_proyecto, id_estudiante) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3);

insert into proyecto (id_materia, tema, fecha_presentacion) VALUES
(1, 'Sistemas Embebidos', '2026-04-05'),
(2, 'Desarrollo de Aplicaciones Android', '2026-05-15'),
(3, 'Redes de Datos', '2026-06-01'),
(4, 'Sistemas Operativos', '2026-07-10');

insert into criterio_evaluacion (descripcion, puntaje, observaciones, id_calificacion_final) VALUES
('Comprensión del Tema', 8.5, 'Buena comprensión', 1),
('Capacidad de Resolución de Problemas', 9.2, 'Excelente', 1),
('Creatividad', 7.8, '', 1);

insert into proyecto_jurado (id_proyecto, id_jurado) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);