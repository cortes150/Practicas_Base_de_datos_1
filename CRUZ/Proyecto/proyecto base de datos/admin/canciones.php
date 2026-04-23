<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('admin');

$error = '';
$success = '';

// Agregar canción
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['agregar'])) {
    $titulo = trim($_POST['titulo']);
    $id_album = $_POST['id_album'];
    $id_artista = $_POST['id_artista'];
    $duracion = $_POST['duracion'];
    $genero = trim($_POST['genero']);

    if (empty($titulo) || empty($id_album)) {
        $error = 'El título y álbum son requeridos';
    } else {
        $stmt = $conn->prepare("INSERT INTO canciones (titulo, id_album, id_artista, duracion, genero) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("siiss", $titulo, $id_album, $id_artista, $duracion, $genero);

        if ($stmt->execute()) {
            $success = 'Canción agregada correctamente';
        } else {
            $error = 'Error al agregar canción';
        }
    }
}

// Editar canción
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['editar'])) {
    $id = $_POST['id'];
    $titulo = trim($_POST['titulo']);
    $id_album = $_POST['id_album'];
    $id_artista = $_POST['id_artista'];
    $duracion = $_POST['duracion'];
    $genero = trim($_POST['genero']);
    $reproducciones = $_POST['reproducciones'];

    $stmt = $conn->prepare("UPDATE canciones SET titulo = ?, id_album = ?, id_artista = ?, duracion = ?, genero = ?, reproducciones = ? WHERE id = ?");
    $stmt->bind_param("siissii", $titulo, $id_album, $id_artista, $duracion, $genero, $reproducciones, $id);

    if ($stmt->execute()) {
        $success = 'Canción actualizada correctamente';
    } else {
        $error = 'Error al actualizar canción';
    }
}

// Eliminar canción
if (isset($_GET['eliminar'])) {
    $id = $_GET['eliminar'];
    $stmt = $conn->prepare("DELETE FROM canciones WHERE id = ?");
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        $success = 'Canción eliminada correctamente';
    } else {
        $error = 'Error al eliminar canción';
    }
}

// Obtener canciones
$canciones = $conn->query("
    SELECT c.*, al.titulo as album_titulo, a.nombre as artista_nombre
    FROM canciones c
    INNER JOIN albumes al ON al.id = c.id_album
    INNER JOIN artistas a ON a.id = c.id_artista
    ORDER BY c.titulo
");

// Obtener álbumes para el select
$albumes = $conn->query("SELECT id, titulo, id_artista FROM albumes ORDER BY titulo");

// Obtener artistas
$artistas = $conn->query("SELECT id, nombre FROM artistas ORDER BY nombre");
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Canciones - MusicStream</title>
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
                <h1 class="page-title">Gestionar Canciones</h1>
                <button class="btn btn-secondary" onclick="mostrarModal('agregar-modal')">
                    <i class="fas fa-plus"></i> Nueva Canción
                </button>
            </div>

            <?php if ($error): ?>
                <div class="error-message"><?php echo htmlspecialchars($error); ?></div>
            <?php endif; ?>

            <?php if ($success): ?>
                <div class="success-message"><?php echo htmlspecialchars($success); ?></div>
            <?php endif; ?>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Álbum</th>
                        <th>Artista</th>
                        <th>Duración</th>
                        <th>Reproducciones</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($cancion = $canciones->fetch_assoc()): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($cancion['titulo']); ?></td>
                        <td><?php echo htmlspecialchars($cancion['album_titulo']); ?></td>
                        <td><?php echo htmlspecialchars($cancion['artista_nombre']); ?></td>
                        <td><?php echo formatearDuracion($cancion['duracion']); ?></td>
                        <td><?php echo formatearNumero($cancion['reproducciones']); ?></td>
                        <td>
                            <button class="btn btn-secondary" onclick="editarCancion(<?php echo $cancion['id']; ?>, '<?php echo addslashes($cancion['titulo']); ?>', <?php echo $cancion['id_album']; ?>, <?php echo $cancion['id_artista']; ?>, '<?php echo $cancion['duracion']; ?>', '<?php echo addslashes($cancion['genero']); ?>', <?php echo $cancion['reproducciones']; ?>)">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-danger" onclick="eliminar(<?php echo $cancion['id']; ?>, 'canción')">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </main>
    </div>

    <!-- Modal Agregar -->
    <div class="modal" id="agregar-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Nueva Canción</h3>
                <button class="modal-close" onclick="cerrarModal('agregar-modal')">&times;</button>
            </div>
            <form method="POST">
                <input type="hidden" name="agregar" value="1">
                <div class="form-group">
                    <label>Título</label>
                    <input type="text" name="titulo" required>
                </div>
                <div class="form-group">
                    <label>Álbum</label>
                    <select name="id_album" required onchange="actualizarArtista(this.value)">
                        <option value="">Seleccionar álbum</option>
                        <?php while ($album = $albumes->fetch_assoc()): ?>
                        <option value="<?php echo $album['id']; ?>" data-artista="<?php echo $album['id_artista']; ?>">
                            <?php echo htmlspecialchars($album['titulo']); ?>
                        </option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label>Artista</label>
                    <select name="id_artista" required id="select-artista">
                        <option value="">Seleccionar artista</option>
                        <?php while ($artista = $artistas->fetch_assoc()): ?>
                        <option value="<?php echo $artista['id']; ?>"><?php echo htmlspecialchars($artista['nombre']); ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label>Duración (mm:ss)</label>
                    <input type="text" name="duracion" placeholder="03:30" value="03:00">
                </div>
                <div class="form-group">
                    <label>Género</label>
                    <input type="text" name="genero" placeholder="Pop">
                </div>
                <button type="submit" class="btn-primary">Agregar</button>
            </form>
        </div>
    </div>

    <!-- Modal Editar -->
    <div class="modal" id="editar-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Editar Canción</h3>
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
                    <label>Álbum</label>
                    <select name="id_album" id="edit-album" required>
                        <?php
                        $albumes = $conn->query("SELECT id, titulo FROM albumes ORDER BY titulo");
                        while ($album = $albumes->fetch_assoc()): ?>
                        <option value="<?php echo $album['id']; ?>"><?php echo htmlspecialchars($album['titulo']); ?></option>
                        <?php endwhile; ?>
                    </select>
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
                    <label>Duración (mm:ss)</label>
                    <input type="text" name="duracion" id="edit-duracion">
                </div>
                <div class="form-group">
                    <label>Género</label>
                    <input type="text" name="genero" id="edit-genero">
                </div>
                <div class="form-group">
                    <label>Reproducciones</label>
                    <input type="number" name="reproducciones" id="edit-reproducciones" min="0">
                </div>
                <button type="submit" class="btn-primary">Guardar Cambios</button>
            </form>
        </div>
    </div>

    <script src="../js/main.js"></script>
    <script>
        function actualizarArtista(albumId) {
            const select = document.querySelector('#agregar-modal select[name="id_album"]');
            const option = select.options[select.selectedIndex];
            const artistaId = option.dataset.artista;
            if (artistaId) {
                document.getElementById('select-artista').value = artistaId;
            }
        }

        function editarCancion(id, titulo, id_album, id_artista, duracion, genero, reproducciones) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-titulo').value = titulo;
            document.getElementById('edit-album').value = id_album;
            document.getElementById('edit-artista').value = id_artista;
            document.getElementById('edit-duracion').value = duracion;
            document.getElementById('edit-genero').value = genero;
            document.getElementById('edit-reproducciones').value = reproducciones;
            mostrarModal('editar-modal');
        }
    </script>
</body>
</html>