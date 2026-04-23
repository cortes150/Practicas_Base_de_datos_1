<?php
session_start();
require_once 'db.php';

header('Content-Type: application/json');

// Verificar sesión
if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(['success' => false, 'message' => 'No autorizado']);
    exit;
}

$usuario_id = $_SESSION['usuario_id'];

// Toggle favorito
if (isset($_GET['action']) && $_GET['action'] === 'toggleFavorito') {
    $cancion_id = $_GET['id'];

    // Verificar si ya está en favoritos
    $stmt = $conn->prepare("SELECT id FROM biblioteca_usuario WHERE id_usuario = ? AND id_cancion = ?");
    $stmt->bind_param("ii", $usuario_id, $cancion_id);
    $stmt->execute();
    $existe = $stmt->get_result()->num_rows > 0;

    if ($existe) {
        // Eliminar de favoritos
        $stmt = $conn->prepare("DELETE FROM biblioteca_usuario WHERE id_usuario = ? AND id_cancion = ?");
        $stmt->bind_param("ii", $usuario_id, $cancion_id);
        $stmt->execute();
        echo json_encode(['success' => true, 'agregado' => false]);
    } else {
        // Agregar a favoritos
        $stmt = $conn->prepare("INSERT INTO biblioteca_usuario (id_usuario, id_cancion) VALUES (?, ?)");
        $stmt->bind_param("ii", $usuario_id, $cancion_id);
        $stmt->execute();
        echo json_encode(['success' => true, 'agregado' => true]);
    }
    exit;
}

// Toggle seguir artista
if (isset($_GET['action']) && $_GET['action'] === 'toggleSeguir') {
    $artista_id = $_GET['id'];

    // Verificar si ya sigue
    $stmt = $conn->prepare("SELECT id FROM seguimientos WHERE id_usuario = ? AND id_artista = ?");
    $stmt->bind_param("ii", $usuario_id, $artista_id);
    $stmt->execute();
    $existe = $stmt->get_result()->num_rows > 0;

    if ($existe) {
        // Dejar de seguir
        $stmt = $conn->prepare("DELETE FROM seguimientos WHERE id_usuario = ? AND id_artista = ?");
        $stmt->bind_param("ii", $usuario_id, $artista_id);
        $stmt->execute();
        echo json_encode(['success' => true, 'siguiendo' => false]);
    } else {
        // Seguir
        $stmt = $conn->prepare("INSERT INTO seguimientos (id_usuario, id_artista) VALUES (?, ?)");
        $stmt->bind_param("ii", $usuario_id, $artista_id);
        $stmt->execute();
        echo json_encode(['success' => true, 'siguiendo' => true]);
    }
    exit;
}

// Registrar reproducción
if (isset($_GET['action']) && $_GET['action'] === 'registrarReproduccion') {
    $cancion_id = $_GET['id'];

    $stmt = $conn->prepare("UPDATE canciones SET reproducciones = reproducciones + 1 WHERE id = ?");
    $stmt->bind_param("i", $cancion_id);
    $stmt->execute();

    echo json_encode(['success' => true]);
    exit;
}

// Crear playlist
if (isset($_GET['action']) && $_GET['action'] === 'crearPlaylist') {
    $nombre = $_GET['nombre'];
    $descripcion = $_GET['descripcion'];
    $publica = $_GET['publica'] === '1' ? 1 : 0;

    $stmt = $conn->prepare("INSERT INTO playlists (nombre, id_usuario, descripcion, es_publica) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("sisi", $nombre, $usuario_id, $descripcion, $publica);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'id' => $stmt->insert_id]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error al crear playlist']);
    }
    exit;
}

// Guardar en playlist
if (isset($_GET['action']) && $_GET['action'] === 'guardarEnPlaylist') {
    $cancion_id = $_GET['cancion'];
    $playlist_id = $_GET['playlist'];

    // Verificar que la playlist es del usuario
    $stmt = $conn->prepare("SELECT id FROM playlists WHERE id = ? AND id_usuario = ?");
    $stmt->bind_param("ii", $playlist_id, $usuario_id);
    $stmt->execute();

    if ($stmt->get_result()->num_rows === 0) {
        echo json_encode(['success' => false, 'message' => 'No tienes acceso a esta playlist']);
        exit;
    }

    // Verificar si ya está en la playlist
    $stmt = $conn->prepare("SELECT id FROM playlist_canciones WHERE id_playlist = ? AND id_cancion = ?");
    $stmt->bind_param("ii", $playlist_id, $cancion_id);
    $stmt->execute();

    if ($stmt->get_result()->num_rows > 0) {
        echo json_encode(['success' => false, 'message' => 'La canción ya está en la playlist']);
        exit;
    }

    // Agregar a playlist
    $stmt = $conn->prepare("INSERT INTO playlist_canciones (id_playlist, id_cancion) VALUES (?, ?)");
    $stmt->bind_param("ii", $playlist_id, $cancion_id);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error al agregar canción']);
    }
    exit;
}

// Eliminar de playlist
if (isset($_GET['action']) && $_GET['action'] === 'eliminarDePlaylist') {
    $playlist_id = $_GET['playlist'];
    $cancion_id = $_GET['cancion'];

    // Verificar que la playlist es del usuario
    $stmt = $conn->prepare("SELECT id FROM playlists WHERE id = ? AND id_usuario = ?");
    $stmt->bind_param("ii", $playlist_id, $usuario_id);
    $stmt->execute();

    if ($stmt->get_result()->num_rows === 0) {
        echo json_encode(['success' => false, 'message' => 'No tienes acceso']);
        exit;
    }

    // Eliminar
    $stmt = $conn->prepare("DELETE FROM playlist_canciones WHERE id_playlist = ? AND id_cancion = ?");
    $stmt->bind_param("ii", $playlist_id, $cancion_id);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error']);
    }
    exit;
}

// Eliminar playlist
if (isset($_GET['action']) && $_GET['action'] === 'eliminarPlaylist') {
    $playlist_id = $_GET['id'];

    $stmt = $conn->prepare("DELETE FROM playlists WHERE id = ? AND id_usuario = ?");
    $stmt->bind_param("ii", $playlist_id, $usuario_id);

    if ($stmt->execute()) {
        header('Location: ../normal/playlists.php');
    } else {
        echo json_encode(['success' => false, 'message' => 'Error al eliminar']);
    }
    exit;
}

// Eliminar (admin)
if (isset($_GET['action']) && $_GET['action'] === 'eliminar') {
    $tipo = $_GET['tipo'];
    $id = $_GET['id'];

    // Verificar que es admin
    if ($_SESSION['tipo_usuario'] !== 'admin') {
        echo json_encode(['success' => false, 'message' => 'No autorizado']);
        exit;
    }

    switch ($tipo) {
        case 'artista':
            $stmt = $conn->prepare("DELETE FROM artistas WHERE id = ?");
            break;
        case 'álbum':
            $stmt = $conn->prepare("DELETE FROM albumes WHERE id = ?");
            break;
        case 'canción':
            $stmt = $conn->prepare("DELETE FROM canciones WHERE id = ?");
            break;
        case 'usuario':
            $stmt = $conn->prepare("DELETE FROM usuarios WHERE id = ?");
            break;
        default:
            echo json_encode(['success' => false, 'message' => 'Tipo inválido']);
            exit;
    }

    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error al eliminar']);
    }
    exit;
}

echo json_encode(['success' => false, 'message' => 'Acción no válida']);
?>