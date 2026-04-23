<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('normal');

$usuario_id = $_SESSION['usuario_id'];

// Obtener canciones guardadas
$canciones = $conn->query("
    SELECT c.*, a.nombre as artista_nombre, al.imagen as album_imagen
    FROM biblioteca_usuario b
    INNER JOIN canciones c ON c.id = b.id_cancion
    INNER JOIN artistas a ON a.id = c.id_artista
    INNER JOIN albumes al ON al.id = c.id_album
    WHERE b.id_usuario = $usuario_id
    ORDER BY b.fecha_agregado DESC
");
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tu Biblioteca - MusicStream</title>
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
                <h1 class="page-title">Tu Biblioteca</h1>
            </div>

            <?php if ($canciones->num_rows > 0): ?>
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">Canciones Guardadas</h2>
                    <span style="color: var(--text-gray);"><?php echo $canciones->num_rows; ?> canciones</span>
                </div>
                <div class="grid-cards">
                    <?php while ($cancion = $canciones->fetch_assoc()): ?>
                    <?php echo renderizarCancion($conn, $cancion, true); ?>
                    <?php endwhile; ?>
                </div>
            </div>
            <?php else: ?>
            <div style="text-align: center; padding: 50px; color: var(--text-gray);">
                <i class="fas fa-heart" style="font-size: 4rem; margin-bottom: 20px; color: var(--verde-spotify);"></i>
                <h3>Tu biblioteca está vacía</h3>
                <p>Guarda tus canciones favoritas aquí</p>
                <a href="home.php" class="btn btn-secondary" style="margin-top: 20px; display: inline-block; text-decoration: none;">
                    <i class="fas fa-search"></i> Explorar música
                </a>
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
</body>
</html>