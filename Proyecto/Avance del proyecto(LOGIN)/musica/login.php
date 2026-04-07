<?php
$conn = new mysqli("localhost", "root", "", "musica_db");

$data = json_decode(file_get_contents("php://input"));

$email = $data->email;
$password = $data->password;

$sql = "SELECT * FROM usuarios WHERE email='$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {

    $user = $result->fetch_assoc();

    if ($user['bloqueado'] == 1) {
        echo json_encode(["message" => "Usuario bloqueado"]);
        exit;
    }

    if ($password == $user['password']) {

        // Reiniciar intentos
        $conn->query("UPDATE usuarios SET intentos=0 WHERE email='$email'");

        echo json_encode(["message" => "Login correcto"]);

    } else {

        $intentos = $user['intentos'] + 1;

        if ($intentos >= 3) {

            $conn->query("UPDATE usuarios SET intentos=$intentos, bloqueado=1 WHERE email='$email'");

            echo json_encode(["message" => "Usuario bloqueado por 3 intentos"]);

        } else {

            $conn->query("UPDATE usuarios SET intentos=$intentos WHERE email='$email'");

            echo json_encode([
                "message" => "Contraseña incorrecta. Intento $intentos de 3"
            ]);
        }
    }

} else {
    echo json_encode(["message" => "Usuario no existe"]);
}
?>