
-- NO HACER ESTO EN PRODUCCIÓN
CREATE TABLE Registro_Sucio (
    id_alumno INT,
    nombre VARCHAR(100),
    cursos_favoritos VARCHAR(255), -- ¡Error! Lista de valores
    ciudad_sede VARCHAR(100)
);
---1FN---
INSERT INTO Registro_Sucio VALUES (101, 'Ana García', 'Guitarra, Piano', 'Madrid');

-- Tabla en 1FN
CREATE TABLE Inscripciones_1FN (
    id_alumno INT,
    nombre VARCHAR(100),
    curso VARCHAR(50), -- Ahora es atómico
    ciudad_sede VARCHAR(100)
);

-- Ahora Ana tiene dos filas, una por cada curso
INSERT INTO Inscripciones_1FN VALUES 
(101, 'Ana García', 'Guitarra', 'Madrid'),
(101, 'Ana García', 'Piano', 'Madrid'),
(102, 'Luis Pérez', 'Batería', 'Barcelona');

---2NF---
CREATE TABLE Alumnos (
    id_alumno INT PRIMARY KEY, -- Llave única
    nombre VARCHAR(100) NOT NULL,
    ciudad_sede VARCHAR(50)
);

INSERT INTO Alumnos (id_alumno, nombre, ciudad_sede) VALUES
(101, 'Ana García', 'Madrid'),
(102, 'Luis Pérez', 'Barcelona');

CREATE TABLE Inscripciones (
    id_alumno INT,
    curso VARCHAR(50),
    -- Definimos que la combinación de alumno y curso sea única
    PRIMARY KEY (id_alumno, curso),
    -- Relacionamos con la tabla principal
    FOREIGN KEY (id_alumno) REFERENCES Alumnos(id_alumno)
);

INSERT INTO Inscripciones (id_alumno, curso) VALUES
(101, 'Guitarra'),
(101, 'Piano'),
(102, 'Batería');