

PRAGMA foreign_keys = ON;

CREATE TABLE equipo(
id_equipo INTEGER PRIMARY KEY AUTOINCREMENT,
nombre TEXT,
pais TEXT,
entrenador TEXT,
anio_creacion INTEGER
);

CREATE TABLE robot(
id_robot INTEGER PRIMARY KEY AUTOINCREMENT,
nombre TEXT,
tipo TEXT,
peso REAL,
velocidad REAL,
id_equipo INTEGER,
FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);

CREATE TABLE batalla(
id_batalla INTEGER PRIMARY KEY AUTOINCREMENT,
fecha TEXT,
lugar TEXT,
tipo TEXT,
duracion INTEGER
);

-- N:M
CREATE TABLE robot_batalla(
id_rb INTEGER PRIMARY KEY AUTOINCREMENT,
id_robot INTEGER,
id_batalla INTEGER,
FOREIGN KEY (id_robot) REFERENCES robot(id_robot),
FOREIGN KEY (id_batalla) REFERENCES batalla(id_batalla)
);

CREATE TABLE resultado(
id_resultado INTEGER PRIMARY KEY AUTOINCREMENT,
ganador TEXT,
puntos INTEGER,
estado TEXT,
observacion TEXT,
id_batalla INTEGER,
FOREIGN KEY (id_batalla) REFERENCES batalla(id_batalla)
);