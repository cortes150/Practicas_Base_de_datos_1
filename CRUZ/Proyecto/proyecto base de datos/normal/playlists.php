<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('normal');

$usuario_id = $_SESSION['usuario_id'];

// Obtener playlists del usuario
$misPlaylists = $conn->query("
    SELECT p.*, (SELECT COUNT(*) FROM playlist_canciones WHERE id_playlist = p.id) as total_canciones
    FROM playlists p
    WHERE p.id_usuario = $usuario_id
    ORDER BY p.fecha_creacion DESC
");

// Obtener playlists públicas de otros usuarios
$otrasPlaylists = $conn->query("
    SELECT p.*, u.nombre as usuario_nombre,
           (SELECT COUNT(*) FROM playlist_canciones WHERE id_playlist = p.id) as total_canciones
    FROM playlists p
    INNER JOIN usuarios u ON u.id = p.id_usuario
    WHERE p.id_usuario != $usuario_id AND p.es_publica = TRUE
    ORDER BY p.fecha_creacion DESC
    LIMIT 20
");
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Playlists - MusicStream</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-tipo="normal">
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-logo">
                <h2><i class="fas fa-music"></i> Music<span>Stream</span></h2>
            </div>
            <nav class="sidebar-nav" id="navbar-content"></nav>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Playlists</h1>
                <button class="btn btn-secondary" onclick="mostrarModal('crear-playlist-modal')">
                    <i class="fas fa-plus"></i> Nueva Playlist
                </button>
            </div>

            <!-- Mis Playlists -->
            <div class="section">
                <h2 class="section-title" style="margin-bottom: 20px;">Mis Playlists</h2>
                <?php if ($misPlaylists->num_rows > 0): ?>
                <div class="grid-cards">
                    <?php while ($playlist = $misPlaylists->fetch_assoc()): ?>
                    <div class="playlist-card" onclick="window.location.href='playlist.php?id=<?php echo $playlist['id']; ?>'">
                        <div class="playlist-imagen">
                            <i class="fas fa-music"></i>
                        </div>
                        <div class="playlist-info">
                            <h4><?php echo htmlspecialchars($playlist['nombre']); ?></h4>
                            <p><?php echo $playlist['total_canciones']; ?> canciones</p>
                            <p style="font-size: 0.8rem;"><?php echo htmlspecialchars($playlist['descripcion'] ?: 'Sin descripción'); ?></p>
                        </div>
                    </div>
                    <?php endwhile; ?>
                </div>
                <?php else: ?>
                <p style="color: var(--text-gray);">No tienes playlists todavía.</p>
                <?php endif; ?>
            </div>

            <!-- Playlists Públicas -->
            <?php if ($otrasPlaylists->num_rows > 0): ?>
            <div class="section">
                <h2 class="section-title" style="margin-bottom: 20px;">Playlists Públicas</h2>
                <div class="grid-cards">
                    <?php while ($playlist = $otrasPlaylists->fetch_assoc()): ?>
                    <div class="playlist-card" onclick="window.location.href='playlist.php?id=<?php echo $playlist['id']; ?>'">
                        <div class="playlist-imagen">
                            <i class="fas fa-music"></i>
                        </div>
                        <div class="playlist-info">
                            <h4><?php echo htmlspecialchars($playlist['nombre']); ?></h4>
                            <p>Por <?php echo htmlspecialchars($playlist['usuario_nombre']); ?></p>
                            <p><?php echo $playlist['total_canciones']; ?> canciones</p>
                        </div>
                    </div>
                    <?php endwhile; ?>
                </div>
            </div>
            <?php endif; ?>
        </main>
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

    <script src="../js/main.js"></script>
</body>
</html>