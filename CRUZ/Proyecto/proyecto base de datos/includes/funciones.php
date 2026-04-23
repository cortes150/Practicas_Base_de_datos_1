<?php
// Funciones helper para el sistema de música

// Formatear duración
function formatearDuracion($duracion) {
    if (empty($duracion)) return "0:00";
    $parts = explode(':', $duracion);
    if (count($parts) === 2) {
        return ltrim($parts[0], '0') . ':' . $parts[1];
    }
    return "0:00";
}

// Formatear número grande
function formatearNumero($numero) {
    if ($numero >= 1000000) {
        return round($numero / 1000000, 1) . 'M';
    } elseif ($numero >= 1000) {
        return round($numero / 1000, 1) . 'K';
    }
    return $numero;
}

// Verificar si canción está en biblioteca
function estaEnBiblioteca($conn, $usuario_id, $cancion_id) {
    $stmt = $conn->prepare("SELECT id FROM biblioteca_usuario WHERE id_usuario = ? AND id_cancion = ?");
    $stmt->bind_param("ii", $usuario_id, $cancion_id);
    $stmt->execute();
    return $stmt->get_result()->num_rows > 0;
}

// Verificar si usuario sigue a artista
function sigueArtista($conn, $usuario_id, $artista_id) {
    $stmt = $conn->prepare("SELECT id FROM seguimientos WHERE id_usuario = ? AND id_artista = ?");
    $stmt->bind_param("ii", $usuario_id, $artista_id);
    $stmt->execute();
    return $stmt->get_result()->num_rows > 0;
}

// Obtener información del artista por ID de canción
function getArtistaPorCancion($conn, $cancion_id) {
    $stmt = $conn->prepare("
        SELECT a.* FROM artistas a
        INNER JOIN canciones c ON c.id_artista = a.id
        WHERE c.id = ?
    ");
    $stmt->bind_param("i", $cancion_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}

// Obtener álbum por ID de canción
function getAlbumPorCancion($conn, $cancion_id) {
    $stmt = $conn->prepare("
        SELECT al.* FROM albumes al
        INNER JOIN canciones c ON c.id_album = al.id
        WHERE c.id = ?
    ");
    $stmt->bind_param("i", $cancion_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}

// Generar HTML para cards de canciones
function renderizarCancion($conn, $cancion, $es_favorita = false, $es_admin = false) {
    $artista = getArtistaPorCancion($conn, $cancion['id']);
    $album = getAlbumPorCancion($conn, $cancion['id']);
    $imagen = $album['imagen'] ?: 'https://via.placeholder.com/300x300/1DB954/fff?text=♪';
    $duracion = formatearDuracion($cancion['duracion']);
    $reproducciones = formatearNumero($cancion['reproducciones']);
    $btn_favorito = $es_favorita ?
        '<button class="btn-favorito active" onclick="toggleFavorito(' . $cancion['id'] . ')"><i class="fas fa-heart"></i></button>' :
        '<button class="btn-favorito" onclick="toggleFavorito(' . $cancion['id'] . ')"><i class="far fa-heart"></i></button>';

    if ($es_admin) {
        $btn_favorito = '';
    }

    return '
    <div class="cancion-card" data-id="' . $cancion['id'] . '" onclick="reproducirCancion(' . $cancion['id'] . ', \'' . addslashes($cancion['titulo']) . '\', \'' . addslashes($artista['nombre']) . '\', \'' . $imagen . '\')">
        <div class="cancion-imagen">
            <img src="' . $imagen . '" alt="' . htmlspecialchars($cancion['titulo']) . '">
            <div class="play-overlay">
                <i class="fas fa-play"></i>
            </div>
        </div>
        <div class="cancion-info">
            <h4>' . htmlspecialchars($cancion['titulo']) . '</h4>
            <p>' . htmlspecialchars($artista['nombre']) . '</p>
            <span class="reproducciones"><i class="fas fa-play"></i> ' . $reproducciones . '</span>
        </div>
        <div class="cancion-acciones">
            <span class="duracion">' . $duracion . '</span>
            ' . $btn_favorito . '
        </div>
    </div>
    ';
}

// Generar HTML para cards de álbumes
function renderizarAlbum($album, $artista_nombre) {
    $imagen = $album['imagen'] ?: 'https://via.placeholder.com/300x300/1DB954/fff?text=♪';
    return '
    <div class="album-card" onclick="verAlbum(' . $album['id'] . ')">
        <div class="album-imagen">
            <img src="' . $imagen . '" alt="' . htmlspecialchars($album['titulo']) . '">
            <div class="play-overlay">
                <i class="fas fa-play"></i>
            </div>
        </div>
        <div class="album-info">
            <h4>' . htmlspecialchars($album['titulo']) . '</h4>
            <p>' . htmlspecialchars($artista_nombre) . '</p>
            <span class="ano">' . $album['ano_lanzamiento'] . '</span>
        </div>
    </div>
    ';
}

// Generar HTML para cards de artistas
function renderizarArtista($artista, $es_seguido = false, $es_admin = false) {
    $imagen = $artista['imagen'] ?: 'https://via.placeholder.com/300x300/1DB954/fff?text=♪';
    $btn_seguir = '';
    if (!$es_admin) {
        $btn_seguir = $es_seguido ?
            '<button class="btn-seguir active" onclick="event.stopPropagation(); toggleSeguir(' . $artista['id'] . ')"><i class="fas fa-check"></i> Siguiendo</button>' :
            '<button class="btn-seguir" onclick="event.stopPropagation(); toggleSeguir(' . $artista['id'] . ')"><i class="fas fa-plus"></i> Seguir</button>';
    }

    return '
    <div class="artista-card" onclick="verArtista(' . $artista['id'] . ')">
        <div class="artista-imagen">
            <img src="' . $imagen . '" alt="' . htmlspecialchars($artista['nombre']) . '">
        </div>
        <div class="artista-info">
            <h4>' . htmlspecialchars($artista['nombre']) . '</h4>
            <p>' . htmlspecialchars($artista['genero_musical']) . '</p>
            ' . $btn_seguir . '
        </div>
    </div>
    ';
}
?>