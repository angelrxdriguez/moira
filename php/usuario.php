<?php
session_start();
echo json_encode([
  "usuario" => $_SESSION['usuario'] ?? null,
  "email" => $_SESSION['email'] ?? null
]);
?>
