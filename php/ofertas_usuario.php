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

$email = $_SESSION['email'];

$stmt = $conn->prepare("SELECT * FROM ofertas WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$resultado = $stmt->get_result();

$ofertas = [];
while ($fila = $resultado->fetch_assoc()) {
    $ofertas[] = $fila;
}

echo json_encode(["success" => true, "ofertas" => $ofertas]);
