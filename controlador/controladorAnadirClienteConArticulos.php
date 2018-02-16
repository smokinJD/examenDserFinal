<?php

require_once '../modelo/modeloClientes.php';

$pNombre = htmlspecialchars(trim($_POST['nombre']));
$pApellido = htmlspecialchars(trim($_POST['apellido']));
$pTelefono = htmlspecialchars(trim($_POST['telefono']));
$articulo1 = htmlspecialchars(trim($_POST['articulo1']));
$articulo2 = htmlspecialchars(trim($_POST['articulo2']));


$cliente=new Cliente();
$cliente->insertarClienteArticulo($pNombre,$pApellido,$pTelefono, $articulo1, $articulo2);

header('Location: ../controlador/controladorListadoClientes.php');

?>