<?php
session_start();
header("Content-Type: application/json");

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

$id = $_POST["id"];
$titulo = $_POST["titulo"];
$descripcion = $_POST["descripcion"];
$fechaInicio = $_POST["fechaInicio"];
$fechaFin = $_POST["fechaFin"];
$diasHorarios = $_POST["diasHorarios"];
$tipoRemuneracion = $_POST["tipoRemuneracion"];
$cantidad = $_POST["cantidad"];
$tipoPago = $_POST["tipoPago"];
$nombreOfertante = $_POST["nombreOfertante"];
$telefono = $_POST["telefono"];
$email = $_POST["email"];
$vacantes = $_POST["vacantes"];

$stmt = $conn->prepare("UPDATE ofertas SET titulo=?, descripcion=?, fecha_inicio=?, fecha_fin=?, dias_horarios=?, tipo_remuneracion=?, cantidad=?, tipo_pago=?, nombre_ofertante=?, telefono=?, email=?, vacantes=? WHERE id=?");
$stmt->bind_param("ssssssdsssssi", $titulo, $descripcion, $fechaInicio, $fechaFin, $diasHorarios, $tipoRemuneracion, $cantidad, $tipoPago, $nombreOfertante, $telefono, $email, $vacantes, $id);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "message" => "Error al actualizar"]);
}

$stmt->close();
$conn->close();
?>
