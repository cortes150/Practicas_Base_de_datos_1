# B	llenar todas las tablas con minimo 15 datos.  
-- 1. JUGADOR
INSERT INTO jugador (nombre, nickname, email, pais) VALUES
('Carlos López', 'ShadowStrike', 'carlos@mail.com', 'México'), ('Ana Ruiz', 'Valkyrie', 'ana@mail.com', 'España'),
('Luis Gómez', 'Phoenix', 'luis@mail.com', 'Colombia'), ('Marta Díaz', 'NovaBlade', 'marta@mail.com', 'Argentina'),
('Pedro Sánchez', 'IronFist', 'pedro@mail.com', 'Chile'), ('Sofía Torres', 'CyberWolf', 'sofia@mail.com', 'Perú'),
('Jorge Vega', 'StormBreaker', 'jorge@mail.com', 'México'), ('Elena Castro', 'Athena', 'elena@mail.com', 'España'),
('David Herrera', 'GhostRider', 'david@mail.com', 'Colombia'), ('Laura Morales', 'SilentStorm', 'laura@mail.com', 'Argentina'),
('Miguel Ríos', 'Thunder', 'miguel@mail.com', 'Chile'), ('Valentina Paz', 'IceQueen', 'valentina@mail.com', 'Perú'),
('Andrés Luna', 'NightHawk', 'andres@mail.com', 'México'), ('Camila Flores', 'SolarFlare', 'camila@mail.com', 'España'),
('Roberto Silva', 'DarkMage', 'roberto@mail.com', 'Colombia');

-- 2. EQUIPO
INSERT INTO equipo (nombre, fecha_creacion) VALUES
('Team Alpha', '2023-01-15'), ('Omega Squad', '2023-03-22'), ('Red Phoenix', '2023-06-10'), ('Blue Vipers', '2023-08-05'),
('Cyber Wolves', '2023-11-30'), ('Iron Eagles', '2024-01-12'), ('Shadow Hunters', '2024-02-20'), ('Neon Knights', '2024-04-18'),
('Storm Riders', '2024-05-25'), ('Apex Legends', '2024-07-08'), ('Nova Force', '2024-09-14'), ('Quantum Leap', '2024-10-30'),
('Zero Gravity', '2024-12-01'), ('Eclipse FC', '2025-02-14'), ('Titanium Core', '2025-03-22');

-- 3. JUGADOR_EQUIPO
INSERT INTO jugador_equipo (id_jugador, id_equipo, fecha_union) VALUES
(1,1,'2023-02-01'),(2,1,'2023-02-01'),(3,2,'2023-04-10'),(4,2,'2023-04-10'),(5,3,'2023-07-01'),(6,3,'2023-07-01'),
(7,4,'2023-09-15'),(8,4,'2023-09-15'),(9,5,'2023-12-20'),(10,5,'2023-12-20'),(11,6,'2024-02-05'),(12,6,'2024-02-05'),
(13,7,'2024-03-10'),(14,7,'2024-03-10'),(15,8,'2024-05-01');

-- 4. JUEGO
INSERT INTO juego (nombre, genero) VALUES
('Valorant', 'FPS Táctico'), ('League of Legends', 'MOBA'), ('Rocket League', 'Deportes'), ('CS2', 'FPS'), ('Fortnite', 'Battle Royale'),
('Overwatch 2', 'Hero Shooter'), ('Apex Legends', 'Battle Royale'), ('Rainbow Six', 'Táctico'), ('Dota 2', 'MOBA'), ('Call of Duty', 'FPS'),
('Paladins', 'Hero Shooter'), ('Brawlhalla', 'Lucha'), ('TrackMania', 'Carreras'), ('FIFA 24', 'Simulación'), ('Street Fighter 6', 'Lucha');

-- 5. TORNEO
INSERT INTO torneo (nombre, fecha_inicio, fecha_fin, id_juego) VALUES
('Latam Masters', '2026-01-10', '2026-01-15', 1), ('Copa Europa', '2026-02-05', '2026-02-10', 2), ('Rocket Cup', '2026-03-12', '2026-03-14', 3),
('FPS Global', '2026-04-20', '2026-04-25', 4), ('Battle Royale Open', '2026-05-10', '2026-05-12', 5), ('Hero Clash', '2026-06-01', '2026-06-05', 6),
('Apex Pro', '2026-07-15', '2026-07-18', 7), ('R6 Siege Series', '2026-08-20', '2026-08-25', 8), ('Dota Invitational', '2026-09-10', '2026-09-15', 9),
('COD Championship', '2026-10-01', '2026-10-05', 10), ('Paladins Tour', '2026-10-20', '2026-10-22', 11), ('Brawlhalla World', '2026-11-05', '2026-11-07', 12),
('TrackMania Elite', '2026-11-15', '2026-11-18', 13), ('FIFA Club', '2026-12-01', '2026-12-05', 14), ('SF6 Showdown', '2026-12-10', '2026-12-12', 15);

-- 6. PARTIDA
INSERT INTO partida (id_torneo, fecha, hora, estado) VALUES
(1,'2026-01-10','10:00:00','Finalizada'),(1,'2026-01-11','11:00:00','Finalizada'),(2,'2026-02-05','14:00:00','Finalizada'),(2,'2026-02-06','15:30:00','Finalizada'),
(3,'2026-03-12','16:00:00','Finalizada'),(4,'2026-04-20','18:00:00','En curso'),(5,'2026-05-10','09:00:00','Programada'),(6,'2026-06-01','10:00:00','Programada'),
(7,'2026-07-15','12:00:00','Programada'),(8,'2026-08-20','14:00:00','Programada'),(9,'2026-09-10','16:00:00','Programada'),(10,'2026-10-01','18:00:00','Programada'),
(11,'2026-10-20','19:00:00','Programada'),(12,'2026-11-05','20:00:00','Programada'),(13,'2026-11-15','10:00:00','Programada');

-- 7. INSCRIPCION
INSERT INTO inscripcion (id_equipo, id_torneo, fecha_inscripcion) VALUES
(1,1,'2025-12-01'),(2,2,'2026-01-10'),(3,3,'2026-02-01'),(4,4,'2026-03-15'),(5,5,'2026-04-01'),(6,6,'2026-05-10'),(7,7,'2026-06-01'),
(8,8,'2026-07-10'),(9,9,'2026-08-15'),(10,10,'2026-09-01'),(11,11,'2026-09-20'),(12,12,'2026-10-10'),(13,13,'2026-10-25'),(14,14,'2026-11-01'),(15,15,'2026-11-20');

-- 8. PARTICIPACION
INSERT INTO participacion (id_partida, id_equipo, resultado) VALUES
(1,1,'Ganador'),(1,3,'Perdedor'),(2,2,'Ganador'),(2,4,'Perdedor'),(3,5,'Ganador'),(3,6,'Perdedor'),(4,7,'Ganador'),(4,8,'Perdedor'),
(5,9,'Ganador'),(5,10,'Perdedor'),(6,11,'Ganador'),(6,12,'Perdedor'),(7,13,'Ganador'),(7,14,'Perdedor'),(8,15,'Ganador');

-- 9. ESTADISTICA
INSERT INTO estadistica (id_jugador, id_partida, kills, muertes, asistencias) VALUES
(1,1,15,3,8),(2,1,10,4,12),(3,2,22,5,6),(4,2,8,6,10),(5,3,18,2,7),(6,3,12,3,9),(7,4,25,4,5),(8,4,9,5,11),
(9,5,14,3,8),(10,5,11,4,10),(11,6,20,2,6),(12,6,13,3,12),(13,7,16,4,7),(14,7,10,5,9),(15,8,21,3,8);

-- 10. PREMIO
INSERT INTO premio (id_torneo, posicion, monto) VALUES
(1,1,5000.00),(1,2,2500.00),(2,1,4000.00),(2,2,2000.00),(3,1,3000.00),(3,2,1500.00),(4,1,6000.00),(4,2,3000.00),
(5,1,4500.00),(5,2,2200.00),(6,1,3500.00),(6,2,1800.00),(7,1,5500.00),(7,2,2700.00),(8,1,4000.00);