<?php
session_start();
echo json_encode([
  "usuario" => isset($_SESSION['usuario']) ? $_SESSION['usuario'] : null
]);
?>
