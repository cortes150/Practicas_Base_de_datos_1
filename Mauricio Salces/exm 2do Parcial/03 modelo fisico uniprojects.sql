create table uniprojects;
use uniprojects;

create table carrera(
	id_carrera int auto_increment primary key, 
    inscritos int,
    semestres int
);

create table estudiante(
	id_codigo int auto_increment primary key, 
    nombre varchar(50),
    a_p varchar(50),
    a_m varchar(50),
    
    id_carrera int, foreign key(id_carrera) references carrera(id_carrera)
);

create table materia(
	id_materia int auto_increment primary key, 
    
    id_carrera int, foreign key(id_carrera) references carrera(id_carrera)
);

create table proyecto(
	id_proyecto int auto_increment primary key,
    tema Varchar(50),
    categoria Varchar(50),
    fecha date,
    
    id_materia int, foreign key(id_materia) references materia(id_materia)
);

create table jurado(
	id_jurado int auto_increment primary key,
    nombre varchar(50),
    a_p varchar(50),
    a_m varchar(50),
    criterio varchar(100)
);

create table e_p(
	id_e_p int auto_increment primary key,
    
    id_proyecto int, foreign key(id_proyecto) references proyecto(id_proyecto),
    id_codigo int, foreign key(id_codigo) references estudiante(id_codigo)
);

create table p_j(
	id_p_j int auto_increment primary key,
    
    id_jurado int, foreign key(id_jurado) references jurado(id_jurado),
    id_proyecto int, foreign key(id_proyecto) references proyecto(id_proyecto)
);

create table Evaluacion(
	id_evaluacion int auto_increment primary key,
    puntaje double,
    observaciones varchar(100),
    
    id_jurado int, foreign key(id_jurado) references jurado(id_jurado),
    id_proyecto int, foreign key(id_proyecto) references proyecto(id_proyecto)
);


alter table proyecto
add observaciones varchar(100),
add estado varchar(20),
modify estado varchar(30);

alter table materia
add nombre varchar(50);

alter table carrera
add nombre varchar(50);

insert into carrera(inscritos,semestres,nombre)values
(50,8,'medicina'),
(100,8,'sistemas'),
(60,8,'mecatronica');

insert into estudiante(Nombre,a_p,a_m,id_carrera)values
('mauricio','salces','sanchez',1),
('kore','torrez','quispe',2),
('ardilla','tarifa','robles',3);


insert into materia(id_carrera,nombre)values
(1,'pulmon 2'),
(2,'Base de datos 1'),
(3,'Circuitos 3');


insert into proyecto(tema,categoria,fecha,observaciones,estado)values
('Cura al cancer','decubrimiento','2026/04/14','Poco original','Reprobado'),
('Ia que genera mas ia','innovacion','2026/05/15','Proyecto innovador','Aprobado'),
('Exterminador de comunistas','militar','2026/06/16','Peligroso','Aprobado');


insert into jurado(Nombre,a_p,a_m,criterio)values
('Raquel','Paez','Pinto',''),
('Wilfred','Alfarez','Cusidiano',''),
('Ivan','salces','sanchez','');


insert into e_p(id_proyecto,id_codigo)values
(1,1),
(2,2),
(3,3);


insert into p_j(id_jurado,id_proyecto)values
(1,1),
(2,2),
(3,3);

insert into evaluacion(puntaje,observaciones,id_jurado,id_proyecto)values
(8.8,'la cura al cancer no es relevante hoy en dia',1,1),
(84,'la ia la falta una pulida y queda lista',2,2),
(98.5,'muy interesante pero lamentablemente ya no existen comunistas',3,3);


update proyecto
set estado = 'Aprobado'
where id_proyecto = 1;
select * from proyecto;


delete from estudiante
where id_codigo = 1;
select * from estudiante;


