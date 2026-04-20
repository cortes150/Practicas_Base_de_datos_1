CREATE DATABASE battlezone_db;
USE battlezone_db;
CREATE TABLE jugador (
 id_jugador INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100),
 nickname VARCHAR(50) UNIQUE,
 email VARCHAR(100),
 pais VARCHAR(50)
);
CREATE TABLE equipo (
 id_equipo INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100),
 fecha_creacion DATE
);
CREATE TABLE jugador_equipo (
 id_jugador INT,
 id_equipo INT,
 fecha_union DATE,

 PRIMARY KEY (id_jugador, id_equipo),

 FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador),
 FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);
CREATE TABLE juego (
 id_juego INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100),
 genero VARCHAR(50)
);
CREATE TABLE torneo (
 id_torneo INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100),
 fecha_inicio DATE,
 fecha_fin DATE,
 id_juego INT,

 FOREIGN KEY (id_juego) REFERENCES juego(id_juego)
);
CREATE TABLE partida (
 id_partida INT AUTO_INCREMENT PRIMARY KEY,
 id_torneo INT,
 fecha DATE,
 hora TIME,
 estado VARCHAR(50),

 FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);
CREATE TABLE participacion (
 id_partida INT,
 id_equipo INT,
 resultado VARCHAR(50),

 PRIMARY KEY (id_partida, id_equipo),

 FOREIGN KEY (id_partida) REFERENCES partida(id_partida),
 FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);
CREATE TABLE estadistica (
 id_estadistica INT AUTO_INCREMENT PRIMARY KEY,
 id_jugador INT,
 id_partida INT,
 kills INT,
 muertes INT,
 asistencias INT,

 FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador),
 FOREIGN KEY (id_partida) REFERENCES partida(id_partida)
);
CREATE TABLE premio (
 id_premio INT AUTO_INCREMENT PRIMARY KEY,
 id_torneo INT,
 posicion INT,
 monto DECIMAL(10,2),

 FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);
CREATE TABLE inscripcion (
 id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
 id_equipo INT,
 id_torneo INT,
 fecha_inscripcion DATE,

 FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo),
 FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);

insert into jugador(nombre, nickname, email, pais) values
('Juan', 'Juan123', 'juan123@gmail.com', 'Bolivia'), ('Carlos', 'Carlos123', 'carlos123@gmail.com', 'Mexico'),
('king', 'King123', 'king123@gmail.com', 'Canada'), ('Eda', 'Edad123', 'eda123@gmail.com', 'Brazil'),
('Luz', 'Luz123', 'luz123@gmail.com', 'Chile'), ('Amity', 'Amity123', 'amity123@gmail.com', 'Estados Unidos'),
('Regulus', 'Regulus123', 'regulus123@gmail.com', 'Venezuela'), ('Kardia', 'Kardia123', 'kardia123@gmail.com', 'China'),
('Degel', 'Degel123', 'degel123@gmail.com', 'Japon'), ('Afrodita', 'Afrodita123', 'afrodita123@gmail.com', 'Corea del Sur'),
('Aldebaran', 'Aldebaran123', 'aldebaran123@gmail.com', 'España'), ('Teneo', 'Teneo123', 'teneo123@gmail.com', 'Andora'),
('Radamantis', 'Radamantis123', 'radamantisjuan123@gmail.com', 'Panama'), ('Itadori', 'Itadori123', 'itadori123@gmail.com', 'Peru'),
('Akaza', 'Akaza123', 'akaza123@gmail.com', 'Colombia');

insert into equipo (nombre, fecha_creacion) values
('Malvados y Asociados', '2023-01-10'), ('Super campeones', '2023-02-15'), ('Santos de Oro', '2023-03-20'), ('Santos de Plata', '2023-04-25'),
('Santos de Bronce', '2023-05-30'), ('Equipo Rocket', '2023-06-05'), ('Los Caballeros', '2023-07-12'), ('Los Exorcistas', '2023-08-18'),
('Los Malditos', '2023-09-22'), ('Los Fieles', '2023-10-01'), ('Los Caidos', '2023-11-14'), ('Los Hechizeros', '2023-12-25'),
('Sombras del Abismo', '2024-01-05'), ('Titanes de Acero', '2024-02-10'), ('Guardianes Eternos', '2024-03-15');

insert into juego (nombre, genero) values
('League of Legends', 'MOBA'), ('Valorant', 'Shooter'), ('Counter-Strike 2', 'Shooter'), ('Dota 2', 'MOBA'), ('Overwatch 2', 'Shooter'),
('Street Fighter 6', 'Lucha'), ('Rocket League', 'Deportes'), ('Stardew Valley', 'Simulación'), ('Hollow Knight', 'Metroidvania'),
('NieR: Automata', 'Action RPG'), ('Elden Ring', 'Soulslike'), ('Minecraft', 'Sandbox'), ('Genshin Impact', 'ARPG'), ('FIFA 24', 'Deportes'),
('Fortnite', 'Battle Royale');

insert into torneo (nombre, fecha_inicio, fecha_fin, id_juego) values
('Copa Master LoL', '2026-05-01', '2026-05-15', 1), ('Open Valorant La Paz', '2026-06-10', '2026-06-20', 2), ('Major CS2 Bolivia', '2026-07-05', '2026-07-15', 3),
('Dota 2 Invitational', '2026-08-01', '2026-08-10', 4), ('Overwatch Grand Slam', '2026-09-12', '2026-09-25', 5), ('Street Fighter Showdown', '2026-10-01', '2026-10-05', 6),
('Rocket League Summer', '2026-11-10', '2026-11-20', 7), ('Granjero de Oro Stardew', '2026-12-01', '2026-12-10', 8), ('Hollow Knight Speedrun', '2027-01-05', '2027-01-15', 9),
('NieR Memories Cup', '2027-02-10', '2027-02-20', 10), ('Elden Ring PvP Fest', '2027-03-01', '2027-03-10', 11), ('Minecraft Builders Cup', '2027-04-15', '2027-04-30', 12),
('Genshin Impact Abyss', '2027-05-05', '2027-05-15', 13), ('FIFA Champions League', '2027-06-01', '2027-06-15', 14), ('Fortnite Battle Royale Day', '2027-07-10', '2027-07-20', 15);

insert into inscripcion (id_equipo, id_torneo, fecha_inscripcion) values
(1, 1, '2026-04-15'), (2, 2, '2026-05-20'), (3, 3, '2026-06-15'), (4, 4, '2026-07-10'), (5, 5, '2026-08-25'), 
(6, 6, '2026-09-15'), (7, 7, '2026-10-20'), (8, 8, '2026-11-15'), (9, 9, '2026-12-20'), (10, 10, '2027-01-15'), 
(11, 11, '2027-02-10'), (12, 12, '2027-03-25'), (13, 13, '2027-04-20'), (14, 14, '2027-05-15'), (15, 15, '2027-06-20');

insert into partida (id_torneo, fecha, hora, estado) values
(1, '2026-05-02', '14:00:00', 'Finalizado'), (2, '2026-06-11', '15:30:00', 'Finalizado'), (3, '2026-07-06', '16:00:00', 'Finalizado'),
(4, '2026-08-02', '17:00:00', 'En Curso'), (5, '2026-09-13', '18:00:00', 'Programado'), (6, '2026-10-02', '19:00:00', 'Finalizado'),
(7, '2026-11-11', '20:00:00', 'Programado'), (8, '2026-12-02', '10:00:00', 'Finalizado'), (9, '2027-01-06', '11:00:00', 'Finalizado'),
(10, '2027-02-11', '12:00:00', 'Finalizado'), (11, '2027-03-02', '13:00:00', 'Finalizado'), (12, '2027-04-16', '14:00:00', 'Finalizado'),
(13, '2027-05-06', '15:00:00', 'Finalizado'), (14, '2027-06-02', '16:00:00', 'Finalizado'), (15, '2027-07-11', '17:00:00', 'Finalizado');

insert into estadistica (id_jugador, id_partida, kills, muertes, asistencias) values
(1, 1, 12, 4, 10), (2, 2, 25, 2, 5), (3, 3, 18, 10, 2), (4, 4, 5, 8, 15),  (5, 5, 0, 0, 0), 
(6, 6, 3, 1, 0), (7, 7, 0, 0, 0),  (8, 8, 0, 2, 20), (9, 9, 1, 0, 0), (10, 10, 45, 12, 8), 
(11, 11, 2, 20, 1), (12, 12, 0, 0, 50), (13, 13, 10, 10, 10), (14, 14, 30, 5, 12), (15, 15, 22, 3, 11);

insert into jugador_equipo (id_jugador, id_equipo, fecha_union) values
(1, 1, '2024-01-10'), (2, 2, '2024-01-12'), (3, 3, '2024-01-15'), (4, 4, '2024-01-20'),
(5, 5, '2024-01-25'), (6, 6, '2024-02-01'), (7, 7, '2024-02-05'), (8, 8, '2024-02-10'),
(9, 9, '2024-02-15'), (10, 10, '2024-02-20'), (11, 11, '2024-02-25'), (12, 12, '2024-03-01'),
(13, 13, '2024-03-05'), (14, 14, '2024-03-10'), (15, 15, '2024-03-15');

insert into participacion (id_partida, id_equipo, resultado) values
(1, 1, 'Ganador'), (1, 2, 'Perdedor'), (2, 3, 'Ganador'), (2, 4, 'Perdedor'),
(3, 5, 'Empate'), (3, 6, 'Empate'), (6, 7, 'Ganador'), (6, 8, 'Perdedor'),
(8, 9, 'Ganador'), (9, 10, 'Perdedor'), (10, 11, 'Ganador'), (11, 12, 'Perdedor'),
(12, 13, 'Ganador'), (13, 14, 'Perdedor');

insert into premio (id_torneo, posicion, monto) values
(1, 1, 5000.00), (2, 1, 3500.00), (3, 1, 4000.00), (4, 1, 2500.00), (5, 1, 6000.00),
(6, 2, 1500.00), (7, 1, 3000.00), (8, 2, 800.00), (9, 1, 2000.00), (10, 1, 4500.00),
(11, 3, 500.00), (12, 1, 7000.00), (13, 2, 1200.00), (14, 1, 3800.00), (15, 1, 5500.00);

-- practica
insert into jugador(nombre, nickname, email, pais) values
('Nyls', 'Rocks_777', 'feffthekiler441@gmail.com', 'Bolivia');

insert into jugador(nombre, nickname, email, pais) values
('Shura', 'capricornio', 'shura123@gmail.com', 'Chile');

insert into equipo(nombre, fecha_creacion) values
('Furano', '2000-07-09');

insert into juego(nombre, genero) values
('Hollow Knight', 'metroidvania');

insert into torneo(id_torneo, nombre, fecha_inicio, fecha_fin, id_juego) values
('16', 'vasija pura', '2026-01-01', '2026-04-18', '16');

insert into partida(id_partida, id_torneo, fecha, hora, estado) values
('16', '16', '2026-04-18', '23:00', 'Jugando');

insert into inscripcion(id_equipo, id_torneo, fecha_inscripcion) values
(16, 16, '2025-01-01');

insert into premio(id_torneo, posicion, monto) values
(16, 1, 1000);

insert into estadistica(id_jugador, id_partida, kills, muertes, asistencias) values
(17, 16, 30, 8, 15);

insert into participacion (id_partida, id_equipo, resultado) values
(15, 15, 'Ganador');

update jugador
set pais= 'España'
where id_jugador=1;

update jugador
set nickname='Mortarion'
where id_jugador=1;

update equipo
set nombre='Ultra Marins'
where id_equipo=16;

update juego
set genero='Terror'
where id_juego=16;

update torneo
set fecha_inicio='2027-01-01'
where id_torneo=16;

update partida
set estado='Finalizado'
where id_partida=16;

update premio
set monto=12000
where id_premio=1;

update estadistica
set kills=0
where id_estadistica=1;

update participacion
set resultado='Perdedor'
where id_partida=15;

update inscripcion
set fecha_inscripcion='2024-01-01'
where id_equipo =16;

select * from jugador
where pais='Mexico';

select * from jugador
where pais<>'Bolivia';

select * from equipo
where fecha_creacion > '2024-01-01';

select * from juego
where genero='MOBA';

select * from torneo
where fecha_inicio between '20205-01-01' and '2025-12-31';

select * from partida
where estado= 'Programado';

select * from premio
where monto>5000;

select * from estadistica
where kills>8;

select * from participacion
where resultado='Ganador';

select * from inscripcion
where fecha_inscripcion between '2024-01-01' and '2025-02-20';