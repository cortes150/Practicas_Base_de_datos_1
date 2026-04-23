<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('admin');

$error = '';
$success = '';

// Agregar álbum
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['agregar'])) {
    $titulo = trim($_POST['titulo']);
    $id_artista = $_POST['id_artista'];
    $ano = $_POST['ano'];
    $imagen = trim($_POST['imagen']);

    if (empty($titulo) || empty($id_artista)) {
        $error = 'El título y artista son requeridos';
    } else {
        $stmt = $conn->prepare("INSERT INTO albumes (titulo, id_artista, ano_lanzamiento, imagen) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("siis", $titulo, $id_artista, $ano, $imagen);

        if ($stmt->execute()) {
            $success = 'Álbum agregado correctamente';
        } else {
            $error = 'Error al agregar álbum';
        }
    }
}

// Editar álbum
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['editar'])) {
    $id = $_POST['id'];
    $titulo = trim($_POST['titulo']);
    $id_artista = $_POST['id_artista'];
    $ano = $_POST['ano'];
    $imagen = trim($_POST['imagen']);

    $stmt = $conn->prepare("UPDATE albumes SET titulo = ?, id_artista = ?, ano_lanzamiento = ?, imagen = ? WHERE id = ?");
    $stmt->bind_param("siisi", $titulo, $id_artista, $ano, $imagen, $id);

    if ($stmt->execute()) {
        $success = 'Álbum actualizado correctamente';
    } else {
        $error = 'Error al actualizar álbum';
    }
}

// Eliminar álbum
if (isset($_GET['eliminar'])) {
    $id = $_GET['eliminar'];
    $stmt = $conn->prepare("DELETE FROM albumes WHERE id = ?");
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        $success = 'Álbum eliminado correctamente';
    } else {
        $error = 'Error al eliminar álbum';
    }
}

// Obtener álbumes
$albumes = $conn->query("
    SELECT al.*, a.nombre as artista_nombre
    FROM albumes al
    INNER JOIN artistas a ON a.id = al.id_artista
    ORDER BY al.titulo
");

// Obtener artistas para el select
$artistas = $conn->query("SELECT id, nombre FROM artistas ORDER BY nombre");

// Obtener conteo de canciones por álbum
$conteos = $conn->query("
    SELECT id_album, COUNT(*) as total
    FROM canciones
    GROUP BY id_album
");
$conteosArray = [];
while ($c = $conteos->fetch_assoc()) {
    $conteosArray[$c['id_album']] = $c['total'];
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Álbumes - MusicStream</title>
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
                <h1 class="page-title">Gestionar Álbumes</h1>
                <button class="btn btn-secondary" onclick="mostrarModal('agregar-modal')">
                    <i class="fas fa-plus"></i> Nuevo Álbum
                </button>
            </div>

            <?php if ($error): ?>
                <div class="error-message"><?php echo htmlspecialchars($error); ?></div>
            <?php endif; ?>

            <?php if ($success): ?>
                <div class="success-message"><?php echo htmlspecialchars($success); ?></div>
            <?php endif; ?>

            <div class="grid-cards">
                <?php while ($album = $albumes->fetch_assoc()): ?>
                <div class="card">
                    <div class="card-image">
                        <img src="<?php echo $album['imagen'] ?: 'https://via.placeholder.com/300x300/1DB954/fff?text=♪'; ?>" alt="<?php echo htmlspecialchars($album['titulo']); ?>">
                        <div class="play-overlay">
                            <i class="fas fa-play"></i>
                        </div>
                    </div>
                    <h4><?php echo htmlspecialchars($album['titulo']); ?></h4>
                    <p><?php echo htmlspecialchars($album['artista_nombre']); ?></p>
                    <p style="margin-top: 10px;">
                        <i class="fas fa-calendar"></i> <?php echo $album['ano_lanzamiento']; ?>
                        <br>
                        <i class="fas fa-music"></i> <?php echo isset($conteosArray[$album['id']]) ? $conteosArray[$album['id']] : 0; ?> canciones
                    </p>
                    <div style="margin-top: 15px; display: flex; gap: 10px;">
                        <button class="btn btn-secondary" onclick="editarAlbum(<?php echo $album['id']; ?>, '<?php echo addslashes($album['titulo']); ?>', <?php echo $album['id_artista']; ?>, '<?php echo $album['ano_lanzamiento']; ?>', '<?php echo addslashes($album['imagen']); ?>')">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-danger" onclick="eliminar(<?php echo $album['id']; ?>, 'álbum')">
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
                <h3>Nuevo Álbum</h3>
                <button class="modal-close" onclick="cerrarModal('agregar-modal')">&times;</button>
            </div>
            <form method="POST">
                <input type="hidden" name="agregar" value="1">
                <div class="form-group">
                    <label>Título</label>
                    <input type="text" name="titulo" required>
                </div>
                <div class="form-group">
                    <label>Artista</label>
                    <select name="id_artista" required>
                        <option value="">Seleccionar artista</option>
                        <?php while ($artista = $artistas->fetch_assoc()): ?>
                        <option value="<?php echo $artista['id']; ?>"><?php echo htmlspecialchars($artista['nombre']); ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label>Año de Lanzamiento</label>
                    <input type="number" name="ano" min="1900" max="2030" value="2024">
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
                <h3>Editar Álbum</h3>
                <button class="modal-close" onclick="cerrarModal('editar-modal')">&times;</button>
            </div>
            <form method="POST">
                <input type="hidden" name="editar" value="1">
                <input type="hidden" name="id" id="edit-id">
                <div class="form-group">
                    <label>Título</label>
                    <input type="text" name="titulo" id="edit-titulo" required>
                </div>
                <div class="form-group">
                    <label>Artista</label>
                    <select name="id_artista" id="edit-artista" required>
                        <?php
                        $artistas = $conn->query("SELECT id, nombre FROM artistas ORDER BY nombre");
                        while ($artista = $artistas->fetch_assoc()): ?>
                        <option value="<?php echo $artista['id']; ?>"><?php echo htmlspecialchars($artista['nombre']); ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label>Año de Lanzamiento</label>
                    <input type="number" name="ano" id="edit-ano" min="1900" max="2030">
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
        function editarAlbum(id, titulo, id_artista, ano, imagen) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-titulo').value = titulo;
            document.getElementById('edit-artista').value = id_artista;
            document.getElementById('edit-ano').value = ano;
            document.getElementById('edit-imagen').value = imagen;
            mostrarModal('editar-modal');
        }
    </script>
</body>
</html>