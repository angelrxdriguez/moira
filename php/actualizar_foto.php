<?php
session_start();

$host = "localhost";
$usuario = "root";
$clave = "";
$bd = "moira";

$conn = new mysqli($host, $usuario, $clave, $bd);
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Error de conexión"]);
    exit();
}

$email = $_POST['email'] ?? '';
$foto = $_POST['foto'] ?? '';

if (empty($email) || empty($foto)) {
    echo json_encode(["success" => false, "message" => "Datos incompletos"]);
    exit();
}

$stmt = $conn->prepare("UPDATE usuarios SET foto = ? WHERE email = ?");
$stmt->bind_param("ss", $foto, $email);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Foto actualizada"]);
} else {
    echo json_encode(["success" => false, "message" => "Error al actualizar"]);
}

$stmt->close();
$conn->close();
?>
