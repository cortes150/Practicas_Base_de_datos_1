-- MusicStream - Base de Datos MySQL
-- Crear base de datos
CREATE DATABASE IF NOT EXISTS musicstream;
USE musicstream;

-- Usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    tipo ENUM('admin', 'normal') DEFAULT 'normal',
    imagen_perfil VARCHAR(255) DEFAULT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Artistas
CREATE TABLE IF NOT EXISTS artistas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    biografia TEXT,
    imagen VARCHAR(255),
    genero_musical VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Álbumes
CREATE TABLE IF NOT EXISTS albumes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    id_artista INT NOT NULL,
    ano_lanzamiento YEAR,
    imagen VARCHAR(255),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_artista) REFERENCES artistas(id) ON DELETE CASCADE
);

-- Canciones
CREATE TABLE IF NOT EXISTS canciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    id_album INT NOT NULL,
    id_artista INT NOT NULL,
    duracion TIME,
    genero VARCHAR(100),
    archivo_audio VARCHAR(255),
    reproducciones INT DEFAULT 0,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_album) REFERENCES albumes(id) ON DELETE CASCADE,
    FOREIGN KEY (id_artista) REFERENCES artistas(id) ON DELETE CASCADE
);

-- Playlists
CREATE TABLE IF NOT EXISTS playlists (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200) NOT NULL,
    id_usuario INT NOT NULL,
    descripcion TEXT,
    imagen VARCHAR(255),
    es_publica BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Playlist_Canciones
CREATE TABLE IF NOT EXISTS playlist_canciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_playlist INT NOT NULL,
    id_cancion INT NOT NULL,
    posicion INT,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_playlist) REFERENCES playlists(id) ON DELETE CASCADE,
    FOREIGN KEY (id_cancion) REFERENCES canciones(id) ON DELETE CASCADE
);

-- Seguimientos
CREATE TABLE IF NOT EXISTS seguimientos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_artista INT NOT NULL,
    fecha_seguimiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_artista) REFERENCES artistas(id) ON DELETE CASCADE,
    UNIQUE KEY unique_seguimiento (id_usuario, id_artista)
);

-- Biblioteca de usuario
CREATE TABLE IF NOT EXISTS biblioteca_usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_cancion INT NOT NULL,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_cancion) REFERENCES canciones(id) ON DELETE CASCADE,
    UNIQUE KEY unique_cancion_usuario (id_usuario, id_cancion)
);

-- Insertar usuario admin por defecto
INSERT INTO usuarios (nombre, email, password, tipo) VALUES
('Administrador', 'admin@musicstream.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('Usuario Demo', 'demo@musicstream.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'normal');

-- Insertar artistas de ejemplo
INSERT INTO artistas (nombre, biografia, imagen, genero_musical) VALUES
('The Weeknd', 'Artista canadiense de R&B y pop', 'https://i.scdn.co/image/ab6761610000e5eb2c1a8ecf5b8aa45c58c2df62', 'R&B'),
('Bad Bunny', 'Artista puertorriqueño de reggaeton y trap', 'https://i.scdn.co/image/ab6761610000e5ebbc7c5791c4144f42d5caab21', 'Reggaeton'),
('Taylor Swift', 'Artista estadounidense de pop y country', 'https://i.scdn.co/image/ab6761610000e5eb5d977f5c5f5c9b3ccca87c32', 'Pop'),
('Drake', 'Artista canadiense de hip hop y R&B', 'https://i.scdn.co/image/ab6761610000e5eba2d8e7c2c3f5e3d3c5c7d1c3', 'Hip Hop'),
('Billie Eilish', 'Artista estadounidense de pop alternativo', 'https://i.scdn.co/image/ab6761610000e5eb4a7e5c5e5a5c5e5a5c5e5a5', 'Pop');

-- Insertar álbumes de ejemplo
INSERT INTO albumes (titulo, id_artista, ano_lanzamiento, imagen) VALUES
('After Hours', 1, 2020, 'https://i.scdn.co/image/ab67616d0000b2738863bc11d2aa12b54f5aeb36'),
('Starboy', 1, 2016, 'https://i.scdn.co/image/ab67616d0000b2737c8e0e72f0d1c4b7c9f9f8c3'),
('Un Verano Sin Ti', 2, 2022, 'https://i.scdn.co/image/ab67616d0000b273c8c8c8c8c8c8c8c8c8c8c8c8c'),
('YHLQMDLG', 2, 2020, 'https://i.scdn.co/image/ab67616d0000b273a1b2c3d4e5f6a7b8c9d0e1f'),
('Midnights', 3, 2022, 'https://i.scdn.co/image/ab67616d0000b2731a2b3c4d5e6f7a8b9c0d1e2'),
('1989', 3, 2014, 'https://i.scdn.co/image/ab67616d0000b2732a3b4c5d6e7f8a9b0c1d2e3'),
('Certified Lover Boy', 4, 2021, 'https://i.scdn.co/image/ab67616d0000b2733a4b5c6d7e8f9a0b1c2d3e4'),
('Scorpion', 4, 2018, 'https://i.scdn.co/image/ab67616d0000b2734a5b6c7d8e9f0a1b2c3d4e5'),
('Happier Than Ever', 5, 2021, 'https://i.scdn.co/image/ab67616d0000b2735a6b7c8d9e0f1a2b3c4d5e6'),
('When We All Fall Asleep, Where Do We Go?', 5, 2019, 'https://i.scdn.co/image/ab67616d0000b2736a7b8c9d0e1f2a3b4c5d6e7');

-- Insertar canciones de ejemplo
INSERT INTO canciones (titulo, id_album, id_artista, duracion, genero, reproducciones) VALUES
('Save Your Tears', 1, 1, '03:35', 'R&B', 1500000),
('Blinding Lights', 1, 1, '03:20', 'Synthwave', 3000000),
('Heartless', 1, 1, '03:18', 'R&B', 1200000),
('Starboy', 2, 1, '03:50', 'R&B', 2500000),
('Die For You', 2, 1, '03:58', 'R&B', 1800000),
('Me Porto Bonito', 3, 2, '02:50', 'Reggaeton', 2200000),
('Efecto', 3, 2, '03:28', 'Reggaeton', 1900000),
('Titi Me Pregunto', 3, 2, '02:48', 'Reggaeton', 2100000),
('Dákiti', 4, 2, '03:25', 'Reggaeton', 2000000),
('La Santa', 4, 2, '03:26', 'Reggaeton', 1700000),
('Anti-Hero', 5, 3, '03:20', 'Pop', 1600000),
('Lavender Haze', 5, 3, '03:22', 'Pop', 1400000),
('Karma', 5, 3, '03:15', 'Pop', 1300000),
('Shake It Off', 6, 3, '03:39', 'Pop', 2800000),
('Blank Space', 6, 3, '03:51', 'Pop', 2700000),
('God''s Plan', 7, 4, '03:19', 'Hip Hop', 3200000),
('Started From the Bottom', 7, 4, '03:12', 'Hip Hop', 2100000),
('Hotline Bling', 8, 4, '04:00', 'Hip Hop', 2400000),
('In My Feelings', 8, 4, '03:37', 'Hip Hop', 2200000),
('Bad Guy', 9, 5, '03:14', 'Pop', 2600000),
('Ocean Eyes', 10, 5, '03:30', 'Pop', 2500000);

-- Insertar playlists de ejemplo
INSERT INTO playlists (nombre, id_usuario, descripcion, es_publica) VALUES
('Mis Favoritas', 2, 'Mis canciones favoritas', TRUE),
('Para Entrenar', 2, 'Música para workouts', TRUE),
('Relajación', 2, 'Para relajarse', TRUE);