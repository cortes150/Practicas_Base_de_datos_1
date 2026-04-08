<?php
$conn = new mysqli("localhost", "root", "", "musica_db");

$data = json_decode(file_get_contents("php://input"));

$nombre = $data->nombre;
$email = $data->email;
$password = $data->password;

// Verificar duplicado
$check = $conn->query("SELECT * FROM usuarios WHERE email='$email'");

if ($check->num_rows > 0) {
    echo json_encode(["message" => "El usuario ya existe"]);
} else {

    $sql = "INSERT INTO usuarios (nombre, email, password)
            VALUES ('$nombre', '$email', '$password')";

    if ($conn->query($sql)) {
        echo json_encode(["message" => "Registro exitoso"]);
    } else {
        echo json_encode(["message" => "Error al registrar"]);
    }
}
?>