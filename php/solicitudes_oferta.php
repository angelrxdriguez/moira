<?php
// solicitudes_oferta.php
session_start();
header("Content-Type: application/json");

if (!isset($_SESSION['email'])) {
    echo json_encode(["success" => false, "message" => "Sesión no iniciada"]);
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

$oferta_id = $_GET['id'] ?? null;

if (!$oferta_id) {
    echo json_encode(["success" => false, "message" => "ID de oferta no proporcionado"]);
    exit;
}

$stmt = $conn->prepare("SELECT nombre, apellidos, telefono, email, presentacion, archivo, fecha_envio FROM solicitudes_servicio WHERE oferta_id = ?");
$stmt->bind_param("i", $oferta_id);
$stmt->execute();
$result = $stmt->get_result();

$solicitudes = [];
while ($row = $result->fetch_assoc()) {
    $solicitudes[] = $row;
}

echo json_encode(["success" => true, "solicitudes" => $solicitudes]);

$stmt->close();
$conn->close();
?>
