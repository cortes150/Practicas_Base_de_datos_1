<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('normal');

$usuario_id = $_SESSION['usuario_id'];
$playlist_id = isset($_GET['id']) ? $_GET['id'] : 0;

// Verificar que la playlist existe
$playlist = $conn->query("
    SELECT p.*, u.nombre as usuario_nombre
    FROM playlists p
    INNER JOIN usuarios u ON u.id = p.id_usuario
    WHERE p.id = $playlist_id
")->fetch_assoc();

if (!$playlist) {
    header('Location: playlists.php');
    exit;
}

// Verificar permisos
$esDueno = ($playlist['id_usuario'] == $usuario_id);
$esPublica = $playlist['es_publica'];

if (!$esDueno && !$esPublica) {
    header('Location: playlists.php');
    exit;
}

// Obtener canciones de la playlist
$canciones = $conn->query("
    SELECT c.*, a.nombre as artista_nombre, al.imagen as album_imagen
    FROM playlist_canciones pc
    INNER JOIN canciones c ON c.id = pc.id_cancion
    INNER JOIN artistas a ON a.id = c.id_artista
    INNER JOIN albumes al ON al.id = c.id_album
    WHERE pc.id_playlist = $playlist_id
    ORDER BY pc.posicion, pc.fecha_agregado
");

// Obtener playlists del usuario para agregar canciones
$misPlaylists = $conn->query("
    SELECT id, nombre FROM playlists WHERE id_usuario = $usuario_id
");

// Verificar favoritos
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
    <title><?php echo htmlspecialchars($playlist['nombre']); ?> - MusicStream</title>
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
                <a href="playlists.php" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver
                </a>
                <?php if ($esDueno): ?>
                <button class="btn btn-danger" onclick="eliminarPlaylist(<?php echo $playlist_id; ?>)">
                    <i class="fas fa-trash"></i> Eliminar Playlist
                </button>
                <?php endif; ?>
            </div>

            <div style="margin-bottom: 30px;">
                <div class="playlist-imagen" style="width: 200px; height: 200px; margin: 0 auto 20px; font-size: 6rem;">
                    <i class="fas fa-music"></i>
                </div>
                <h1 style="text-align: center; font-size: 2rem; margin-bottom: 10px;"><?php echo htmlspecialchars($playlist['nombre']); ?></h1>
                <p style="text-align: center; color: var(--text-gray);">
                    <?php if ($esDueno): ?>
                        Tu playlist
                    <?php else: ?>
                        Por <?php echo htmlspecialchars($playlist['usuario_nombre']); ?>
                    <?php endif; ?>
                    • <?php echo $canciones->num_rows; ?> canciones
                </p>
                <?php if ($playlist['descripcion']): ?>
                <p style="text-align: center; color: var(--text-gray); margin-top: 10px;">
                    <?php echo htmlspecialchars($playlist['descripcion']); ?>
                </p>
                <?php endif; ?>
            </div>

            <?php if ($canciones->num_rows > 0): ?>
            <div class="section">
                <div class="grid-cards">
                    <?php while ($cancion = $canciones->fetch_assoc()): ?>
                    <?php $esFavorita = in_array($cancion['id'], $favoritosIds); ?>
                    <div style="position: relative;">
                        <?php echo renderizarCancion($conn, $cancion, $esFavorita); ?>
                        <?php if ($esDueno): ?>
                        <button style="position: absolute; top: 5px; right: 5px; background: var(--rojo-error); border: none; color: white; width: 25px; height: 25px; border-radius: 50%; cursor: pointer;" onclick="event.stopPropagation(); eliminarDePlaylist(<?php echo $playlist_id; ?>, <?php echo $cancion['id']; ?>)">
                            <i class="fas fa-times"></i>
                        </button>
                        <?php endif; ?>
                    </div>
                    <?php endwhile; ?>
                </div>
            </div>
            <?php else: ?>
            <div style="text-align: center; padding: 50px; color: var(--text-gray);">
                <i class="fas fa-music" style="font-size: 4rem; margin-bottom: 20px; color: var(--verde-spotify);"></i>
                <h3>Esta playlist está vacía</h3>
                <?php if ($esDueno): ?>
                <p>Agrega canciones desde el hogar</p>
                <?php endif; ?>
            </div>
            <?php endif; ?>
        </main>
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
    <script>
        function eliminarPlaylist(id) {
            if (confirm('¿Estás seguro de que deseas eliminar esta playlist?')) {
                window.location.href = '../includes/ajax.php?action=eliminarPlaylist&id=' + id;
            }
        }

        function eliminarDePlaylist(playlistId, cancionId) {
            if (confirm('¿Eliminar esta canción de la playlist?')) {
                fetch('../includes/ajax.php?action=eliminarDePlaylist&playlist=' + playlistId + '&cancion=' + cancionId)
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            location.reload();
                        } else {
                            alert(data.message || 'Error');
                        }
                    });
            }
        }
    </script>
</body>
</html>