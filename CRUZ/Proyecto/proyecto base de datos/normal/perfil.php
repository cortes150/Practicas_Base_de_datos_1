<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('normal');

$usuario_id = $_SESSION['usuario_id'];
$error = '';
$success = '';

// Actualizar perfil
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['actualizar'])) {
    $nombre = trim($_POST['nombre']);

    if (empty($nombre)) {
        $error = 'El nombre es requerido';
    } else {
        $stmt = $conn->prepare("UPDATE usuarios SET nombre = ? WHERE id = ?");
        $stmt->bind_param("si", $nombre, $usuario_id);

        if ($stmt->execute()) {
            $_SESSION['nombre_usuario'] = $nombre;
            $success = 'Perfil actualizado correctamente';
        } else {
            $error = 'Error al actualizar perfil';
        }
    }
}

// Cambiar contraseña
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['cambiar_password'])) {
    $password_actual = $_POST['password_actual'];
    $password_nuevo = $_POST['password_nuevo'];
    $confirm_password = $_POST['confirm_password'];

    if ($password_nuevo !== $confirm_password) {
        $error = 'Las contraseñas no coinciden';
    } else {
        // Verificar contraseña actual
        $stmt = $conn->prepare("SELECT password FROM usuarios WHERE id = ?");
        $stmt->bind_param("i", $usuario_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if (!password_verify($password_actual, $user['password'])) {
            $error = 'La contraseña actual es incorrecta';
        } else {
            $password_hash = password_hash($password_nuevo, PASSWORD_DEFAULT);
            $stmt = $conn->prepare("UPDATE usuarios SET password = ? WHERE id = ?");
            $stmt->bind_param("si", $password_hash, $usuario_id);

            if ($stmt->execute()) {
                $success = 'Contraseña cambiada correctamente';
            } else {
                $error = 'Error al cambiar contraseña';
            }
        }
    }
}

// Obtener estadísticas del usuario
$stats = $conn->query("
    SELECT
        (SELECT COUNT(*) FROM playlists WHERE id_usuario = $usuario_id) as playlists,
        (SELECT COUNT(*) FROM biblioteca_usuario WHERE id_usuario = $usuario_id) as favoritos,
        (SELECT COUNT(*) FROM seguimientos WHERE id_usuario = $usuario_id) as siguiendo
")->fetch_assoc();

// Obtener playlists del usuario
$playlists = $conn->query("SELECT * FROM playlists WHERE id_usuario = $usuario_id ORDER BY fecha_creacion DESC");

// Obtener artistas seguidos
$artistasSeguidos = $conn->query("
    SELECT a.* FROM artistas a
    INNER JOIN seguimientos s ON s.id_artista = a.id
    WHERE s.id_usuario = $usuario_id
");
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - MusicStream</title>
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
                <h1 class="page-title">Mi Perfil</h1>
            </div>

            <?php if ($error): ?>
                <div class="error-message"><?php echo htmlspecialchars($error); ?></div>
            <?php endif; ?>

            <?php if ($success): ?>
                <div class="success-message"><?php echo htmlspecialchars($success); ?></div>
            <?php endif; ?>

            <!-- Estadísticas -->
            <div class="stats-grid" style="margin-bottom: 40px;">
                <div class="stat-card">
                    <i class="fas fa-list"></i>
                    <h3><?php echo $stats['playlists']; ?></h3>
                    <p>Playlists Creadas</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-heart"></i>
                    <h3><?php echo $stats['favoritos']; ?></h3>
                    <p>Canciones Favoritas</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-users"></i>
                    <h3><?php echo $stats['siguiendo']; ?></h3>
                    <p>Artistas Siguiendo</p>
                </div>
            </div>

            <!-- Tabs -->
            <div class="tabs">
                <button class="tab active" onclick="switchTab('perfil')">Editar Perfil</button>
                <button class="tab" onclick="switchTab('password')">Cambiar Contraseña</button>
                <button class="tab" onclick="switchTab('mis-datos')">Mis Datos</button>
            </div>

            <!-- Editar Perfil -->
            <div class="tab-content active" id="perfil-content">
                <div class="card" style="max-width: 500px; margin: 0 auto;">
                    <h3 style="margin-bottom: 20px;">Información del Perfil</h3>
                    <form method="POST">
                        <input type="hidden" name="actualizar" value="1">
                        <div class="form-group">
                            <label>Nombre</label>
                            <input type="text" name="nombre" value="<?php echo htmlspecialchars($_SESSION['nombre_usuario']); ?>" required>
                        </div>
                        <button type="submit" class="btn-primary">Guardar Cambios</button>
                    </form>
                </div>
            </div>

            <!-- Cambiar Contraseña -->
            <div class="tab-content" id="password-content">
                <div class="card" style="max-width: 500px; margin: 0 auto;">
                    <h3 style="margin-bottom: 20px;">Cambiar Contraseña</h3>
                    <form method="POST">
                        <input type="hidden" name="cambiar_password" value="1">
                        <div class="form-group">
                            <label>Contraseña Actual</label>
                            <input type="password" name="password_actual" required>
                        </div>
                        <div class="form-group">
                            <label>Nueva Contraseña</label>
                            <input type="password" name="password_nuevo" required>
                        </div>
                        <div class="form-group">
                            <label>Confirmar Nueva Contraseña</label>
                            <input type="password" name="confirm_password" required>
                        </div>
                        <button type="submit" class="btn-primary">Cambiar Contraseña</button>
                    </form>
                </div>
            </div>

            <!-- Mis Datos -->
            <div class="tab-content" id="mis-datos-content">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
                    <!-- Playlists -->
                    <div class="card">
                        <h3 style="margin-bottom: 15px;">Mis Playlists</h3>
                        <?php if ($playlists->num_rows > 0): ?>
                        <div style="display: flex; flex-direction: column; gap: 10px;">
                            <?php while ($playlist = $playlists->fetch_assoc()): ?>
                            <a href="playlist.php?id=<?php echo $playlist['id']; ?>" style="display: flex; align-items: center; gap: 10px; padding: 10px; background: var(--bg-hover); border-radius: 8px; text-decoration: none; color: var(--text-white);">
                                <i class="fas fa-music"></i>
                                <span><?php echo htmlspecialchars($playlist['nombre']); ?></span>
                            </a>
                            <?php endwhile; ?>
                        </div>
                        <?php else: ?>
                        <p style="color: var(--text-gray);">No tienes playlists todavía</p>
                        <?php endif; ?>
                    </div>

                    <!-- Artistas Seguidos -->
                    <div class="card">
                        <h3 style="margin-bottom: 15px;">Artistas que Sigo</h3>
                        <?php if ($artistasSeguidos->num_rows > 0): ?>
                        <div style="display: flex; flex-direction: column; gap: 10px;">
                            <?php while ($artista = $artistasSeguidos->fetch_assoc()): ?>
                            <a href="artista.php?id=<?php echo $artista['id']; ?>" style="display: flex; align-items: center; gap: 10px; padding: 10px; background: var(--bg-hover); border-radius: 8px; text-decoration: none; color: var(--text-white);">
                                <img src="<?php echo $artista['imagen'] ?: 'https://via.placeholder.com/40'; ?>" style="width: 40px; height: 40px; border-radius: 50%;">
                                <div>
                                    <div><?php echo htmlspecialchars($artista['nombre']); ?></div>
                                    <div style="font-size: 0.8rem; color: var(--text-gray);"><?php echo htmlspecialchars($artista['genero_musical']); ?></div>
                                </div>
                            </a>
                            <?php endwhile; ?>
                        </div>
                        <?php else: ?>
                        <p style="color: var(--text-gray);">No sigues a ningún artista todavía</p>
                        <a href="artistas.php" class="btn btn-secondary" style="margin-top: 10px; display: inline-block; text-decoration: none;">Explorar Artistas</a>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
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