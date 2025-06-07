<?php
// guardar_solicitud.php
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

$oferta_id = $_POST['oferta_id'] ?? null;
$nombre = trim($_POST['nombre'] ?? '');
$apellidos = trim($_POST['apellidos'] ?? '');
$telefono = trim($_POST['telefono'] ?? '');
$email = trim($_POST['email'] ?? '');
$presentacion = trim($_POST['presentacion'] ?? '');
$archivo_ruta = trim($_POST['archivo'] ?? '');

if (!$oferta_id || !$nombre || !$apellidos || !$email) {
    echo json_encode(["success" => false, "message" => "Faltan campos obligatorios"]);
    exit;
}

$stmt_usuario = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
$stmt_usuario->bind_param("s", $_SESSION['email']);
$stmt_usuario->execute();
$res_usuario = $stmt_usuario->get_result();

if ($res_usuario->num_rows !== 1) {
    echo json_encode(["success" => false, "message" => "Usuario no encontrado"]);
    exit;
}
$id_usuario = $res_usuario->fetch_assoc()['id'];

$stmt = $conn->prepare("INSERT INTO solicitudes_servicio (usuario_id, oferta_id, nombre, apellidos, telefono, email, presentacion, archivo, fecha_envio) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())");
$stmt->bind_param("iissssss", $id_usuario, $oferta_id, $nombre, $apellidos, $telefono, $email, $presentacion, $archivo_ruta);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Solicitud enviada correctamente"]);
} else {
    echo json_encode(["success" => false, "message" => "Error al guardar en la base de datos: " . $stmt->error]);
}

$stmt->close();
$conn->close();

?>
