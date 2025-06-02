<?php
require 'PHPMailer/PHPMailer.php';
require 'PHPMailer/SMTP.php';
require 'PHPMailer/Exception.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

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

$stmt = $conn->prepare("SELECT id, email FROM usuarios WHERE usuario = ?");
$stmt->bind_param("s", $_SESSION['usuario']);
$stmt->execute();
$resultado = $stmt->get_result();
if ($resultado->num_rows !== 1) {
  echo json_encode(["success" => false, "message" => "Usuario no válido"]);
  exit();
}
$usuario_info = $resultado->fetch_assoc();
$usuario_id = $usuario_info['id'];
$email_sesion = $usuario_info['email'];
$stmt->close();

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
$imagen = trim($datos['imagen']);

$query = "INSERT INTO ofertas (
  usuario_id, tema_id, subtema_id, titulo, descripcion, imagen,
  comunidad, provincia, ciudad, direccion,
  fecha_inicio, fecha_fin, dias_horarios,
  tipo_remuneracion, cantidad, tipo_pago,
  nombre_ofertante, telefono, email, vacantes
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($query);
$stmt->bind_param("iiisssssssssssssissi", 
  $usuario_id, $tema, $subtema, $titulo, $descripcion, $imagen,
  $comunidad, $provincia, $ciudad, $direccion,
  $fechaInicio, $fechaFin, $diasHorarios,
  $tipoRemuneracion, $cantidad, $tipoPago,
  $nombreOfertante, $telefono, $email, $vacantes
);

if ($stmt->execute()) {
  // Enviar correo
  $mail = new PHPMailer(true);
  try {
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'panaderorodriguezangel.sangrina@gmail.com';
    $mail->Password = 'mljq nlhv kzcw vwgh';
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;

    $mail->setFrom('panaderorodriguezangel.sangrina@gmail.com', 'Moira');
    $mail->addAddress($email_sesion, $_SESSION['usuario']);

    $mail->isHTML(true);
    $mail->Subject = "Oferta publicada con éxito";
    $mail->Body = "
      <h3>¡Hola {$_SESSION['usuario']}!</h3>
      <p>Has publicado la oferta <strong>$titulo</strong> en Moira.</p>
      <ul>
        <li><strong>Ciudad:</strong> $ciudad</li>
        <li><strong>Fecha de inicio:</strong> $fechaInicio</li>
        <li><strong>Pago:</strong> $cantidad € ($tipoPago)</li>
      </ul>
      <p>Gracias por usar Moira.</p>
    ";

    $mail->send();
  } catch (Exception $e) {
    // Puedes loguear el error si quieres
  }

  echo json_encode(["success" => true, "message" => "Oferta guardada con éxito"]);
} else {
  echo json_encode(["success" => false, "message" => "Error al guardar oferta"]);
}

$stmt->close();
$conn->close();
