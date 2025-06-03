<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['email'])) {
    echo json_encode(["success" => false, "message" => "No hay sesión activa"]);
    exit;
}

$host = "localhost";
$user = "root";
$pass = "";
$db = "moira";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Error de conexión"]);
    exit;
}

$email = $_SESSION['email'];

// Obtener el ID del usuario
$stmt = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows !== 1) {
    echo json_encode(["success" => false, "message" => "Usuario no encontrado"]);
    exit;
}

$usuario_id = $result->fetch_assoc()['id'];
$stmt->close();

// Obtener las ofertas favoritas
$stmt = $conn->prepare("SELECT oferta_id FROM favoritos WHERE usuario_id = ?");
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$result = $stmt->get_result();

$favoritos = [];
while ($row = $result->fetch_assoc()) {
    $favoritos[] = $row['oferta_id'];
}

echo json_encode(["success" => true, "favoritos" => $favoritos]);
$stmt->close();
$conn->close();
