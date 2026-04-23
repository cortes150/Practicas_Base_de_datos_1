<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('normal');

$usuario_id = $_SESSION['usuario_id'];

// Obtener canciones recientes
$cancionesRecientes = $conn->query("
    SELECT c.*, a.nombre as artista_nombre, al.imagen as album_imagen
    FROM canciones c
    INNER JOIN artistas a ON a.id = c.id_artista
    INNER JOIN albumes al ON al.id = c.id_album
    ORDER BY c.fecha_creacion DESC
    LIMIT 10
");

// Obtener últimos álbumes
$albumesRecientes = $conn->query("
    SELECT al.*, a.nombre as artista_nombre
    FROM albumes al
    INNER JOIN artistas a ON a.id = al.id_artista
    ORDER BY al.fecha_creacion DESC
    LIMIT 6
");

// Obtener artistas populares
$artistasPopulares = $conn->query("
    SELECT a.*, COUNT(s.id) as seguidores
    FROM artistas a
    LEFT JOIN seguimientos s ON s.id_artista = a.id
    GROUP BY a.id
    ORDER BY seguidores DESC
    LIMIT 6
");

// Obtener playlists del usuario
$misPlaylists = $conn->query("
    SELECT * FROM playlists WHERE id_usuario = $usuario_id ORDER BY fecha_creacion DESC LIMIT 5
");

// Obtener canciones del usuario en biblioteca
$misFavoritos = $conn->query("
    SELECT c.*, a.nombre as artista_nombre, al.imagen as album_imagen
    FROM biblioteca_usuario b
    INNER JOIN canciones c ON c.id = b.id_cancion
    INNER JOIN artistas a ON a.id = c.id_artista
    INNER JOIN albumes al ON al.id = c.id_album
    WHERE b.id_usuario = $usuario_id
    ORDER BY b.fecha_agregado DESC
    LIMIT 10
");

// Verificar cuáles canciones son favoritas
$favoritosIds = [];
$result = $conn->query("SELECT id_cancion FROM biblioteca_usuario WHERE id_usuario = $usuario_id");
while ($row = $result->fetch_assoc()) {
    $favoritosIds[] = $row['id_cancion'];
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio - MusicStream</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-tipo="normal">
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-logo">
                <h2><i class="fas fa-music"></i> Music<span>Stream</span></h2>
            </div>
            <nav class="sidebar-nav" id="navbar-content"></nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">¡Bienvenido, <?php echo htmlspecialchars($_SESSION['nombre_usuario']); ?>!</h1>
                <div class="user-menu">
                    <div class="user-dropdown">
                        <div class="user-avatar" onclick="toggleDropdown()">
                            <?php echo strtoupper($_SESSION['nombre_usuario'][0]); ?>
                        </div>
                        <div class="dropdown-menu">
                            <a href="perfil.php" class="dropdown-item"><i class="fas fa-user"></i> Mi Perfil</a>
                            <a href="../index.php?logout=1" class="dropdown-item logout"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sección de Favoritos -->
            <?php if ($misFavoritos->num_rows > 0): ?>
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">Tus Favoritos</h2>
                    <a href="biblioteca.php" class="section-link">Ver todos <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="grid-cards">
                    <?php while ($cancion = $misFavoritos->fetch_assoc()):
                        $esFavorita = in_array($cancion['id'], $favoritosIds);
                        echo renderizarCancion($conn, $cancion, $esFavorita);
                    endwhile; ?>
                </div>
            </div>
            <?php endif; ?>

            <!-- Sección de Álbumes Recientes -->
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">Álbumes Recientes</h2>
                </div>
                <div class="grid-cards">
                    <?php while ($album = $albumesRecientes->fetch_assoc()): ?>
                    <div class="album-card" onclick="verAlbum(<?php echo $album['id']; ?>)">
                        <div class="album-imagen">
                            <img src="<?php echo $album['imagen'] ?: 'https://via.placeholder.com/300x300/1DB954/fff?text=♪'; ?>" alt="<?php echo htmlspecialchars($album['titulo']); ?>">
                            <div class="play-overlay">
                                <i class="fas fa-play"></i>
                            </div>
                        </div>
                        <div class="album-info">
                            <h4><?php echo htmlspecialchars($album['titulo']); ?></h4>
                            <p><?php echo htmlspecialchars($album['artista_nombre']); ?></p>
                            <span class="ano"><?php echo $album['ano_lanzamiento']; ?></span>
                        </div>
                    </div>
                    <?php endwhile; ?>
                </div>
            </div>

            <!-- Sección de Artistas Populares -->
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">Artistas Populares</h2>
                </div>
                <div class="grid-cards">
                    <?php while ($artista = $artistasPopulares->fetch_assoc()): ?>
                    <div class="artista-card" onclick="verArtista(<?php echo $artista['id']; ?>)">
                        <div class="artista-imagen">
                            <img src="<?php echo $artista['imagen'] ?: 'https://via.placeholder.com/300x300/1DB954/fff?text=♪'; ?>" alt="<?php echo htmlspecialchars($artista['nombre']); ?>">
                        </div>
                        <div class="artista-info">
                            <h4><?php echo htmlspecialchars($artista['nombre']); ?></h4>
                            <p><?php echo htmlspecialchars($artista['genero_musical']); ?></p>
                        </div>
                    </div>
                    <?php endwhile; ?>
                </div>
            </div>

            <!-- Sección de Canciones Recientes -->
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">Canciones Recientes</h2>
                </div>
                <div class="grid-cards">
                    <?php while ($cancion = $cancionesRecientes->fetch_assoc()):
                        $esFavorita = in_array($cancion['id'], $favoritosIds);
                        echo renderizarCancion($conn, $cancion, $esFavorita);
                    endwhile; ?>
                </div>
            </div>

            <!-- Sección de Mis Playlists -->
            <?php if ($misPlaylists->num_rows > 0): ?>
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">Mis Playlists</h2>
                    <button class="btn btn-secondary" onclick="mostrarModal('crear-playlist-modal')">
                        <i class="fas fa-plus"></i> Nueva Playlist
                    </button>
                </div>
                <div class="grid-cards">
                    <?php while ($playlist = $misPlaylists->fetch_assoc()): ?>
                    <div class="playlist-card" onclick="window.location.href='playlist.php?id=<?php echo $playlist['id']; ?>'">
                        <div class="playlist-imagen">
                            <i class="fas fa-music"></i>
                        </div>
                        <div class="playlist-info">
                            <h4><?php echo htmlspecialchars($playlist['nombre']); ?></h4>
                            <p><?php echo htmlspecialchars($playlist['descripcion'] ?: 'Sin descripción'); ?></p>
                        </div>
                    </div>
                    <?php endwhile; ?>
                </div>
            </div>
            <?php else: ?>
            <div class="section">
                <h2 class="section-title" style="margin-bottom: 20px;">Crea tu primera playlist</h2>
                <button class="btn btn-secondary" onclick="mostrarModal('crear-playlist-modal')">
                    <i class="fas fa-plus"></i> Nueva Playlist
                </button>
            </div>
            <?php endif; ?>
        </main>
    </div>

    <!-- Player Fijo -->
    <div class="player">
        <div class="player-info" id="player-info">
            <div class="player-imagen">
                <img src="https://via.placeholder.com/56x56/1DB954/fff?text=♪" alt="" id="player-image">
            </div>
            <div class="player-details">
                <h4 id="player-title">Selecciona una canción</h4>
                <p id="player-artist">-</p>
            </div>
        </div>
        <div class="player-controls">
            <div class="control-buttons">
                <button><i class="fas fa-random"></i></button>
                <button><i class="fas fa-step-backward"></i></button>
                <button class="play-btn" id="btn-play" onclick="togglePlayPause()">
                    <i class="fas fa-play"></i>
                </button>
                <button><i class="fas fa-step-forward"></i></button>
                <button><i class="fas fa-redo"></i></button>
            </div>
            <div class="progress-bar">
                <span class="progress-time" id="current-time">0:00</span>
                <div class="progress-container">
                    <div class="progress-fill"></div>
                </div>
                <span class="progress-time">3:30</span>
            </div>
        </div>
        <div class="player-volume">
            <i class="fas fa-volume-up"></i>
            <input type="range" min="0" max="100" value="100">
        </div>
    </div>

    <!-- Modal Crear Playlist -->
    <div class="modal" id="crear-playlist-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Nueva Playlist</h3>
                <button class="modal-close" onclick="cerrarModal('crear-playlist-modal')">&times;</button>
            </div>
            <div class="form-group">
                <label>Nombre</label>
                <input type="text" id="playlist-nombre" placeholder="Mi playlist">
            </div>
            <div class="form-group">
                <label>Descripción</label>
                <textarea id="playlist-descripcion" rows="2" placeholder="Descripción opcional"></textarea>
            </div>
            <div class="form-group">
                <label>
                    <input type="checkbox" id="playlist-publica" checked> Playlist pública
                </label>
            </div>
            <button onclick="crearPlaylist()" class="btn-primary">Crear Playlist</button>
        </div>
    </div>

    <script src="../js/main.js"></script>
</body>
</html>