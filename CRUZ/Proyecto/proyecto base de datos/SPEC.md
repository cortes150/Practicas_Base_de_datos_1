# MusicStream - Sistema de Música Tipo Spotify

## 1. Overview del Proyecto

**Nombre:** MusicStream
**Tipo:** Aplicación Web de Streaming de Música
**Funcionalidad Principal:** Sistema de música con gestión de artistas, álbumes, canciones, playlists y seguimiento de usuarios
**Usuarios:** Administrador (reportes/estadísticas) y Usuario Normal (consumo de música)

---

## 2. Estructura de la Base de Datos

### Tablas MySQL

```sql
-- Usuarios
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    tipo ENUM('admin', 'normal') DEFAULT 'normal',
    imagen_perfil VARCHAR(255) DEFAULT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Artistas
CREATE TABLE artistas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    biografia TEXT,
    imagen VARCHAR(255),
    genero_musical VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Álbumes
CREATE TABLE albumes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    id_artista INT NOT NULL,
    ano_lanzamiento YEAR,
    imagen VARCHAR(255),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_artista) REFERENCES artistas(id) ON DELETE CASCADE
);

-- Canciones
CREATE TABLE canciones (
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
CREATE TABLE playlists (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200) NOT NULL,
    id_usuario INT NOT NULL,
    descripcion TEXT,
    imagen VARCHAR(255),
    es_publica BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Playlist_Canciones (relación muchos a muchos)
CREATE TABLE playlist_canciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_playlist INT NOT NULL,
    id_cancion INT NOT NULL,
    posicion INT,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_playlist) REFERENCES playlists(id) ON DELETE CASCADE,
    FOREIGN KEY (id_cancion) REFERENCES canciones(id) ON DELETE CASCADE
);

-- Seguimientos (usuarios siguen artistas)
CREATE TABLE seguimientos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_artista INT NOT NULL,
    fecha_seguimiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_artista) REFERENCES artistas(id) ON DELETE CASCADE,
    UNIQUE KEY unique_seguimiento (id_usuario, id_artista)
);

-- Biblioteca de usuario (canciones guardadas)
CREATE TABLE biblioteca_usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_cancion INT NOT NULL,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_cancion) REFERENCES canciones(id) ON DELETE CASCADE,
    UNIQUE KEY unique_cancion_usuario (id_usuario, id_cancion)
);
```

---

## 3. Funcionalidades por Tipo de Usuario

### Usuario Administrador (Admin)

**Reportes y Estadísticas:**
- Total de artistas registrados
- Total de álbumes en el sistema
- Total de canciones en el sistema
- Total de usuarios registrados
- Total de playlists creadas
- Canciones por álbum (de cada artista)
- Albums por artista
- Canciones por artista
- Playlists creadas por cada usuario
- Canciones guardadas por cada usuario
- Usuarios que siguen cada artista
- Top 10 canciones más reproducidas
- Top 10 artistas más seguidos
- Top 10 usuarios con más playlists
- Ganancias (simulado) por reproducciones

### Usuario Normal

**Gestión de Música:**
- Ver catálogo de canciones
- Ver álbums por artista
- Reproducir canciones
- Buscar canciones, artistas, álbumes

**Playlists:**
- Crear playlists propias
- Editar playlists (agregar/eliminar canciones)
- Eliminar playlists
- Ver playlists públicas de otros usuarios

**Seguimientos:**
- Seguir artistas
- Dejar de seguir artistas
- Ver artistas seguidos

**Biblioteca Personal:**
- Guardar canciones favoritas
- Ver canciones guardadas
- Eliminar de favoritos

**Perfil:**
- Editar perfil
- Ver historial de reproducciones

---

## 4. Diseño UI/UX

### Paleta de Colores (Dark Theme Spotify-like)
- **Background Principal:** #121212
- **Background Secundario:** #181818
- **Background Cards:** #282828
- **Verde Spotify:** #1DB954
- **Verde Hover:** #1ED760
- **Texto Blanco:** #FFFFFF
- **Texto Gris:** #B3B3B3
- **Rojo Error:** #E91429
- **Naranja:** #FFA500

### Tipografía
- **Títulos:** Montserrat Bold
- **Body:** Inter / Roboto

### Layout
- Sidebar navegación izquierda (250px)
- Main content principal
- Player fijo abajo (90px)
- Responsive: sidebar colapsable en móvil

---

## 5. Estructura de Archivos

```
/proyecto base de datos/
├── index.php              (Login/Registro)
├── dashboard.php          (Panel principal según tipo usuario)
├── admin/
│   ├── index.php          (Reportes admin)
│   ├── artistas.php        (Gestión artistas)
│   ├── albumes.php         (Gestión álbumes)
│   ├── canciones.php      (Gestión canciones)
│   └── usuarios.php       (Gestión usuarios)
├── normal/
│   ├── home.php           (Inicio usuario normal)
│   ├── buscar.php         (Búsqueda)
│   ├── playlist.php       (Ver playlist)
│   ├── biblioteca.php     (Canciones guardadas)
│   ├── artistas.php       (Explorar artistas)
│   └── perfil.php         (Perfil usuario)
├── includes/
│   ├── db.php             (Conexión MySQL)
│   ├── funciones.php      (Funciones helper)
│   └── header.php        (Header común)
├── css/
│   └── styles.css        (Estilos)
├── js/
│   └── main.js           (JavaScript)
├── assets/
│   └── (imágenes)
└── SPEC.md
```

---

## 6. APIs y Endpoints

- Sesiones PHP para autenticación
- AJAX para operaciones sin recarga
- Fetch API para reproductor de música

---

## 7. Consideraciones de Seguridad

- Contraseñas hasheadas con password_hash()
- SQL injection prevención con prepared statements
- XSS prevención con htmlspecialchars
- Sesiones seguras con regenerate_id
- Validación de permisos por tipo de usuario