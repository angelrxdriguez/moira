<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['email'])) {
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

// Obtener ID del usuario desde la sesión
$stmt = $conn->prepare("SELECT id, email FROM usuarios WHERE email = ?");
$stmt->bind_param("s", $_SESSION['email']);
$stmt->execute();
$resultado = $stmt->get_result();
if ($resultado->num_rows !== 1) {
  echo json_encode(["success" => false, "message" => "Usuario no válido"]);
  exit();
}

$stmt->execute();
$resultado = $stmt->get_result();
if ($resultado->num_rows !== 1) {
  echo json_encode(["success" => false, "message" => "Usuario no válido"]);
  exit();
}
$usuario_id = $resultado->fetch_assoc()['id'];
$stmt->close();

// Recoger datos del formulario
$datos = $_POST;

$tema = $datos['tema'];
$subtema = $datos['subtema'];
$titulo = trim($datos['titulo']);
$descripcion = trim($datos['descripcion']);
$imagen = trim($datos['imagen']);
$comunidad = $datos['comunidad'];
$provincia = $datos['provincia'];
$ciudad = $datos['ciudad'];
$direccion = trim($datos['direccion']);
$fechaInicio = $datos['fechaInicio'];
$fechaFin = $datos['fechaFin'] ?: null;
$tipoRemuneracion = $datos['tipoRemuneracion'];
$cantidad = $datos['cantidad'];
$tipoPago = $datos['tipoPago'];
$telefono = trim($datos['telefono']);
$vacantes = (int)$datos['vacantes'];

// Insertar en la base de datos
$query = "INSERT INTO ofertas (
  usuario_id, tema_id, subtema_id, titulo, descripcion, imagen,
  comunidad, provincia, ciudad, direccion,
  fecha_inicio, fecha_fin,
  tipo_remuneracion, cantidad, tipo_pago,
  telefono, vacantes
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($query);
$stmt->bind_param("iiisssssssssssssi",
  $usuario_id, $tema, $subtema, $titulo, $descripcion, $imagen,
  $comunidad, $provincia, $ciudad, $direccion,
  $fechaInicio, $fechaFin,
  $tipoRemuneracion, $cantidad, $tipoPago,
  $telefono, $vacantes
);

if ($stmt->execute()) {
  echo json_encode(["success" => true, "message" => "Oferta guardada con éxito"]);
} else {
  echo json_encode(["success" => false, "message" => "Error al guardar oferta: " . $stmt->error]);
}

$stmt->close();
$conn->close();
