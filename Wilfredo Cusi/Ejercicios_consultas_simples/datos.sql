INSERT INTO jugador (nombre, nickname, email, pais) VALUES
('Juan Perez','juanpro','juan1@gmail.com','Bolivia'),
('Maria Lopez','marialol','maria2@gmail.com','Peru'),
('Carlos Diaz','carlitos','carlos3@gmail.com','Chile'),
('Ana Torres','anatop','ana4@gmail.com','Argentina'),
('Luis Gomez','luisg','luis5@gmail.com','Bolivia'),
('Pedro Rojas','projas','pedro6@gmail.com','Peru'),
('Sofia Ruiz','sofiar','sofia7@gmail.com','Chile'),
('Miguel Castro','miguelc','miguel8@gmail.com','Argentina'),
('Lucia Flores','luciaf','lucia9@gmail.com','Bolivia'),
('Diego Vega','diegov','diego10@gmail.com','Peru'),
('Valeria Cruz','valec','vale11@gmail.com','Chile'),
('Andres Mora','andresm','andres12@gmail.com','Argentina'),
('Paula Silva','paulas','paula13@gmail.com','Bolivia'),
('Jorge Lima','jorgel','jorge14@gmail.com','Peru'),
('Elena Ortiz','elenao','elena15@gmail.com','Chile');
select * from jugador;

INSERT INTO equipo (nombre, fecha_creacion) VALUES
('Team Alpha','2024-01-01'),
('Team Beta','2024-01-02'),
('Team Gamma','2024-01-03'),
('Team Delta','2024-01-04'),
('Team Omega','2024-01-05'),
('Team Zeta','2024-01-06'),
('Team Titan','2024-01-07'),
('Team Nova','2024-01-08'),
('Team Fire','2024-01-09'),
('Team Ice','2024-01-10'),
('Team Storm','2024-01-11'),
('Team Shadow','2024-01-12'),
('Team Dragon','2024-01-13'),
('Team Wolf','2024-01-14'),
('Team Eagle','2024-01-15');
select * from equipo;

INSERT INTO juego (nombre, genero) VALUES
('Valorant','FPS'),
('CSGO','FPS'),
('Dota 2','MOBA'),
('League of Legends','MOBA'),
('Fortnite','Battle Royale'),
('PUBG','Battle Royale'),
('Overwatch','FPS'),
('Apex Legends','Battle Royale'),
('Call of Duty','FPS'),
('Free Fire','Battle Royale'),
('Minecraft','Sandbox'),
('FIFA','Deportes'),
('Rocket League','Deportes'),
('Clash Royale','Estrategia'),
('Warzone','FPS');
select * from juego;

INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES
('Torneo 1','2025-05-01','2025-05-05',1),
('Torneo 2','2025-05-02','2025-05-06',2),
('Torneo 3','2025-05-03','2025-05-07',3),
('Torneo 4','2025-05-04','2025-05-08',4),
('Torneo 5','2025-05-05','2025-05-09',5),
('Torneo 6','2025-05-06','2025-05-10',6),
('Torneo 7','2025-05-07','2025-05-11',7),
('Torneo 8','2025-05-08','2025-05-12',8),
('Torneo 9','2025-05-09','2025-05-13',9),
('Torneo 10','2025-05-10','2025-05-14',10),
('Torneo 11','2025-05-11','2025-05-15',11),
('Torneo 12','2025-05-12','2025-05-16',12),
('Torneo 13','2025-05-13','2025-05-17',13),
('Torneo 14','2025-05-14','2025-05-18',14),
('Torneo 15','2025-05-15','2025-05-19',15);
select * from torneo;

INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES
(1,'2025-05-01','10:00:00','Pendiente'),
(2,'2025-05-02','11:00:00','Finalizado'),
(3,'2025-05-03','12:00:00','Pendiente'),
(4,'2025-05-04','13:00:00','Finalizado'),
(5,'2025-05-05','14:00:00','Pendiente'),
(6,'2025-05-06','15:00:00','Finalizado'),
(7,'2025-05-07','16:00:00','Pendiente'),
(8,'2025-05-08','17:00:00','Finalizado'),
(9,'2025-05-09','18:00:00','Pendiente'),
(10,'2025-05-10','19:00:00','Finalizado'),
(11,'2025-05-11','20:00:00','Pendiente'),
(12,'2025-05-12','21:00:00','Finalizado'),
(13,'2025-05-13','22:00:00','Pendiente'),
(14,'2025-05-14','09:00:00','Finalizado'),
(15,'2025-05-15','08:00:00','Pendiente');
select * from partida;

INSERT INTO participacion VALUES
(1,1,'Ganador'),(2,2,'Perdedor'),(3,3,'Ganador'),
(4,4,'Perdedor'),(5,5,'Ganador'),(6,6,'Perdedor'),
(7,7,'Ganador'),(8,8,'Perdedor'),(9,9,'Ganador'),
(10,10,'Perdedor'),(11,11,'Ganador'),(12,12,'Perdedor'),
(13,13,'Ganador'),(14,14,'Perdedor'),(15,15,'Ganador');
select * from participacion;

INSERT INTO estadistica (id_jugador,id_partida,kills,muertes,asistencias) VALUES
(1,1,10,5,3),(2,2,15,4,6),(3,3,20,6,2),
(4,4,8,7,5),(5,5,25,3,4),(6,6,18,6,7),
(7,7,12,5,3),(8,8,30,2,8),(9,9,22,4,5),
(10,10,16,6,2),(11,11,19,3,6),(12,12,14,5,4),
(13,13,21,4,7),(14,14,17,6,3),(15,15,23,2,9);
select * from estadistica;

INSERT INTO premio (id_torneo,posicion,monto) VALUES
(1,1,1000),(2,1,1200),(3,1,1400),
(4,1,1600),(5,1,1800),(6,1,2000),
(7,1,2200),(8,1,2400),(9,1,2600),
(10,1,2800),(11,1,3000),(12,1,3200),
(13,1,3400),(14,1,3600),(15,1,3800);
select * from premio;

INSERT INTO inscripcion (id_equipo,id_torneo,fecha_inscripcion) VALUES
(1,1,'2025-04-01'),(2,2,'2025-04-02'),
(3,3,'2025-04-03'),(4,4,'2025-04-04'),
(5,5,'2025-04-05'),(6,6,'2025-04-06'),
(7,7,'2025-04-07'),(8,8,'2025-04-08'),
(9,9,'2025-04-09'),(10,10,'2025-04-10'),
(11,11,'2025-04-11'),(12,12,'2025-04-12'),
(13,13,'2025-04-13'),(14,14,'2025-04-14'),
(15,15,'2025-04-15');
select * from incripcion;