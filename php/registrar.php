<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '../vendor/autoload.php'; // Ajusta el path si hace falta

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
        header("Location: ../sesion.html?error=email");
        exit();
    }

    $stmt = $conn->prepare("INSERT INTO usuarios (usuario, email, contrasena, fecha_nacimiento) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $usuario, $email, $contra, $fechaNacimiento);

    if ($stmt->execute()) {
    // Guardar log de registro
    $logMsg = "[" . date("Y-m-d H:i:s") . "] Registro exitoso: Usuario '$usuario' con email '$email'\n";
    file_put_contents("../logs/registro.log", $logMsg, FILE_APPEND);

    // Envío de correo con PHPMailer
    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;
        $mail->Username = 'panaderorodriguezangel.sangrina@gmail.com';
        $mail->Password = 'mljq nlhv kzcw vwgh';
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        $mail->setFrom('panaderorodriguezangel.sangrina@gmail.com', 'Equipo Moira');
        $mail->addAddress($email, $usuario);

        $mail->isHTML(true);
        $mail->Subject = 'Bienvenido a Moira';
        $mail->AddEmbeddedImage('../source/img/moira-logo2.png', 'logo_moira');

        $mail->Body = "
            <h3>Hola <b>$usuario</b>,</h3>
            <p>Gracias por registrarte en Moira.</p>
            <p>Ya puedes acceder a tu cuenta. ¡Trabaja Inteligente y pide un Moira!</p>
            <br>
            <img src='cid:logo_moira' alt='Moira Logo' style='width:350px;'>
            <p>Un saludo,<br>El equipo de Moira</p>
        ";

        $mail->send();
    } catch (Exception $e) {
        // Puedes hacer log de error si lo deseas también
    }

    header("Location: ../sesion.html?registro=exito");
    exit();
}
 else {
        echo "Error al registrar: " . $stmt->error;
    }

    $stmt->close();
}
$conn->close();
