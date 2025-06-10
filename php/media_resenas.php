<?php
header("Content-Type: application/json");
$host = "localhost";
$user = "root";
$pass = "";
$db = "moira";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Conexión fallida"]);
    exit;
}

$usuario_id = $_GET['id'] ?? null;
if (!$usuario_id || !filter_var($usuario_id, FILTER_VALIDATE_INT)) {
    echo json_encode(["success" => false, "message" => "ID inválido"]);
    exit;
}

$sql = "SELECT ROUND(AVG(valoracion)) AS media FROM resenas WHERE reseñado_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$result = $stmt->get_result()->fetch_assoc();

echo json_encode(["success" => true, "media" => $result['media'] ?? 0]);
?>
