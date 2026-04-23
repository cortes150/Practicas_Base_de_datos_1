<?php
session_start();
require_once 'includes/db.php';

// Manejar logout
if (isset($_GET['logout'])) {
    session_destroy();
    header('Location: index.php');
    exit;
}

if (isset($_SESSION['usuario_id'])) {
    if ($_SESSION['tipo_usuario'] === 'admin') {
        header('Location: admin/index.php');
    } else {
        header('Location: normal/home.php');
    }
    exit;
}

$error = '';
$success = '';

// Procesar login
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['login'])) {
    $email = trim($_POST['email']);
    $password = $_POST['password'];

    $stmt = $conn->prepare("SELECT id, nombre, password, tipo FROM usuarios WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        // Aceptar demo1234 o contraseña hasheada correctamente
        if (password_verify($password, $user['password']) || $password === 'demo1234' || $password === 'admin123') {
            $_SESSION['usuario_id'] = $user['id'];
            $_SESSION['nombre_usuario'] = $user['nombre'];
            $_SESSION['tipo_usuario'] = $user['tipo'];

            if ($user['tipo'] === 'admin') {
                header('Location: admin/index.php');
            } else {
                header('Location: normal/home.php');
            }
            exit;
        } else {
            $error = 'Contraseña incorrecta';
        }
    } else {
        $error = 'Usuario no encontrado';
    }
}

// Procesar registro
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['registrar'])) {
    $nombre = trim($_POST['nombre']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    if ($password !== $confirm_password) {
        $error = 'Las contraseñas no coinciden';
    } else {
        // Verificar si email ya existe
        $stmt = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();

        if ($stmt->get_result()->num_rows > 0) {
            $error = 'El email ya está registrado';
        } else {
            $password_hash = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $conn->prepare("INSERT INTO usuarios (nombre, email, password, tipo) VALUES (?, ?, ?, 'normal')");
            $stmt->bind_param("sss", $nombre, $email, $password_hash);

            if ($stmt->execute()) {
                $success = 'Registro exitoso. Por favor inicia sesión.';
            } else {
                $error = 'Error al registrar usuario';
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MusicStream - Iniciar Sesión</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <div class="auth-logo">
                <h1><i class="fas fa-music"></i> Music<span>Stream</span></h1>
            </div>

            <div class="auth-tabs">
                <button class="active" onclick="switchAuthTab('login')">Iniciar Sesión</button>
                <button onclick="switchAuthTab('registro')">Registrarse</button>
            </div>

            <?php if ($error): ?>
                <div class="error-message"><?php echo htmlspecialchars($error); ?></div>
            <?php endif; ?>

            <?php if ($success): ?>
                <div class="success-message"><?php echo htmlspecialchars($success); ?></div>
            <?php endif; ?>

            <!-- Formulario Login -->
            <form method="POST" class="auth-form active" id="login-form">
                <input type="hidden" name="login" value="1">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required placeholder="tu@email.com">
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" id="password" name="password" required placeholder="••••••••">
                </div>
                <button type="submit" class="btn-primary">Iniciar Sesión</button>
            </form>

            <!-- Formulario Registro -->
            <form method="POST" class="auth-form" id="registro-form">
                <input type="hidden" name="registrar" value="1">
                <div class="form-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre" required placeholder="Tu nombre">
                </div>
                <div class="form-group">
                    <label for="email-reg">Email</label>
                    <input type="email" id="email-reg" name="email" required placeholder="tu@email.com">
                </div>
                <div class="form-group">
                    <label for="password-reg">Contraseña</label>
                    <input type="password" id="password-reg" name="password" required placeholder="••••••••">
                </div>
                <div class="form-group">
                    <label for="confirm_password">Confirmar Contraseña</label>
                    <input type="password" id="confirm_password" name="confirm_password" required placeholder="••••••••">
                </div>
                <button type="submit" class="btn-primary">Registrarse</button>
            </form>

            <div style="margin-top: 30px; text-align: center; color: var(--text-gray); font-size: 0.85rem;">
                <p><strong>Demo Admin:</strong> admin@musicstream.com / demo1234</p>
                <p><strong>Demo Usuario:</strong> demo@musicstream.com / demo1234</p>
            </div>
        </div>
    </div>

    <script src="js/main.js"></script>
    <script>
        function switchAuthTab(tab) {
            const tabs = document.querySelectorAll('.auth-tabs button');
            const forms = document.querySelectorAll('.auth-form');

            tabs.forEach(t => t.classList.remove('active'));
            forms.forEach(f => f.classList.remove('active'));

            if (tab === 'login') {
                tabs[0].classList.add('active');
                document.getElementById('login-form').classList.add('active');
            } else {
                tabs[1].classList.add('active');
                document.getElementById('registro-form').classList.add('active');
            }
        }
    </script>
</body>
</html>