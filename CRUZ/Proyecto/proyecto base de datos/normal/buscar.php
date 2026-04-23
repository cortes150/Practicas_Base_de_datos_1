<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('normal');

$usuario_id = $_SESSION['usuario_id'];
$busqueda = isset($_GET['q']) ? trim($_GET['q']) : '';

$resultadosCanciones = [];
$resultadosAlbumes = [];
$resultadosArtistas = [];

if ($busqueda) {
    // Buscar canciones
    $stmt = $conn->prepare("
        SELECT c.*, a.nombre as artista_nombre, al.imagen as album_imagen
        FROM canciones c
        INNER JOIN artistas a ON a.id = c.id_artista
        INNER JOIN albumes al ON al.id = c.id_album
        WHERE c.titulo LIKE ? OR a.nombre LIKE ?
        LIMIT 20
    ");
    $like = "%$busqueda%";
    $stmt->bind_param("ss", $like, $like);
    $stmt->execute();
    $resultadosCanciones = $stmt->get_result();

    // Buscar álbumes
    $stmt = $conn->prepare("
        SELECT al.*, a.nombre as artista_nombre
        FROM albumes al
        INNER JOIN artistas a ON a.id = al.id_artista
        WHERE al.titulo LIKE ? OR a.nombre LIKE ?
        LIMIT 10
    ");
    $stmt->bind_param("ss", $like, $like);
    $stmt->execute();
    $resultadosAlbumes = $stmt->get_result();

    // Buscar artistas
    $stmt = $conn->prepare("
        SELECT * FROM artistas
        WHERE nombre LIKE ? OR genero_musical LIKE ?
        LIMIT 10
    ");
    $stmt->bind_param("ss", $like, $like);
    $stmt->execute();
    $resultadosArtistas = $stmt->get_result();
}

// Verificar favoritos
$favoritosIds = [];
$result = $conn->query("SELECT id_cancion FROM biblioteca_usuario WHERE id_usuario = $usuario_id");
while ($row = $result->fetch_assoc()) {
    $favoritosIds[] = $row['id_cancion'];
}

// Verificar seguimientos
$seguidosIds = [];
$result = $conn->query("SELECT id_artista FROM seguimientos WHERE id_usuario = $usuario_id");
while ($row = $result->fetch_assoc()) {
    $seguidosIds[] = $row['id_artista'];
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buscar - MusicStream</title>
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
                <h1 class="page-title">Buscar</h1>
            </div>

            <div class="search-container">
                <i class="fas fa-search"></i>
                <input type="text" class="search-input" placeholder="¿Qué quieres escuchar?" value="<?php echo htmlspecialchars($busqueda); ?>" onkeyup="if(event.key === 'Enter') buscar(this.value)">
            </div>

            <?php if ($busqueda): ?>
                <?php if ($resultadosArtistas->num_rows > 0): ?>
                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Artistas</h2>
                    <div class="grid-cards">
                        <?php while ($artista = $resultadosArtistas->fetch_assoc()): ?>
                        <?php $esSeguido = in_array($artista['id'], $seguidosIds); ?>
                        <?php echo renderizarArtista($artista, $esSeguido); ?>
                        <?php endwhile; ?>
                    </div>
                </div>
                <?php endif; ?>

                <?php if ($resultadosAlbumes->num_rows > 0): ?>
                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Álbumes</h2>
                    <div class="grid-cards">
                        <?php while ($album = $resultadosAlbumes->fetch_assoc()): ?>
                        <?php echo renderizarAlbum($album, $album['artista_nombre']); ?>
                        <?php endwhile; ?>
                    </div>
                </div>
                <?php endif; ?>

                <?php if ($resultadosCanciones->num_rows > 0): ?>
                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Canciones</h2>
                    <div class="grid-cards">
                        <?php while ($cancion = $resultadosCanciones->fetch_assoc()): ?>
                        <?php $esFavorita = in_array($cancion['id'], $favoritosIds); ?>
                        <?php echo renderizarCancion($conn, $cancion, $esFavorita); ?>
                        <?php endwhile; ?>
                    </div>
                </div>
                <?php endif; ?>

                <?php if ($resultadosCanciones->num_rows == 0 && $resultadosAlbumes->num_rows == 0 && $resultadosArtistas->num_rows == 0): ?>
                <div style="text-align: center; padding: 50px; color: var(--text-gray);">
                    <i class="fas fa-search" style="font-size: 4rem; margin-bottom: 20px;"></i>
                    <h3>No se encontraron resultados para "<?php echo htmlspecialchars($busqueda); ?>"</h3>
                </div>
                <?php endif; ?>

            <?php else: ?>
                <div style="text-align: center; padding: 50px; color: var(--text-gray);">
                    <i class="fas fa-music" style="font-size: 4rem; margin-bottom: 20px; color: var(--verde-spotify);"></i>
                    <h3>Busca canciones, artistas o álbumes</h3>
                    <p>Encuentra tu música favorita</p>
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