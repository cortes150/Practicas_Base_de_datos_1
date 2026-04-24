INSERT INTO jugador (nombre, nickname, email, pais) VALUES 
('Juan Perez', 'JuanPa_01', 'juan@mail.com', 'México'),
('Alejandro Quisbert', 'Ale_2', 'Alejandro@mail.com', 'Bolivia'),
('Ana Gomez', 'Anii_Star', 'ana@mail.com', 'Colombia'),
('Carlos Ruiz', 'CarlitosWay', 'carlos@mail.com', 'España'),
('Lucia Fernandez', 'Lulu_Gamer', 'lucia@mail.com', 'Argentina'),
('Roberto Diaz', 'Rob_Killer', 'roberto@mail.com', 'Chile'),
('Elena Torres', 'Ele_Pro', 'elena@mail.com', 'México'),
('Marcos Paez', 'Mark_99', 'marcos@mail.com', 'Perú'),
('Sofia Luna', 'Sofi_Sky', 'sofia@mail.com', 'España'),
('Diego Sosa', 'Digo_Win', 'diego@mail.com', 'Uruguay'),
('Laura Meza', 'Lau_Gamer', 'laura@mail.com', 'Paraguay'),
('Pedro Alva', 'Pe_Hero', 'pedro@mail.com', 'Bolivia'),
('Marta Rivas', 'Martu_X', 'marta@mail.com', 'México'),
('Luis Rojas', 'Luisito_Pro', 'luis@mail.com', 'Chile'),
('Carmen Gil', 'Car_G', 'carmen@mail.com', 'Ecuador');

select * from jugador;

INSERT INTO jugador (nombre, nickname, email, pais) VALUES
('Jhoel Cachi', 'jhoel_54', 'Jhoel@mail.com', 'Costa Rica');

select * from jugador;

INSERT INTO equipo (nombre, fecha_creacion) VALUES
('NeosLegacy', '24/02/25'),
('New History', '02/12/22'),
('NexDrae', '14/04/26'),
('Wild tempest', '16/11/21'),
('Heroofsilenth', '10/09/20'),
('Goxs', '03/06/19'),
('Beyond', '22/07/18'),
('Pteal storm', '09/09/15'),
('Owents', '14/03/10'),
('Whiphala Warrions', '12/12/25'),
('Fanahi', '09/06/12'),
('SomosBolvia', '10/01/24'),
('Game Over', '19/05/17'),
('Nova Sports', '02/02/12'),
('Vallion Storm', '23/06/23');

select * from equipo;

INSERT INTO equipo (nombre, fecha_creacion) VALUES
('S11 Gaming', '03/08/21');

select * from equipo;

INSERT INTO juego (nombre, genero) 
VALUES ('Mobile Legends: Bang Bang', 'MOBA'),
('League of Legends', 'MOBA'),
('Valorant', 'Shooter'),
('FIFA 24', 'Deportes'),
('Counter Strike 2', 'Shooter'),
('Dota 2', 'MOBA'),
('Street Fighter 6', 'Lucha'),
('Apex Legends', 'Battle Royale'),
('Fortnite', 'Battle Royale'),
('Rocket League', 'Deportes'),
('Tekken 8', 'Lucha'),
('Overwatch 2', 'Shooter'),
('Mortal Kombat 1', 'Lucha'),
('NBA 2K24', 'Deportes'),
('Minecraft', 'Sandbox');

select * from juego;

INSERT INTO juego (nombre, genero) VALUES
('Call of Duty: Warzone', 'Shooter');

select * from juego;

INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES 
('MLBB M6 World Championship', '2025-02-01', '2025-02-28', 1),
('Copa Verano LOL', '2024-06-01', '2024-06-15', 2),
('Masters Valorant', '2024-06-10', '2024-06-20', 3),
('Liga e-Sports FIFA', '2024-07-01', '2024-07-15', 4),
('Major Counter Strike', '2024-07-05', '2024-07-20', 5),
('The International Dota', '2024-08-01', '2024-08-10', 6),
('Street Fighter Showdown', '2024-08-15', '2024-08-25', 7),
('Apex Invitational', '2024-09-01', '2024-09-05', 8),
('Fortnite World Cup', '2024-09-10', '2024-09-15', 9),
('Rocket League Championship', '2024-10-01', '2024-10-10', 10),
('King of Iron Fist', '2024-10-15', '2024-10-20', 11),
('Overwatch Challenge', '2024-11-01', '2024-11-10', 12),
('Mortal Kombat Summit', '2024-11-15', '2024-11-20', 13),
('NBA 2K Tour', '2024-12-01', '2024-12-05', 14),
('Minecraft Builders Cup', '2024-12-10', '2024-12-15', 15);

SELECT * FROM torneo;

INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES 
('Warzone Elite', '2025-01-05', '2025-01-15', 16);

SELECT * FROM torneo;

INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES 
(1, '2025-02-15', '20:00:00', 'Programado'),
(2, '2024-06-05', '14:00:00', 'Finalizado'),
(3, '2024-06-12', '15:30:00', 'Finalizado'),
(4, '2024-07-05', '18:00:00', 'Finalizado'),
(5, '2024-07-10', '20:00:00', 'Programado'),
(6, '2024-08-02', '10:00:00', 'Finalizado'),
(7, '2024-08-18', '16:00:00', 'Finalizado'),
(8, '2024-09-02', '19:00:00', 'En curso'),
(9, '2024-09-12', '21:00:00', 'Programado'),
(10, '2024-10-05', '13:00:00', 'Finalizado'),
(11, '2024-10-18', '22:00:00', 'Finalizado'),
(12, '2024-11-05', '17:00:00', 'Programado'),
(13, '2024-11-18', '15:00:00', 'Finalizado'),
(14, '2024-12-03', '11:00:00', 'Finalizado'),
(15, '2024-12-12', '09:00:00', 'Finalizado');

select * from partida;

INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES 
(16, '2025-01-10', '23:00:00', 'Programado');

select * from partida;

INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion) VALUES 
(1, 1, '2025-01-20'),
(2, 2, '2024-05-01'), 
(3, 3, '2024-05-02'), 
(4, 4, '2024-05-03'),
(5, 5, '2024-05-04'), 
(6, 6, '2024-05-05'), 
(7, 7, '2024-05-06'),
(8, 8, '2024-05-07'), 
(9, 9, '2024-05-08'), 
(10, 10, '2024-05-09'),
(11, 11, '2024-05-10'), 
(12, 12, '2024-05-11'), 
(13, 13, '2024-05-12'),
(14, 14, '2024-05-13'), 
(15, 15, '2024-05-14');

select * from  inscripcion;

INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion) VALUES 
(16, 16, '2024-05-15');

select * from inscripcion;

INSERT INTO premio (id_torneo, posicion, monto) VALUES 
(1, 1, 5000.00), 
(2, 1, 3500.00), 
(3, 1, 2000.00),
(4, 1, 4500.00), 
(5, 1, 10000.00), 
(6, 1, 1500.00),
(7, 1, 3000.00), 
(8, 1, 8000.00), 
(9, 1, 2500.00),
(10, 1, 1200.00), 
(11, 1, 4000.00), 
(12, 1, 1800.00),
(13, 1, 2200.00), 
(14, 1, 500.00), 
(15, 1, 6000.00);

select * from premio;

INSERT INTO premio (id_torneo, posicion, monto) 
VALUES (16, 1, 15000.00);

SELECT * FROM premio;

INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias) VALUES 
(1, 1, 10, 2, 5), 
(2, 2, 8, 4, 12), 
(3, 3, 15, 7, 3),
(4, 4, 5, 5, 20), 
(5, 5, 12, 1, 8),
(6, 6, 9, 3, 10),
(7, 7, 20, 10, 5), 
(8, 8, 4, 6, 15), 
(9, 9, 11, 2, 7),
(10, 10, 7, 8, 4), 
(11, 11, 14, 3, 9), 
(12, 12, 6, 4, 18),
(13, 13, 18, 5, 2), 
(14, 14, 3, 9, 11), 
(15, 15, 10, 0, 15);

SELECT * FROM estadistica;

INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias) 
VALUES (16, 16, 25, 2, 10);

SELECT * FROM estadistica;

INSERT INTO participacion (id_partida, id_equipo, resultado) VALUES 
(1, 1, 'Ganador'),
(2, 2, 'Perdedor'),
(3, 3, 'Ganador'),
(4, 4, 'Empate'), 
(5, 5, 'Ganador'), 
(6, 6, 'Perdedor'),
(7, 7, 'Ganador'), 
(8, 8, 'Empate'), 
(9, 9, 'Ganador'),
(10, 10, 'Perdedor'), 
(11, 11, 'Ganador'), 
(12, 12, 'Empate'),
(13, 13, 'Ganador'), 
(14, 14, 'Perdedor'), 
(15, 15, 'Ganador');

SELECT * FROM participacion;

INSERT INTO participacion (id_partida, id_equipo, resultado) 
VALUES (16, 16, 'Ganador');

SELECT * FROM participacion;

UPDATE jugador 
SET pais = 'Canadá' 
WHERE id_jugador = 1;

SELECT * FROM jugador WHERE id_jugador = 1;

UPDATE jugador 
SET nickname = 'Galaxy_Queen' 
WHERE id_jugador = 2;

SELECT * FROM jugador WHERE id_jugador = 2;

UPDATE equipo 
SET nombre = 'Dragones Legendarios' 
WHERE id_equipo = 1;

SELECT * FROM equipo WHERE id_equipo = 1;

UPDATE juego 
SET genero = 'MOBA Mobile' 
WHERE id_juego = 16;

SELECT * FROM juego WHERE id_juego = 16;

UPDATE torneo 
SET fecha_inicio = '2025-03-01' 
WHERE id_torneo = 16;

SELECT * FROM torneo WHERE id_torneo = 16;

UPDATE partida 
SET estado = 'Finalizado' 
WHERE id_partida = 16;

SELECT * FROM partida WHERE id_partida = 16;

UPDATE premio 
SET monto = 20000.00 
WHERE id_torneo = 16;

SELECT * FROM premio WHERE id_torneo = 16;

UPDATE estadistica 
SET kills = 30 
WHERE id_jugador = 16 AND id_partida = 16;

SELECT * FROM estadistica WHERE id_jugador = 16 AND id_partida = 16;

UPDATE participacion 
SET resultado = 'Descalificado' 
WHERE id_partida = 16 AND id_equipo = 16;

SELECT * FROM participacion WHERE id_partida = 16 AND id_equipo = 16;

UPDATE jugador 
SET email = 'a.quisbert.pro@mail.com' 
WHERE id_jugador = 16;

SELECT * FROM jugador WHERE id_jugador = 16;

UPDATE jugador 
SET email = 'a.quisbert.pro@mail.com' 
WHERE id_jugador = 16;

SELECT * FROM jugador WHERE id_jugador = 16;

SELECT * FROM jugador 
WHERE pais = 'Bolivia';

SELECT * FROM jugador 
WHERE pais <> 'México';

SELECT * FROM equipo 
WHERE fecha_creacion > '2023-12-31';

SELECT * FROM juego 
WHERE genero = 'MOBA';

SELECT * FROM partida 
WHERE estado = 'Finalizado';

SELECT * FROM premio 
WHERE monto > 5000.00;

SELECT * FROM estadistica 
WHERE kills > 20;

SELECT * FROM participacion 
WHERE resultado = 'Ganador';

SELECT * FROM inscripcion 
WHERE fecha_inscripcion BETWEEN '2024-01-01' AND '2025-01-31';