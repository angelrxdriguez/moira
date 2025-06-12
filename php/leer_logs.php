<?php
header('Content-Type: application/json');

$logPath = '../logs/registro.log';

if (!file_exists($logPath)) {
  echo json_encode(["success" => false, "message" => "El archivo de logs no existe."]);
  exit;
}

$lineas = file($logPath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

echo json_encode([
  "success" => true,
  "logs" => $lineas
]);
