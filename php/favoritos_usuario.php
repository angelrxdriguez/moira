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

// Obtener ID del usuario
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

// Obtener ofertas marcadas como favoritas por el usuario
$sql = "
SELECT o.* 
FROM favoritos f
JOIN ofertas o ON f.oferta_id = o.id
WHERE f.usuario_id = ?
ORDER BY f.fecha_marcado DESC
";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$resultado = $stmt->get_result();

$ofertas = [];
while ($row = $resultado->fetch_assoc()) {
    $ofertas[] = $row;
}

echo json_encode([
    "success" => true,
    "ofertas" => $ofertas
]);

$stmt->close();
$conn->close();
