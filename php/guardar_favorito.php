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

$oferta_id = intval($_POST['oferta_id']);
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

// Insertar en favoritos
$stmt = $conn->prepare("INSERT IGNORE INTO favoritos (usuario_id, oferta_id) VALUES (?, ?)");
$stmt->bind_param("ii", $usuario_id, $oferta_id);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Favorito guardado"]);
} else {
    echo json_encode(["success" => false, "message" => "Error al guardar favorito"]);
}

$stmt->close();
$conn->close();
