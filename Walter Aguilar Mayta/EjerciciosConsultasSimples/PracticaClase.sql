SELECT * FROM jugador;
SELECT * FROM equipo;
SELECT * FROM jugador_equipo;

INSERT INTO jugador(nombre, nickname, email,pais)VALUES('Cusi','ElMasPro','cusipro777@gmail.com','Bolivia');
INSERt INTO equipo(nombre,fecha_creacion) VALUES('Cusi Malvados & Asociados','2026-04-20');
INSERT INTO jugador_equipo(id_jugador,id_equipo,fecha_union)VALUES('18','17','2026-04-20');
INSERT INTO jugador(nombre, nickname, email,pais)VALUES('Cusi','ElPro777','cus@gmail.com','Peru');
INSERT INTO jugador(nombre, nickname, email,pais)VALUES('Cusi','ElMenosPro','cus@gmail.com','Chile');