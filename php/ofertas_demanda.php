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

// Obtener ID de usuario actual
$email = $_SESSION['email'];
$stmt = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$res = $stmt->get_result();

if ($res->num_rows !== 1) {
    echo json_encode(["success" => false, "message" => "Usuario no encontrado"]);
    exit;
}

$usuario_id = $res->fetch_assoc()['id'];
$stmt->close();

// Filtros desde GET
$tema = $_GET['tema'] ?? '';
$comunidad = $_GET['comunidad'] ?? '';
$provincia = $_GET['provincia'] ?? '';
$ciudad = $_GET['ciudad'] ?? '';

// Base con JOIN a temas
$sql = "SELECT ofertas.* 
        FROM ofertas 
        JOIN temas ON ofertas.tema_id = temas.id 
        WHERE ofertas.usuario_id != ?";
$tipos = "i";
$valores = [$usuario_id];

// Filtros dinámicos
if (!empty($tema)) {
    $sql .= " AND temas.nombre = ?";
    $tipos .= "s";
    $valores[] = $tema;
}
if (!empty($comunidad)) {
    $sql .= " AND ofertas.comunidad = ?";
    $tipos .= "s";
    $valores[] = $comunidad;
}
if (!empty($provincia)) {
    $sql .= " AND ofertas.provincia = ?";
    $tipos .= "s";
    $valores[] = $provincia;
}
if (!empty($ciudad)) {
    $sql .= " AND ofertas.ciudad = ?";
    $tipos .= "s";
    $valores[] = $ciudad;
}

// Preparar y ejecutar
$stmt = $conn->prepare($sql);
$stmt->bind_param($tipos, ...$valores);
$stmt->execute();
$resultado = $stmt->get_result();

// Formatear resultados
$ofertas = [];
while ($fila = $resultado->fetch_assoc()) {
    $ofertas[] = $fila;
}

echo json_encode(["success" => true, "ofertas" => $ofertas]);
?>
