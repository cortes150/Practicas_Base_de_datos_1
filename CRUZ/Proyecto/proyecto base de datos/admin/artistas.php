<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('admin');

$error = '';
$success = '';

// Agregar artista
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['agregar'])) {
    $nombre = trim($_POST['nombre']);
    $biografia = trim($_POST['biografia']);
    $genero = trim($_POST['genero']);
    $imagen = trim($_POST['imagen']);

    if (empty($nombre)) {
        $error = 'El nombre es requerido';
    } else {
        $stmt = $conn->prepare("INSERT INTO artistas (nombre, biografia, genero_musical, imagen) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssss", $nombre, $biografia, $genero, $imagen);

        if ($stmt->execute()) {
            $success = 'Artista agregado correctamente';
        } else {
            $error = 'Error al agregar artista';
        }
    }
}

// Editar artista
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['editar'])) {
    $id = $_POST['id'];
    $nombre = trim($_POST['nombre']);
    $biografia = trim($_POST['biografia']);
    $genero = trim($_POST['genero']);
    $imagen = trim($_POST['imagen']);

    $stmt = $conn->prepare("UPDATE artistas SET nombre = ?, biografia = ?, genero_musical = ?, imagen = ? WHERE id = ?");
    $stmt->bind_param("ssssi", $nombre, $biografia, $genero, $imagen, $id);

    if ($stmt->execute()) {
        $success = 'Artista actualizado correctamente';
    } else {
        $error = 'Error al actualizar artista';
    }
}

// Eliminar artista
if (isset($_GET['eliminar'])) {
    $id = $_GET['eliminar'];
    $stmt = $conn->prepare("DELETE FROM artistas WHERE id = ?");
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        $success = 'Artista eliminado correctamente';
    } else {
        $error = 'Error al eliminar artista';
    }
}

// Obtener artistas
$artistas = $conn->query("SELECT * FROM artistas ORDER BY nombre");

// Obtener conteos
$conteos = $conn->query("
    SELECT id_artista, COUNT(*) as albums, (SELECT COUNT(*) FROM canciones WHERE id_artista = albums.id_artista) as canciones
    FROM albumes albums
    GROUP BY id_artista
");
$conteosArray = [];
while ($c = $conteos->fetch_assoc()) {
    $conteosArray[$c['id_artista']] = $c;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Artistas - MusicStream</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-tipo="admin">
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-logo">
                <h2><i class="fas fa-music"></i> Music<span>Stream</span></h2>
            </div>
            <nav class="sidebar-nav" id="navbar-content"></nav>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Gestionar Artistas</h1>
                <button class="btn btn-secondary" onclick="mostrarModal('agregar-modal')">
                    <i class="fas fa-plus"></i> Nuevo Artista
                </button>
            </div>

            <?php if ($error): ?>
                <div class="error-message"><?php echo htmlspecialchars($error); ?></div>
            <?php endif; ?>

            <?php if ($success): ?>
                <div class="success-message"><?php echo htmlspecialchars($success); ?></div>
            <?php endif; ?>

            <div class="grid-cards">
                <?php while ($artista = $artistas->fetch_assoc()): ?>
                <div class="card">
                    <div class="card-image">
                        <img src="<?php echo $artista['imagen'] ?: 'https://via.placeholder.com/300x300/1DB954/fff?text=♪'; ?>" alt="<?php echo htmlspecialchars($artista['nombre']); ?>">
                        <div class="play-overlay">
                            <i class="fas fa-play"></i>
                        </div>
                    </div>
                    <h4><?php echo htmlspecialchars($artista['nombre']); ?></h4>
                    <p><?php echo htmlspecialchars($artista['genero_musical']); ?></p>
                    <p style="margin-top: 10px;">
                        <i class="fas fa-compact-disc"></i> <?php echo isset($conteosArray[$artista['id']]) ? $conteosArray[$artista['id']]['albums'] : 0; ?> álbumes
                        <br>
                        <i class="fas fa-music"></i> <?php echo isset($conteosArray[$artista['id']]) ? $conteosArray[$artista['id']]['canciones'] : 0; ?> canciones
                    </p>
                    <div style="margin-top: 15px; display: flex; gap: 10px;">
                        <button class="btn btn-secondary" onclick="editarArtista(<?php echo $artista['id']; ?>, '<?php echo addslashes($artista['nombre']); ?>', '<?php echo addslashes($artista['biografia']); ?>', '<?php echo addslashes($artista['genero_musical']); ?>', '<?php echo addslashes($artista['imagen']); ?>')">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-danger" onclick="eliminar(<?php echo $artista['id']; ?>, 'artista')">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
                <?php endwhile; ?>
            </div>
        </main>
    </div>

    <!-- Modal Agregar -->
    <div class="modal" id="agregar-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Nuevo Artista</h3>
                <button class="modal-close" onclick="cerrarModal('agregar-modal')">&times;</button>
            </div>
            <form method="POST">
                <input type="hidden" name="agregar" value="1">
                <div class="form-group">
                    <label>Nombre</label>
                    <input type="text" name="nombre" required>
                </div>
                <div class="form-group">
                    <label>Género Musical</label>
                    <input type="text" name="genero">
                </div>
                <div class="form-group">
                    <label>Biografía</label>
                    <textarea name="biografia" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label>URL de Imagen</label>
                    <input type="url" name="imagen" placeholder="https://...">
                </div>
                <button type="submit" class="btn-primary">Agregar</button>
            </form>
        </div>
    </div>

    <!-- Modal Editar -->
    <div class="modal" id="editar-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Editar Artista</h3>
                <button class="modal-close" onclick="cerrarModal('editar-modal')">&times;</button>
            </div>
            <form method="POST">
                <input type="hidden" name="editar" value="1">
                <input type="hidden" name="id" id="edit-id">
                <div class="form-group">
                    <label>Nombre</label>
                    <input type="text" name="nombre" id="edit-nombre" required>
                </div>
                <div class="form-group">
                    <label>Género Musical</label>
                    <input type="text" name="genero" id="edit-genero">
                </div>
                <div class="form-group">
                    <label>Biografía</label>
                    <textarea name="biografia" id="edit-biografia" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label>URL de Imagen</label>
                    <input type="url" name="imagen" id="edit-imagen">
                </div>
                <button type="submit" class="btn-primary">Guardar Cambios</button>
            </form>
        </div>
    </div>

    <script src="../js/main.js"></script>
    <script>
        function editarArtista(id, nombre, biografia, genero, imagen) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-nombre').value = nombre;
            document.getElementById('edit-biografia').value = biografia;
            document.getElementById('edit-genero').value = genero;
            document.getElementById('edit-imagen').value = imagen;
            mostrarModal('editar-modal');
        }
    </script>
</body>
</html>