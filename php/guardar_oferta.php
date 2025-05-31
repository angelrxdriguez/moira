<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['usuario'])) {
  echo json_encode(["success" => false, "message" => "Sesión no iniciada"]);
  exit();
}

$host = "localhost";
$usuario = "root";
$clave = "";
$bd = "moira";

$conn = new mysqli($host, $usuario, $clave, $bd);
if ($conn->connect_error) {
  echo json_encode(["success" => false, "message" => "Error de conexión"]);
  exit();
}

// Recuperar ID del usuario desde la sesión
$stmt = $conn->prepare("SELECT id FROM usuarios WHERE usuario = ?");
$stmt->bind_param("s", $_SESSION['usuario']);
$stmt->execute();
$resultado = $stmt->get_result();
if ($resultado->num_rows !== 1) {
  echo json_encode(["success" => false, "message" => "Usuario no válido"]);
  exit();
}
$usuario_id = $resultado->fetch_assoc()['id'];
$stmt->close();

// Recoger y limpiar datos del formulario
$datos = $_POST;

$tema = $datos['tema'];
$subtema = $datos['subtema'];
$titulo = trim($datos['titulo']);
$descripcion = trim($datos['descripcion']);
$comunidad = $datos['comunidad'];
$provincia = $datos['provincia'];
$ciudad = $datos['ciudad'];
$direccion = trim($datos['direccion']);
$fechaInicio = $datos['fechaInicio'];
$fechaFin = $datos['fechaFin'] ?: null;
$diasHorarios = trim($datos['diasHorarios']);
$tipoRemuneracion = $datos['tipoRemuneracion'];
$cantidad = $datos['cantidad'];
$tipoPago = $datos['tipoPago'];
$nombreOfertante = trim($datos['nombreOfertante']);
$telefono = trim($datos['telefono']);
$email = trim($datos['email']);
$vacantes = (int)$datos['vacantes'];

$query = "INSERT INTO ofertas (
  usuario_id, tema_id, subtema_id, titulo, descripcion,
  comunidad, provincia, ciudad, direccion,
  fecha_inicio, fecha_fin, dias_horarios,
  tipo_remuneracion, cantidad, tipo_pago,
  nombre_ofertante, telefono, email, vacantes
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($query);
$stmt->bind_param("iiisssssssssssssisi",
  $usuario_id, $tema, $subtema, $titulo, $descripcion,
  $comunidad, $provincia, $ciudad, $direccion,
  $fechaInicio, $fechaFin, $diasHorarios,
  $tipoRemuneracion, $cantidad, $tipoPago,
  $nombreOfertante, $telefono, $email, $vacantes
);

if ($stmt->execute()) {
  echo json_encode(["success" => true, "message" => "Oferta guardada con éxito"]);
} else {
  echo json_encode(["success" => false, "message" => "Error al guardar oferta"]);
}
$stmt->close();
$conn->close();
?>
