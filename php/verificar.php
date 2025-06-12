<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "moira";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

if (!isset($_GET['token'])) {
    die("Token de verificación no válido.");
}

$token = $_GET['token'];

// Buscar usuario por token
$stmt = $conn->prepare("SELECT id FROM usuarios WHERE token_verificacion = ? AND verificado = 0");
$stmt->bind_param("s", $token);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $usuario = $result->fetch_assoc();
    $idUsuario = $usuario['id'];

    // Activar cuenta y limpiar token
    $update = $conn->prepare("UPDATE usuarios SET verificado = 1, token_verificacion = NULL WHERE id = ?");
    $update->bind_param("i", $idUsuario);
    if ($update->execute()) {
     header("Location: ../sesion.html");
    } else {
        echo "Error al verificar la cuenta.";
    }
} else {
    echo "<h4>Este enlace ya no es válido o el usuario ya fue verificado.</h4>";
}

$stmt->close();
$conn->close();
?>
