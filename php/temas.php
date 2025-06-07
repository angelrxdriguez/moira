<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "moira";
$conn = new mysqli($host, $user, $pass, $db);
$conn->set_charset("utf8");

$result = $conn->query("SELECT nombre FROM temas ORDER BY nombre");
$temas = [];
while ($row = $result->fetch_assoc()) {
    $temas[] = $row;
}

header('Content-Type: application/json');
echo json_encode($temas);
$conn->close();
?>
