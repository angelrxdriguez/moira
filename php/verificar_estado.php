<?php
header('Content-Type: application/json');
$host = "localhost";
$user = "root";
$pass = "";
$db = "moira";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Error de conexión"]);
    exit();
}

$email = $_GET['email'] ?? '';
if (!$email) {
    echo json_encode(["success" => false, "message" => "Email no proporcionado"]);
    exit();
}

$stmt = $conn->prepare("SELECT verificado FROM usuarios WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    echo json_encode(["success" => true, "verificado" => (bool)$row['verificado']]);
} else {
    echo json_encode(["success" => false, "message" => "Usuario no encontrado"]);
}
$stmt->close();
$conn->close();
