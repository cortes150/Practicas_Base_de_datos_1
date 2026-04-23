<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('normal');

$usuario_id = $_SESSION['usuario_id'];
$artista_id = isset($_GET['id']) ? $_GET['id'] : 0;

// Obtener artista
$artista = $conn->query("SELECT * FROM artistas WHERE id = $artista_id")->fetch_assoc();

if (!$artista) {
    header('Location: artistas.php');
    exit;
}

// Verificar si lo sigue
$sigue = sigueArtista($conn, $usuario_id, $artista_id);

// Obtener álbumes del artista
$albumes = $conn->query("SELECT * FROM albumes WHERE id_artista = $artista_id ORDER BY ano_lanzamiento DESC");

// Obtener todas las canciones del artista
$canciones = $conn->query("
    SELECT c.*, al.titulo as album_titulo, al.imagen as album_imagen
    FROM canciones c
    INNER JOIN albumes al ON al.id = c.id_album
    WHERE c.id_artista = $artista_id
    ORDER BY c.reproducciones DESC
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
    <title><?php echo htmlspecialchars($artista['nombre']); ?> - MusicStream</title>
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
                <a href="artistas.php" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver
                </a>
            </div>

            <div style="display: flex; align-items: center; gap: 30px; margin-bottom: 40px; padding: 30px; background: linear-gradient(180deg, var(--bg-card) 0%, transparent 100%); border-radius: 12px;">
                <div class="artista-imagen" style="width: 200px; height: 200px;">
                    <img src="<?php echo $artista['imagen'] ?: 'https://via.placeholder.com/200x200/1DB954/fff?text=♪'; ?>" alt="<?php echo htmlspecialchars($artista['nombre']); ?>">
                </div>
                <div>
                    <p style="text-transform: uppercase; font-size: 0.9rem; margin-bottom: 5px;">Artista</p>
                    <h1 style="font-size: 3rem; margin-bottom: 10px;"><?php echo htmlspecialchars($artista['nombre']); ?></h1>
                    <p style="color: var(--text-gray); margin-bottom: 20px;"><?php echo htmlspecialchars($artista['genero_musical']); ?></p>
                    <button class="btn <?php echo $sigue ? 'btn-secondary' : 'btn-primary'; ?>" style="padding: 15px 40px; font-size: 1rem;" onclick="toggleSeguir(<?php echo $artista_id; ?>)">
                        <i class="fas fa-<?php echo $sigue ? 'check' : 'plus'; ?>"></i>
                        <?php echo $sigue ? 'Siguiendo' : 'Seguir'; ?>
                    </button>
                </div>
            </div>

            <?php if ($artista['biografia']): ?>
            <div class="section">
                <h2 class="section-title" style="margin-bottom: 15px;">Biografía</h2>
                <p style="color: var(--text-gray); max-width: 800px;"><?php echo htmlspecialchars($artista['biografia']); ?></p>
            </div>
            <?php endif; ?>

            <?php if ($albumes->num_rows > 0): ?>
            <div class="section">
                <h2 class="section-title" style="margin-bottom: 20px;">Álbumes</h2>
                <div class="grid-cards">
                    <?php while ($album = $albumes->fetch_assoc()): ?>
                    <?php echo renderizarAlbum($album, $artista['nombre']); ?>
                    <?php endwhile; ?>
                </div>
            </div>
            <?php endif; ?>

            <?php if ($canciones->num_rows > 0): ?>
            <div class="section">
                <h2 class="section-title" style="margin-bottom: 20px;">Canciones Populares</h2>
                <div class="grid-cards">
                    <?php while ($cancion = $canciones->fetch_assoc()): ?>
                    <?php $esFavorita = in_array($cancion['id'], $favoritosIds); ?>
                    <?php echo renderizarCancion($conn, $cancion, $esFavorita); ?>
                    <?php endwhile; ?>
                </div>
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