<?php
session_start();
header("Content-Type: application/json");

if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(["success" => false, "message" => "Sesión no iniciada"]);
    exit;
}

$autor_id = $_SESSION['usuario_id'];
$reseñado_id = $_POST['reseñado_id'] ?? null;
$valoracion = $_POST['valoracion'] ?? null;

if (!filter_var($reseñado_id, FILTER_VALIDATE_INT) || !in_array((int)$valoracion, [1, 2, 3, 4, 5])) {
    echo json_encode(["success" => false, "message" => "Datos inválidos"]);
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

$stmt = $conn->prepare("INSERT INTO resenas (reseñado_id, autor_id, valoracion) VALUES (?, ?, ?)");
$stmt->bind_param("iii", $reseñado_id, $autor_id, $valoracion);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "message" => "Error al guardar reseña: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
