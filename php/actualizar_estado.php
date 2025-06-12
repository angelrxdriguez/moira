<?php
// actualizar_estado.php
session_start();
header("Content-Type: application/json");
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '../vendor/autoload.php'; 

if (!isset($_SESSION['email'])) {
    echo json_encode(["success" => false, "message" => "Sesión no iniciada"]);
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

$id = $_POST['id'] ?? null;
$estado = $_POST['estado'] ?? '';

if (!isset($_POST['id']) || !isset($_POST['estado'])) {
   echo json_encode([
  "success" => false,
  "message" => "Faltan datos POST",
  "post_id" => $_POST['id'] ?? 'no recibido',
  "post_estado" => $_POST['estado'] ?? 'no recibido'
]);
exit;

}

if (!filter_var($id, FILTER_VALIDATE_INT)) {
    echo json_encode([
        "success" => false,
        "message" => "ID inválido",
        "debug" => $id
    ]);
    exit;
}

if (!in_array($estado, ['pendiente', 'aceptado', 'rechazado'])) {
    echo json_encode([
        "success" => false,
        "message" => "Estado inválido",
        "debug" => $estado
    ]);
    exit;
}


if (!filter_var($id, FILTER_VALIDATE_INT) || !in_array($estado, ['pendiente', 'aceptado', 'rechazado'])) {
    echo json_encode(["success" => false, "message" => "Datos inválidos"]);
    exit;
}


$stmt = $conn->prepare("UPDATE solicitudes_servicio SET estado = ? WHERE id = ?");
$stmt->bind_param("si", $estado, $id);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Estado actualizado"]);
        // Obtener datos del usuario que hizo la solicitud
    $stmtInfo = $conn->prepare("SELECT nombre, email FROM solicitudes_servicio WHERE id = ?");
$stmtInfo = $conn->prepare("
    SELECT s.nombre, s.email, s.oferta_id, o.telefono 
    FROM solicitudes_servicio s
    JOIN ofertas o ON s.oferta_id = o.id
    WHERE s.id = ?
");
$stmtInfo->bind_param("i", $id);
$stmtInfo->execute();
$result = $stmtInfo->get_result();
$usuario = $result->fetch_assoc();
$stmtInfo->close();


    // Enviar correo si se aceptó
    if ($estado === 'aceptado') {
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
            $mail->addAddress($usuario['email'], $usuario['nombre']);
 $mail->AddEmbeddedImage('../source/img/moira-logo2.png', 'logo_moira');
            $mail->isHTML(true);
            $mail->Subject = '¡Tu solicitud ha sido aceptada!';
            $mail->Body = "
                <h3>Hola <b>{$usuario['nombre']}</b>,</h3>
                <p>¡Enhorabuena! Tu solicitud ha sido <b>aceptada</b> por el ofertante.</p>
                <p>Puedes ponerte en contacto directamente con el ofertante al número <strong>{$usuario['telefono']}</strong>.</p>

                <br>
                 <img src='cid:logo_moira' alt='Moira Logo' style='width:350px;'>
                <p>Un saludo,<br>El equipo de Moira</p>
            ";

            $mail->send();
        } catch (Exception $e) {
            error_log("Error al enviar correo de aceptación: " . $mail->ErrorInfo);
        }
    }

} else {
    echo json_encode(["success" => false, "message" => "Error al actualizar: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
