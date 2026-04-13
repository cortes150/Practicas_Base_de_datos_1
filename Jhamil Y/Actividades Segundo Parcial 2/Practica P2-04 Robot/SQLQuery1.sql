Create database Robot;
CREATE TABLE Equipo (
   id_equipo int identity(1,1) not null,
    nombre_equipo varchar(100) not null,
    fecha_fundacion date null,
    primary key (id_equipo)
);
CREATE TABLE Robot (
    id_robot int identity(1,1) not null,
    nombre_robot varchar(100) not null,
    tipo_ataque varchar(100) null,
    id_equipo int not null,
    primary key (id_robot),
    foreign key (id_equipo) references Equipo (id_equipo)
);
CREATE TABLE Batalla (
    id_batalla int identity(1,1) not null,
    ubicacion varchar(150) null,
    fecha_batalla date not null,
    hora_batalla time not null,
    primary key (id_batalla)
);
CREATE TABLE Resultado (
    id_resultado int identity(1,1) not null,
    puntuacion_obtenida int null,
    estado varchar(50) null,
    id_robot int not null,
    id_batalla int not null,
    primary key (id_resultado),
    foreign key (id_robot) references Robot (id_robot),
    foreign key (id_batalla) references Batalla (id_batalla)
);