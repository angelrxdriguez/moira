<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['email'])) {
    echo json_encode(["success" => false, "message" => "No hay sesión iniciada."]);
    exit;
}

$conn = new mysqli("localhost", "root", "", "moira");
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Error de conexión"]);
    exit;
}

$email = $_SESSION['email'];
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

$stmt = $conn->prepare("SELECT ROUND(AVG(valoracion), 1) as media FROM resenas WHERE reseñado_id = ?");
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$res = $stmt->get_result();
$media = $res->fetch_assoc()['media'] ?? 0;

echo json_encode(["success" => true, "media" => floatval($media)]);
$stmt->close();
$conn->close();
