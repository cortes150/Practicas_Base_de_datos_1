<?php
session_start();
require_once '../includes/db.php';
require_once '../includes/funciones.php';

verificarSesion();
verificarTipo('admin');

// Obtener estadísticas
$totalArtistas = $conn->query("SELECT COUNT(*) as total FROM artistas")->fetch_assoc()['total'];
$totalAlbumes = $conn->query("SELECT COUNT(*) as total FROM albumes")->fetch_assoc()['total'];
$totalCanciones = $conn->query("SELECT COUNT(*) as total FROM canciones")->fetch_assoc()['total'];
$totalUsuarios = $conn->query("SELECT COUNT(*) as total FROM usuarios")->fetch_assoc()['total'];
$totalPlaylists = $conn->query("SELECT COUNT(*) as total FROM playlists")->fetch_assoc()['total'];
$totalReproducciones = $conn->query("SELECT SUM(reproducciones) as total FROM canciones")->fetch_assoc()['total'];

// Canciones por artista
$cancionesPorArtista = $conn->query("
    SELECT a.nombre, COUNT(c.id) as total
    FROM artistas a
    LEFT JOIN canciones c ON c.id_artista = a.id
    GROUP BY a.id
    ORDER BY total DESC
    LIMIT 10
");

// Álbumes por artista
$albumesPorArtista = $conn->query("
    SELECT a.nombre, COUNT(al.id) as total
    FROM artistas a
    LEFT JOIN albumes al ON al.id_artista = a.id
    GROUP BY a.id
    ORDER BY total DESC
    LIMIT 10
");

// Playlists por usuario
$playlistsPorUsuario = $conn->query("
    SELECT u.nombre, COUNT(p.id) as total
    FROM usuarios u
    LEFT JOIN playlists p ON p.id_usuario = u.id
    WHERE u.tipo = 'normal'
    GROUP BY u.id
    ORDER BY total DESC
    LIMIT 10
");

// Canciones guardadas por usuario
$cancionesPorUsuario = $conn->query("
    SELECT u.nombre, COUNT(b.id) as total
    FROM usuarios u
    LEFT JOIN biblioteca_usuario b ON b.id_usuario = u.id
    WHERE u.tipo = 'normal'
    GROUP BY u.id
    ORDER BY total DESC
    LIMIT 10
");

// Usuarios por artista seguido
$seguidoresPorArtista = $conn->query("
    SELECT a.nombre, COUNT(s.id) as total
    FROM artistas a
    LEFT JOIN seguimientos s ON s.id_artista = a.id
    GROUP BY a.id
    ORDER BY total DESC
    LIMIT 10
");

// Top 10 canciones más reproducidas
$topCanciones = $conn->query("
    SELECT c.titulo, a.nombre as artista, c.reproducciones
    FROM canciones c
    INNER JOIN artistas a ON a.id = c.id_artista
    ORDER BY c.reproducciones DESC
    LIMIT 10
");

// Top 10 artistas más seguidos
$topArtistas = $conn->query("
    SELECT a.nombre, COUNT(s.id) as seguidores
    FROM artistas a
    LEFT JOIN seguimientos s ON s.id_artista = a.id
    GROUP BY a.id
    ORDER BY seguidores DESC
    LIMIT 10
");

// Canciones por álbum
$cancionesPorAlbum = $conn->query("
    SELECT al.titulo, a.nombre as artista, COUNT(c.id) as total
    FROM albumes al
    INNER JOIN artistas a ON a.id = al.id_artista
    LEFT JOIN canciones c ON c.id_album = al.id
    GROUP BY al.id
    ORDER BY total DESC
    LIMIT 10
");

// Últimos usuarios registrados
$ultimosUsuarios = $conn->query("
    SELECT nombre, email, tipo, fecha_creacion
    FROM usuarios
    ORDER BY fecha_creacion DESC
    LIMIT 10
");

// Ganancias simuladas ($0.001 por reproducción)
$ganancias = $totalReproducciones * 0.001;
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - MusicStream</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body data-tipo="admin">
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-logo">
                <h2><i class="fas fa-music"></i> Music<span>Stream</span></h2>
            </div>
            <nav class="sidebar-nav" id="navbar-content">
                <!-- Se carga con JS -->
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Dashboard Administrador</h1>
                <div class="user-menu">
                    <span><?php echo htmlspecialchars($_SESSION['nombre_usuario']); ?></span>
                    <div class="user-dropdown">
                        <div class="user-avatar" onclick="toggleDropdown()">
                            <?php echo strtoupper($_SESSION['nombre_usuario'][0]); ?>
                        </div>
                        <div class="dropdown-menu">
                            <a href="../index.php?logout=1" class="dropdown-item logout">
                                <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Generales -->
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-users"></i>
                    <h3><?php echo formatearNumero($totalArtistas); ?></h3>
                    <p>Artistas</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-compact-disc"></i>
                    <h3><?php echo formatearNumero($totalAlbumes); ?></h3>
                    <p>Álbumes</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-music"></i>
                    <h3><?php echo formatearNumero($totalCanciones); ?></h3>
                    <p>Canciones</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-user"></i>
                    <h3><?php echo formatearNumero($totalUsuarios); ?></h3>
                    <p>Usuarios</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-list"></i>
                    <h3><?php echo formatearNumero($totalPlaylists); ?></h3>
                    <p>Playlists</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-play"></i>
                    <h3><?php echo formatearNumero($totalReproducciones); ?></h3>
                    <p>Reproducciones</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-dollar-sign"></i>
                    <h3>$<?php echo formatearNumero($ganancias); ?></h3>
                    <p>Ganancias (estimado)</p>
                </div>
            </div>

            <!-- Tabs para más reportes -->
            <div class="tabs">
                <button class="tab active" onclick="switchTab('artistas')">Artistas</button>
                <button class="tab" onclick="switchTab('usuarios')">Usuarios</button>
                <button class="tab" onclick="switchTab('top')">Top 10</button>
            </div>

            <!-- Contenido Artistas -->
            <div class="tab-content active" id="artistas-content">
                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Canciones por Artista</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Artista</th>
                                <th>Canciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while ($row = $cancionesPorArtista->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['nombre']); ?></td>
                                <td><?php echo $row['total']; ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>

                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Álbumes por Artista</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Artista</th>
                                <th>Álbumes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while ($row = $albumesPorArtista->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['nombre']); ?></td>
                                <td><?php echo $row['total']; ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>

                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Canciones por Álbum</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Álbum</th>
                                <th>Artista</th>
                                <th>Canciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while ($row = $cancionesPorAlbum->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['titulo']); ?></td>
                                <td><?php echo htmlspecialchars($row['artista']); ?></td>
                                <td><?php echo $row['total']; ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>

                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Seguidores por Artista</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Artista</th>
                                <th>Seguidores</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while ($row = $seguidoresPorArtista->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['nombre']); ?></td>
                                <td><?php echo $row['total']; ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Contenido Usuarios -->
            <div class="tab-content" id="usuarios-content">
                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Playlists por Usuario</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Usuario</th>
                                <th>Playlists Creadas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while ($row = $playlistsPorUsuario->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['nombre']); ?></td>
                                <td><?php echo $row['total']; ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>

                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Canciones Guardadas por Usuario</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Usuario</th>
                                <th>Canciones Favoritas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while ($row = $cancionesPorUsuario->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['nombre']); ?></td>
                                <td><?php echo $row['total']; ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>

                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Últimos Usuarios Registrados</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Email</th>
                                <th>Tipo</th>
                                <th>Fecha</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while ($row = $ultimosUsuarios->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['nombre']); ?></td>
                                <td><?php echo htmlspecialchars($row['email']); ?></td>
                                <td><?php echo $row['tipo']; ?></td>
                                <td><?php echo date('d/m/Y', strtotime($row['fecha_creacion'])); ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Contenido Top 10 -->
            <div class="tab-content" id="top-content">
                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Top 10 Canciones Más Reproducidas</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Canción</th>
                                <th>Artista</th>
                                <th>Reproducciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $i = 1; while ($row = $topCanciones->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo $i++; ?></td>
                                <td><?php echo htmlspecialchars($row['titulo']); ?></td>
                                <td><?php echo htmlspecialchars($row['artista']); ?></td>
                                <td><?php echo formatearNumero($row['reproducciones']); ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>

                <div class="section">
                    <h2 class="section-title" style="margin-bottom: 20px;">Top 10 Artistas Más Seguidos</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Artista</th>
                                <th>Seguidores</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $i = 1; while ($row = $topArtistas->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo $i++; ?></td>
                                <td><?php echo htmlspecialchars($row['nombre']); ?></td>
                                <td><?php echo $row['seguidores']; ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <script src="../js/main.js"></script>
</body>
</html>