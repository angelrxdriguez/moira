<?php
// actualizar_estado.php
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

$id = $_POST['id'] ?? null;
$estado = $_POST['estado'] ?? '';

if (!isset($_POST['id']) || !isset($_POST['estado'])) {
   echo json_encode([
  "success" => false,
  "message" => "Faltan datos POST",
  "post_id" => $_POST['id'] ?? 'no recibido',
  "post_estado" => $_POST['estado'] ?? 'no recibido'
]);
exit;

}

if (!filter_var($id, FILTER_VALIDATE_INT)) {
    echo json_encode([
        "success" => false,
        "message" => "ID inválido",
        "debug" => $id
    ]);
    exit;
}

if (!in_array($estado, ['pendiente', 'aceptado', 'rechazado'])) {
    echo json_encode([
        "success" => false,
        "message" => "Estado inválido",
        "debug" => $estado
    ]);
    exit;
}


if (!filter_var($id, FILTER_VALIDATE_INT) || !in_array($estado, ['pendiente', 'aceptado', 'rechazado'])) {
    echo json_encode(["success" => false, "message" => "Datos inválidos"]);
    exit;
}


$stmt = $conn->prepare("UPDATE solicitudes_servicio SET estado = ? WHERE id = ?");
$stmt->bind_param("si", $estado, $id);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Estado actualizado"]);
} else {
    echo json_encode(["success" => false, "message" => "Error al actualizar: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
