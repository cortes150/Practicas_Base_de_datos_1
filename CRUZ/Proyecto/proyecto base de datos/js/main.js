// MusicStream - JavaScript Principal

// Variables globales
let cancionActual = null;
let estaReproduciendo = false;
let progreso = 0;
let intervaloProgreso = null;

// Inicializar
document.addEventListener('DOMContentLoaded', function() {
    cargarNavbar();
    inicializarPlayer();
});

// Cargar navbar según tipo de usuario
function cargarNavbar() {
    const tipoUsuario = document.body.dataset.tipo;
    if (!tipoUsuario) return;

    const navbar = document.getElementById('navbar-content');
    if (!navbar) return;

    if (tipoUsuario === 'admin') {
        navbar.innerHTML = `
            <a href="../admin/index.php" class="nav-item active">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard</span>
            </a>
            <a href="../admin/artistas.php" class="nav-item">
                <i class="fas fa-users"></i>
                <span>Artistas</span>
            </a>
            <a href="../admin/albumes.php" class="nav-item">
                <i class="fas fa-compact-disc"></i>
                <span>Álbumes</span>
            </a>
            <a href="../admin/canciones.php" class="nav-item">
                <i class="fas fa-music"></i>
                <span>Canciones</span>
            </a>
            <a href="../admin/usuarios.php" class="nav-item">
                <i class="fas fa-user"></i>
                <span>Usuarios</span>
            </a>
        `;
    } else {
        navbar.innerHTML = `
            <a href="../normal/home.php" class="nav-item active">
                <i class="fas fa-home"></i>
                <span>Inicio</span>
            </a>
            <a href="../normal/buscar.php" class="nav-item">
                <i class="fas fa-search"></i>
                <span>Buscar</span>
            </a>
            <a href="../normal/biblioteca.php" class="nav-item">
                <i class="fas fa-heart"></i>
                <span>Tu Biblioteca</span>
            </a>
            <div class="sidebar-section">
                <h3>Tu Música</h3>
                <a href="../normal/playlists.php" class="nav-item">
                    <i class="fas fa-list"></i>
                    <span>Playlists</span>
                </a>
                <a href="../normal/artistas.php" class="nav-item">
                    <i class="fas fa-users"></i>
                    <span>Artistas</span>
                </a>
            </div>
        `;
    }
}

// Inicializar reproductor
function inicializarPlayer() {
    const btnPlay = document.getElementById('btn-play');
    if (btnPlay) {
        btnPlay.addEventListener('click', togglePlayPause);
    }
}

// Reproducir canción
function reproducirCancion(id, titulo, artista, imagen) {
    const playerInfo = document.getElementById('player-info');
    const playerTitle = document.getElementById('player-title');
    const playerArtist = document.getElementById('player-artist');
    const playerImage = document.getElementById('player-image');
    const btnPlay = document.getElementById('btn-play');

    if (playerTitle) playerTitle.textContent = titulo;
    if (playerArtist) playerArtist.textContent = artista;
    if (playerImage) playerImage.src = imagen;

    cancionActual = { id, titulo, artista, imagen };
    estaReproduciendo = true;

    if (btnPlay) {
        btnPlay.innerHTML = '<i class="fas fa-pause"></i>';
    }

    // Simular reproducción
    iniciarProgreso();

    // Marcar canción como reproducida
    fetch('../includes/ajax.php?action=registrarReproduccion&id=' + id);
}

// Toggle play/pause
function togglePlayPause() {
    const btnPlay = document.getElementById('btn-play');

    if (estaReproduciendo) {
        pausar();
        if (btnPlay) btnPlay.innerHTML = '<i class="fas fa-play"></i>';
    } else {
        if (cancionActual) {
            reanudar();
            if (btnPlay) btnPlay.innerHTML = '<i class="fas fa-pause"></i>';
        } else {
            // Reproducir primera canción disponible
            const primeraCancion = document.querySelector('.cancion-card');
            if (primeraCancion) {
                primeraCancion.click();
            }
        }
    }
}

function pausar() {
    estaReproduciendo = false;
    detenerProgreso();
}

function reanudar() {
    estaReproduciendo = true;
    iniciarProgreso();
}

// Progreso simulado
function iniciarProgreso() {
    const progressFill = document.querySelector('.progress-fill');
    const currentTime = document.getElementById('current-time');

    detenerProgreso();
    progreso = 0;

    intervaloProgreso = setInterval(() => {
        if (progreso >= 100) {
            progreso = 0;
            // siguiente canción
        } else {
            progreso += 0.5;
            if (progressFill) progressFill.style.width = progreso + '%';
            if (currentTime) {
                let segundos = Math.floor(progreso * 3.5); // Simular tiempo
                let minutos = Math.floor(segundos / 60);
                segundos = segundos % 60;
                currentTime.textContent = minutos + ':' + (segundos < 10 ? '0' : '') + segundos;
            }
        }
    }, 100);
}

function detenerProgreso() {
    if (intervaloProgreso) {
        clearInterval(intervaloProgreso);
        intervaloProgreso = null;
    }
}

// Toggle favorito
function toggleFavorito(cancionId) {
    fetch('../includes/ajax.php?action=toggleFavorito&id=' + cancionId)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const btn = event.target.closest('.btn-favorito');
                if (data.agregado) {
                    btn.classList.add('active');
                    btn.innerHTML = '<i class="fas fa-heart"></i>';
                } else {
                    btn.classList.remove('active');
                    btn.innerHTML = '<i class="far fa-heart"></i>';
                }
            }
        })
        .catch(error => console.error('Error:', error));
}

// Toggle seguir artista
function toggleSeguir(artistaId) {
    fetch('../includes/ajax.php?action=toggleSeguir&id=' + artistaId)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const btn = event.target.closest('.btn-seguir');
                if (data.siguiendo) {
                    btn.classList.add('active');
                    btn.innerHTML = '<i class="fas fa-check"></i> Siguiendo';
                } else {
                    btn.classList.remove('active');
                    btn.innerHTML = '<i class="fas fa-plus"></i> Seguir';
                }
            }
        })
        .catch(error => console.error('Error:', error));
}

// Ver álbum
function verAlbum(albumId) {
    window.location.href = '../normal/album.php?id=' + albumId;
}

// Ver artista
function verArtista(artistaId) {
    window.location.href = '../normal/artista.php?id=' + artistaId;
}

// Buscar
function buscar(query) {
    if (query.length >= 2) {
        window.location.href = '../normal/buscar.php?q=' + encodeURIComponent(query);
    }
}

// User dropdown
function toggleDropdown() {
    const dropdown = document.querySelector('.dropdown-menu');
    if (dropdown) {
        dropdown.classList.toggle('show');
    }
}

// Cerrar dropdown al hacer click fuera
document.addEventListener('click', function(e) {
    if (!e.target.closest('.user-dropdown')) {
        const dropdowns = document.querySelectorAll('.dropdown-menu');
        dropdowns.forEach(d => d.classList.remove('show'));
    }
});

// Mostrar modal
function mostrarModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.add('show');
    }
}

// Cerrar modal
function cerrarModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.remove('show');
    }
}

// Eliminar elemento
function eliminar(id, tipo, callback) {
    if (confirm('¿Estás seguro de que deseas eliminar este ' + tipo + '?')) {
        fetch('../includes/ajax.php?action=eliminar&tipo=' + tipo + '&id=' + id)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    if (callback) callback();
                    else location.reload();
                } else {
                    alert(data.message || 'Error al eliminar');
                }
            });
    }
}

// Guardar en playlist
function guardarEnPlaylist(cancionId, playlistId) {
    fetch('../includes/ajax.php?action=guardarEnPlaylist&cancion=' + cancionId + '&playlist=' + playlistId)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Canción guardada en la playlist');
                cerrarModal('playlist-modal');
            } else {
                alert(data.message || 'Error al guardar');
            }
        });
}

// Crear playlist
function crearPlaylist() {
    const nombre = document.getElementById('playlist-nombre').value;
    const descripcion = document.getElementById('playlist-descripcion').value;
    const publica = document.getElementById('playlist-publica').checked;

    if (!nombre) {
        alert('El nombre es requerido');
        return;
    }

    fetch('../includes/ajax.php?action=crearPlaylist&nombre=' + encodeURIComponent(nombre) + '&descripcion=' + encodeURIComponent(descripcion) + '&publica=' + (publica ? 1 : 0))
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Playlist creada');
                location.reload();
            } else {
                alert(data.message || 'Error al crear playlist');
            }
        });
}

//Tabs
function switchTab(tabName) {
    const tabs = document.querySelectorAll('.tab');
    const contents = document.querySelectorAll('.tab-content');

    tabs.forEach(t => t.classList.remove('active'));
    contents.forEach(c => c.classList.remove('active'));

    document.querySelector('.tab[data-tab="' + tabName + '"]').classList.add('active');
    document.getElementById(tabName + '-content').classList.add('active');
}

// Formatear número grande
function formatearNumero(num) {
    if (num >= 1000000) {
        return (num / 1000000).toFixed(1) + 'M';
    } else if (num >= 1000) {
        return (num / 1000).toFixed(1) + 'K';
    }
    return num;
}