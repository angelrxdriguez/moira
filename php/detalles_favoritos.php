<?php
header('Content-Type: application/json');

$ids = $_GET['ids'] ?? '';
if (!$ids) {
    echo json_encode(["success" => false, "message" => "No se proporcionaron IDs"]);
    exit;
}

$idsArray = explode(",", $ids);

// Seguridad: sanitizamos IDs
$idsArray = array_map('intval', $idsArray);

$conn = new mysqli("localhost", "root", "", "moira");
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Error de conexión"]);
    exit;
}

$placeholders = implode(',', array_fill(0, count($idsArray), '?'));
$stmt = $conn->prepare("SELECT * FROM ofertas WHERE id IN ($placeholders)");
$stmt->bind_param(str_repeat("i", count($idsArray)), ...$idsArray);
$stmt->execute();
$result = $stmt->get_result();

$ofertas = [];
while ($row = $result->fetch_assoc()) {
    $ofertas[] = $row;
}

echo json_encode(["success" => true, "ofertas" => $ofertas]);
