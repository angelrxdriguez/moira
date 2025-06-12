<?php
$host = "localhost";
$usuario = "root";
$clave = "";
$bd = "moira";

$conn = new mysqli($host, $usuario, $clave, $bd);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Error de conexión"]);
    exit();
}

$temas = [];
$result = $conn->query("SELECT id, nombre FROM temas");
while ($row = $result->fetch_assoc()) {
    $temas[$row['id']] = ["nombre" => $row['nombre'], "subtemas" => []];
}

$result = $conn->query("SELECT id, tema_id, nombre FROM subtemas");
while ($row = $result->fetch_assoc()) {
    $tema_id = $row['tema_id'];
    if (isset($temas[$tema_id])) {
        $temas[$tema_id]['subtemas'][] = ["id" => $row['id'], "nombre" => $row['nombre']];
    }
}

echo json_encode($temas);
$conn->close();
?>
