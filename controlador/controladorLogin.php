<?php

session_start();
$usuario = $_POST['usuario'];
$contrasena = $_POST['password'];
require_once '../modelo/modeloUsuarios.php';

$cont=new Usuario();
$datos=$cont->comprobarUsuario($usuario, $contrasena);

if ($datos == 1){
    $_SESSION['loggedin'] = true;
    $_SESSION['username'] = $usuario;
    $_SESSION['start'] = time();
    $_SESSION['expire'] = $_SESSION['start'] + (30 * 60);

    header('location: ../vista/menu.php');
}else{
    echo '<script>alert ("Usuario o contrase�a incorrectos");</script><meta http-equiv="refresh" content="0; url=../index.php">';
}

?>