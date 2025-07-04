<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['usuario'])) {
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

if (!isset($_SESSION['email'])) {
  echo json_encode(["success" => false, "message" => "No hay sesión activa"]);
  exit;
}

$stmt = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
$stmt->bind_param("s", $_SESSION['email']);

$stmt->execute();
$resultado = $stmt->get_result();
if ($resultado->num_rows !== 1) {
    echo json_encode(["success" => false, "message" => "Usuario no válido"]);
    exit;
}
$usuario_id = $resultado->fetch_assoc()['id'];
$stmt->close();

$stmt = $conn->prepare("SELECT * FROM ofertas WHERE usuario_id = ?");
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$resultado = $stmt->get_result();

$ofertas = [];
while ($fila = $resultado->fetch_assoc()) {
    $ofertas[] = $fila;
}

echo json_encode(["success" => true, "ofertas" => $ofertas]);
