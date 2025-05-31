<?php
$host = "localhost";
$usuario = "root";
$clave = "";
$bd = "moira";

$conn = new mysqli($host, $usuario, $clave, $bd);
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuario = trim($_POST['usuario'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $contra = $_POST['contra'] ?? '';
    $repiteContra = $_POST['repiteContra'] ?? '';
    $fechaNacimiento = $_POST['fechaNacimiento'] ?? '';

    if ($contra !== $repiteContra) {
        die("Las contraseñas no coinciden.");
    }

    $stmt_check = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
    $stmt_check->bind_param("s", $email);
    $stmt_check->execute();
    $stmt_check->store_result();

 if ($stmt_check->num_rows > 0) {
    header("Location: ../sesion.html");
    exit();
}


    $hash = password_hash($contra, PASSWORD_BCRYPT);
    $stmt = $conn->prepare("INSERT INTO usuarios (usuario, email, contrasena, fecha_nacimiento) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $usuario, $email, $hash, $fechaNacimiento);

    if ($stmt->execute()) {
        header("Location: ../sesion.html");
        exit();
    } else {
        echo "Error al registrar: " . $stmt->error;
    }

    $stmt->close();
}
$conn->close();
?>
