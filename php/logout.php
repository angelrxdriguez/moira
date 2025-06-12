<?php
session_start();

if (isset($_SESSION['usuario']) && isset($_SESSION['email'])) {
    $usuario = $_SESSION['usuario'];
    $email = $_SESSION['email'];

    $logMsg = "[" . date("Y-m-d H:i:s") . "] Cierre de sesión: Usuario '$usuario' con email '$email'\n";
    file_put_contents("../logs/registro.log", $logMsg, FILE_APPEND);
}

session_unset();
session_destroy();

echo json_encode(["success" => true]);
