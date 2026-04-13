create database RoboBattle;
use RoboBattle;

create table equipo(
	id_equipo int auto_increment primary key,
	nombre varchar(100),
	numero_integrantes int
);

create table arbitro(
	id_arbitro int auto_increment primary key,
	nombre varchar(100),
	A_P varchar(50),
	A_M varchar(50)
);

create table robot(
	id_robot int auto_increment primary key,
	id_equipo int, foreign key(id_equipo) references equipo(id_equipo),
	nombre varchar(100),
	categoria varchar(100),
	especificaciones varchar(200)
);

create table batalla(
	id_batalla int auto_increment primary key,
	id_arbitro int, foreign key(id_arbitro) references arbitro(id_arbitro),
	id_equipo_a int, foreign key(id_equipo_a) references equipo(id_equipo),
	id_equipo_b int, foreign key(id_equipo_b) references equipo(id_equipo),
	fecha_hora datetime,
	rondas int,
	formato varchar(100)
);

create table equipo_batalla(
	id_equipo_batalla int auto_increment primary key,
	id_equipo int, foreign key(id_equipo) references equipo(id_equipo),
	id_batalla int, foreign key(id_batalla) references batalla(id_batalla)
);

create table resultado(
	id_resultado int auto_increment primary key,
	id_batalla int, foreign key(id_batalla) references batalla(id_batalla),
	id_robot int, foreign key(id_robot) references robot(id_robot),
	ganador varchar(100),
	perdedor varchar(100)
);
