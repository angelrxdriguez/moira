<?php
session_start();
header("Content-Type: application/json");

if (!isset($_SESSION['email'])) {
    echo json_encode(["success" => false, "message" => "No hay sesión activa"]);
    exit;
}

if (!isset($_POST['id'])) {
    echo json_encode(["success" => false, "message" => "ID no proporcionado"]);
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

$id = $_POST['id'];

$stmt = $conn->prepare("DELETE FROM ofertas WHERE id = ?");
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "message" => "No se pudo eliminar la oferta"]);
}

$stmt->close();
$conn->close();
?>
