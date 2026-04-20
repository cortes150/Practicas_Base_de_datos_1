USE battlezone_db;
insert into jugador (nombre, nickname, email, pais) values
("beymar", "ye1c0v", "beymar123@gmail.com", "Bolivia"),
("bismark", "SukerSuco", "bismark123@gmail.com", "Bolivia"),
("mauricio", "rivanrete", "mauricio123@gmail.com", "Bolivia"),
("wilfredo", "the_admin_pro", "wil123@gmail.com", "Bolivia"),
("cristian", "goat", "cristian123@gmail.com", "Bolivia"),
("jhujra", "tribilin", "jhun123@gmail.com", "Bolivia"),
("nils", "rocks_777", "nils123@gmail.com", "Bolivia"),
("azuky", "azyr", "azuky123@gmail.com", "Perú"),
("angel", "CHapac0", "angel123@gmail.com", "Bolivia"),
("william", "jheysonoconer", "william123@gmail.com", "Bolivia"),
("walter", "walter_A", "walter123@gmail.com", "Bolivia"),
("jhamil", "tapia", "jhamil123@gmail.com", "Bolivia"),
("diego", "KDP", "diego123@gmail.com", "Bolivia"),
("iker", "chupaco", "iker123@gmail.com", "Chile"),
("joel", "zetazen150417", "joel123@gmail.com", "Bolivia");
select * from jugador;

insert into equipo (nombre, fecha_creacion) values
("omega_raiders", "2026-04-04"),
("real_pasankalla", "2026-04-05"),
("coca_juniors", "2026-04-07"),
("riatones", "2026-04-08"),
("vagos", "2026-04-09"),
("medellin", "2026-04-10"),
("boliganga", "2026-04-11"),
("tronicos", "2026-04-12"),
("the_mechatronics", "2026-04-13"),
("inyectores", "2026-04-14"),
("mugrosos", "2026-04-15"),
("chucutas", "2026-04-16"),
("suchas", "2026-04-17"),
("cartel_sencata", "2026-04-18"),
("santana_FC", "2026-04-19");
select * from equipo;

insert into jugador_equipo (id_jugador, id_equipo, fecha_union)values
(1, 1, '2026-04-05'),
(2, 2, '2026-04-06'),
(3, 3, '2026-04-08'),
(4, 4, "2026-04-09"),
(5, 5, "2026-04-10"),
(6, 6, "2026-04-11"),
(7, 7, "2026-04-12"),
(8, 8, "2026-04-13"),
(9, 9, "2026-04-14"),
(10, 10, "2026-04-15"),
(11, 11, "2026-04-16"),
(12, 12, "2026-04-17"),
(13, 13, "2026-04-18"),
(14, 14, "2026-04-19"),
(15, 15, "2026-04-20");
select * from jugador_equipo;

insert into juego (nombre, genero)values
('Grand_Theft_Auto_V', 'Acción-aventura'),
('Project_Zomboid', 'Supervivencia'),
('Subnautica', 'Supervivencia'),
('EA_Sports_F1_25', 'Deportes'),
('Valorant', 'Shooter táctico'),
('Counter_Strike_2', 'FPS'),
('Dota_2', 'MOBA'),
('Minecraft', 'Sandbox'),
('Fortnite', 'Battle_Royale'),
('Rocket_League', 'Deportes'),
('Elden_Ring', 'Acción_RPG'),
('Street_Fighter_6', 'Lucha'),
('Apex_Legends', 'Battle_Royale'),
('EA_Sports_FC_24', 'Deportes'),
('Overwatch_2', 'Hero_Shooter');
select * from juego;

insert into torneo (nombre, fecha_inicio, fecha_fin, id_juego)values
('Gran_Heist_Championship', '2026-05-20', '2026-05-25', 1),
('Desafío_de_Supervivencia_Extrema', '2026-05-22', '2026-05-30', 2),
('Exploradores_del_Abismo', '2026-06-01', '2026-06-05', 3),
('Gran_Premio_de_F1_2026', '2026-06-10', '2026-06-20', 4),
('Valorant_Masters:_La_Paz', '2026-06-15', '2026-06-25', 5),
('Global_Offensive_Elite_Series', '2026-07-01', '2026-07-10', 6),
('Batalla_por_el_Ancestral', '2026-07-05', '2026-07-15', 7),
('Master_Builders_Invitational', '2026-07-12', '2026-07-18', 8),
('Fortnite:_Victoria_RealPro', '2026-07-20', '2026-07-25', 9),
('Turbo_League_Season_1', '2026-08-01', '2026-08-07', 10),
('Torneo_del_Círculo_de_Elden', '2026-08-10', '2026-08-20', 11),
('King_of_Fighters_Tournament', '2026-08-15', '2026-08-22', 12),
('Apex_Legends:_Apex_Series', '2026-09-01', '2026-09-10', 13),
('Copa_Digital_de_Fútbol', '2026-09-05', '2026-09-15', 14),
('Heroes_Assemble_2026', '2026-09-20', '2026-09-30', 15);
select * from torneo;

insert into partida (id_torneo, fecha, hora, estado)values
(1, '2026-05-20', '14:00:00', 'Programada'),
(2, '2026-05-22', '16:30:00', 'Programada'),
(3, '2026-06-01', '10:00:00', 'Programada'),
(4, '2026-06-11', '09:00:00', 'Programada'),
(5, '2026-06-15', '19:00:00', 'Programada'),
(6, '2026-07-02', '15:00:00', 'Programada'),
(7, '2026-07-06', '18:00:00', 'Programada'),
(8, '2026-07-13', '14:00:00', 'Programada'),
(9, '2026-07-21', '16:00:00', 'Programada'),
(10, '2026-08-02', '17:30:00', 'Programada'),
(11, '2026-08-11', '20:00:00', 'Programada'),
(12, '2026-08-16', '15:00:00', 'Programada'),
(13, '2026-09-02', '19:00:00', 'Programada'),
(14, '2026-09-06', '14:00:00', 'Programada'),
(15, '2026-09-21', '16:00:00', 'Programada');
select * from partida;

insert into participacion (id_partida, id_equipo, resultado)values
(1, 1, 'Pendiente'),
(2, 2, 'Pendiente'),
(3, 3, 'Pendiente'),
(4, 4, 'Pendiente'),
(5, 5, 'Pendiente'),
(6, 6, 'Pendiente'),
(7, 7, 'Pendiente'),
(8, 8, 'Pendiente'),
(9, 9, 'Pendiente'),
(10, 10, 'Pendiente'),
(11, 11, 'Pendiente'),
(12, 12, 'Pendiente'),
(13, 13, 'Pendiente'),
(14, 14, 'Pendiente'),
(15, 15, 'Pendiente');
select * from participacion;

insert into estadistica (id_jugador, id_partida, kills, muertes, asistencias)values
(1, 1, 12, 5, 8),
(2, 2, 10, 8, 4),
(3, 3, 45, 2, 15),
(4, 4, 0, 0, 0),
(5, 5, 22, 18, 10),
(6, 6, 18, 12, 5),
(7, 7, 8, 4, 25),
(8, 8, 5, 10, 2),  
(9, 9, 15, 3, 1), 
(10, 10, 3, 1, 12), 
(11, 11, 1, 40, 0), 
(12, 12, 20, 15, 0),
(13, 13, 12, 5, 14),
(14, 14, 0, 0, 4), 
(15, 15, 14, 10, 22);
select * from estadistica;

insert into premio (id_torneo, posicion, monto)values
(1, 1, 1500.00), 
(2, 1, 800.00),  
(3, 1, 500.00),  
(4, 1, 2000.00), 
(5, 1, 2500.00), 
(6, 1, 1200.00),
(7, 1, 1800.00),
(8, 1, 300.00),
(9, 1, 900.00),
(10, 1, 700.00),
(11, 1, 1000.00),
(12, 1, 600.00),
(13, 1, 1100.00),
(14, 1, 1400.00),
(15, 1, 1200.00);
select * from premio;
 
 insert into inscripcion (id_equipo, id_torneo, fecha_inscripcion)values
 (1, 1, '2026-04-22'),
(2, 2, '2026-04-22'),
(3, 3, '2026-04-22'),
(4, 4, '2026-04-23'),
(5, 5, '2026-04-24'),
(6, 6, '2026-04-22'),
(7, 7, '2026-04-22'),
(8, 8, '2026-04-23'),
(9, 9, '2026-04-24'),
(10, 10, '2026-04-23'),
(11, 11, '2026-04-23'),
(12, 12, '2026-04-23'),
(13, 13, '2026-04-23'),
(14, 14, '2026-04-22'),
(15, 15, '2026-04-24');
select * from inscripcion;