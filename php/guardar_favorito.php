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

// Obtener ID del usuario
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

$stmt = $conn->prepare("SELECT 1 FROM favoritos WHERE usuario_id = ? AND oferta_id = ?");
$stmt->bind_param("ii", $usuario_id, $oferta_id);
$stmt->execute();
$existe = $stmt->get_result()->num_rows > 0;
$stmt->close();

if ($existe) {
    $stmt = $conn->prepare("DELETE FROM favoritos WHERE usuario_id = ? AND oferta_id = ?");
    $stmt->bind_param("ii", $usuario_id, $oferta_id);
    $stmt->execute();
    $stmt->close();
    echo json_encode(["success" => true, "action" => "removed"]);
} else {
    $stmt = $conn->prepare("INSERT INTO favoritos (usuario_id, oferta_id) VALUES (?, ?)");
    $stmt->bind_param("ii", $usuario_id, $oferta_id);
    $stmt->execute();
    $stmt->close();
    echo json_encode(["success" => true, "action" => "added"]);
}

$conn->close();
