<?php
// Conexión a MySQL
$host = 'localhost';
$user = 'root';
$password = '';
$database = 'musicstream';

try {
    $conn = new mysqli($host, $user, $password, $database);
    if ($conn->connect_error) {
        throw new Exception("Error de conexión: " . $conn->connect_error);
    }
    $conn->set_charset("utf8mb4");
} catch (Exception $e) {
    die("Error de conexión a la base de datos: " . $e->getMessage());
}

// Iniciar sesión
session_start();

// Función para verificar si el usuario está logueado
function verificarSesion() {
    if (!isset($_SESSION['usuario_id'])) {
        header('Location: index.php');
        exit;
    }
}

// Función para verificar tipo de usuario
function verificarTipo($tipo_requerido) {
    if (!isset($_SESSION['tipo_usuario']) || $_SESSION['tipo_usuario'] !== $tipo_requerido) {
        header('Location: index.php');
        exit;
    }
}
?>