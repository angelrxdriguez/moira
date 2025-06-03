<?php
session_start();
header("Content-Type: application/json");

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

$id = $_POST["id"];
$titulo = $_POST["titulo"];
$descripcion = $_POST["descripcion"];
$imagen = $_POST["imagen"];
$comunidad = $_POST["comunidad"];
$provincia = $_POST["provincia"];
$ciudad = $_POST["ciudad"];
$fechaInicio = $_POST["fechaInicio"];
$fechaFin = $_POST["fechaFin"];
$tipoRemuneracion = $_POST["tipoRemuneracion"];
$cantidad = $_POST["cantidad"];
$tipoPago = $_POST["tipoPago"];

$stmt = $conn->prepare("UPDATE ofertas 
    SET titulo = ?, descripcion = ?, imagen = ?, comunidad = ?, provincia = ?, ciudad = ?, 
        fecha_inicio = ?, fecha_fin = ?, tipo_remuneracion = ?, cantidad = ?, tipo_pago = ?
    WHERE id = ?");
$stmt->bind_param(
    "sssssssssdsi",
    $titulo, $descripcion, $imagen, $comunidad, $provincia, $ciudad,
    $fechaInicio, $fechaFin, $tipoRemuneracion, $cantidad, $tipoPago, $id
);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "message" => "Error al actualizar"]);
}

$stmt->close();
$conn->close();
