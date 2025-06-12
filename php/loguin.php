<?php
session_start();

$host = "localhost";
$usuario = "root";
$clave = "";
$bd = "moira";

$conn = new mysqli($host, $usuario, $clave, $bd);
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Error de conexión"]);
    exit();
}

$email = $_POST['email'] ?? '';
$contra = $_POST['contra'] ?? '';

if (empty($email) || empty($contra)) {
    echo json_encode(["success" => false, "message" => "Campos vacíos"]);
    exit();
}

$stmt = $conn->prepare("SELECT id, usuario, contrasena, verificado FROM usuarios WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$resultado = $stmt->get_result();

if ($resultado->num_rows === 1) {
    $fila = $resultado->fetch_assoc();

    if ($fila['verificado'] != 1) {
        echo json_encode([
            "success" => false,
            "message" => "Tu cuenta aún no ha sido verificada. Por favor revisa tu correo electrónico."
        ]);
        exit();
    }

    if ($fila['contrasena'] === $contra) {
        $_SESSION['usuario'] = $fila['usuario'];
        $_SESSION['email'] = $email;
        $_SESSION['usuario_id'] = $fila['id'];

        echo json_encode([
            "success" => true,
            "message" => "Sesión iniciada",
            "usuario" => $fila['usuario'],
            "email" => $email
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Contraseña incorrecta"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Usuario no encontrado"]);
}

$stmt->close();
$conn->close();
?>
