<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('admin');

$error = '';
$success = '';

// Agregar usuario
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['agregar'])) {
    $nombre = trim($_POST['nombre']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $tipo = $_POST['tipo'];

    if (empty($nombre) || empty($email) || empty($password)) {
        $error = 'Todos los campos son requeridos';
    } else {
        // Verificar si email ya existe
        $stmt = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();

        if ($stmt->get_result()->num_rows > 0) {
            $error = 'El email ya está registrado';
        } else {
            $password_hash = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $conn->prepare("INSERT INTO usuarios (nombre, email, password, tipo) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("ssss", $nombre, $email, $password_hash, $tipo);

            if ($stmt->execute()) {
                $success = 'Usuario agregado correctamente';
            } else {
                $error = 'Error al agregar usuario';
            }
        }
    }
}

// Editar usuario
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['editar'])) {
    $id = $_POST['id'];
    $nombre = trim($_POST['nombre']);
    $email = trim($_POST['email']);
    $tipo = $_POST['tipo'];
    $password = $_POST['password'];

    if (!empty($password)) {
        $password_hash = password_hash($password, PASSWORD_DEFAULT);
        $stmt = $conn->prepare("UPDATE usuarios SET nombre = ?, email = ?, password = ?, tipo = ? WHERE id = ?");
        $stmt->bind_param("ssssi", $nombre, $email, $password_hash, $tipo, $id);
    } else {
        $stmt = $conn->prepare("UPDATE usuarios SET nombre = ?, email = ?, tipo = ? WHERE id = ?");
        $stmt->bind_param("sssi", $nombre, $email, $tipo, $id);
    }

    if ($stmt->execute()) {
        $success = 'Usuario actualizado correctamente';
    } else {
        $error = 'Error al actualizar usuario';
    }
}

// Eliminar usuario
if (isset($_GET['eliminar'])) {
    $id = $_GET['eliminar'];

    if ($id == $_SESSION['usuario_id']) {
        $error = 'No puedes eliminar tu propia cuenta';
    } else {
        $stmt = $conn->prepare("DELETE FROM usuarios WHERE id = ?");
        $stmt->bind_param("i", $id);

        if ($stmt->execute()) {
            $success = 'Usuario eliminado correctamente';
        } else {
            $error = 'Error al eliminar usuario';
        }
    }
}

// Obtener usuarios
$usuarios = $conn->query("SELECT * FROM usuarios ORDER BY fecha_creacion DESC");

// Obtener estadísticas por usuario
$stats = $conn->query("
    SELECT id_usuario,
           (SELECT COUNT(*) FROM playlists WHERE id_usuario = stats.id_usuario) as playlists,
           (SELECT COUNT(*) FROM biblioteca_usuario WHERE id_usuario = stats.id_usuario) as canciones
    FROM usuarios us
    LEFT JOIN biblioteca_usuario stats ON stats.id_usuario = us.id
    GROUP BY us.id
");
$statsArray = [];
while ($s = $stats->fetch_assoc()) {
    $statsArray[$s['id_usuario']] = $s;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Usuarios - MusicStream</title>
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
                <h1 class="page-title">Gestionar Usuarios</h1>
                <button class="btn btn-secondary" onclick="mostrarModal('agregar-modal')">
                    <i class="fas fa-plus"></i> Nuevo Usuario
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
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Tipo</th>
                        <th>Playlists</th>
                        <th>Canciones Guardadas</th>
                        <th>Fecha Registro</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($usuario = $usuarios->fetch_assoc()): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($usuario['nombre']); ?></td>
                        <td><?php echo htmlspecialchars($usuario['email']); ?></td>
                        <td>
                            <span style="color: <?php echo $usuario['tipo'] === 'admin' ? 'var(--verde-spotify)' : 'var(--text-gray)'; ?>">
                                <?php echo ucfirst($usuario['tipo']); ?>
                            </span>
                        </td>
                        <td><?php echo isset($statsArray[$usuario['id']]) ? $statsArray[$usuario['id']]['playlists'] : 0; ?></td>
                        <td><?php echo isset($statsArray[$usuario['id']]) ? $statsArray[$usuario['id']]['canciones'] : 0; ?></td>
                        <td><?php echo date('d/m/Y', strtotime($usuario['fecha_creacion'])); ?></td>
                        <td>
                            <button class="btn btn-secondary" onclick="editarUsuario(<?php echo $usuario['id']; ?>, '<?php echo addslashes($usuario['nombre']); ?>', '<?php echo $usuario['email']; ?>', '<?php echo $usuario['tipo']; ?>')">
                                <i class="fas fa-edit"></i>
                            </button>
                            <?php if ($usuario['id'] != $_SESSION['usuario_id']): ?>
                            <button class="btn btn-danger" onclick="eliminar(<?php echo $usuario['id']; ?>, 'usuario')">
                                <i class="fas fa-trash"></i>
                            </button>
                            <?php endif; ?>
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
                <h3>Nuevo Usuario</h3>
                <button class="modal-close" onclick="cerrarModal('agregar-modal')">&times;</button>
            </div>
            <form method="POST">
                <input type="hidden" name="agregar" value="1">
                <div class="form-group">
                    <label>Nombre</label>
                    <input type="text" name="nombre" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required>
                </div>
                <div class="form-group">
                    <label>Contraseña</label>
                    <input type="password" name="password" required>
                </div>
                <div class="form-group">
                    <label>Tipo</label>
                    <select name="tipo">
                        <option value="normal">Normal</option>
                        <option value="admin">Administrador</option>
                    </select>
                </div>
                <button type="submit" class="btn-primary">Agregar</button>
            </form>
        </div>
    </div>

    <!-- Modal Editar -->
    <div class="modal" id="editar-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Editar Usuario</h3>
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
                    <label>Email</label>
                    <input type="email" name="email" id="edit-email" required>
                </div>
                <div class="form-group">
                    <label>Nueva Contraseña (dejar vacío para mantener)</label>
                    <input type="password" name="password">
                </div>
                <div class="form-group">
                    <label>Tipo</label>
                    <select name="tipo" id="edit-tipo">
                        <option value="normal">Normal</option>
                        <option value="admin">Administrador</option>
                    </select>
                </div>
                <button type="submit" class="btn-primary">Guardar Cambios</button>
            </form>
        </div>
    </div>

    <script src="../js/main.js"></script>
    <script>
        function editarUsuario(id, nombre, email, tipo) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-nombre').value = nombre;
            document.getElementById('edit-email').value = email;
            document.getElementById('edit-tipo').value = tipo;
            mostrarModal('editar-modal');
        }
    </script>
</body>
</html>