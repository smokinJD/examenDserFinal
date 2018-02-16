<?php

require_once '../modelo/modeloCargarFicheros.php';
$fichero=new Fichero();
$filas = file('../datos/clientes.txt');

foreach ($filas as $value) {
    list($nombre, $apellido, $telefono, $funcion) = explode(":", $value);
    $comprobar = $fichero->comprobarClientes($nombre,$apellido,$telefono);
    echo $telefono;
    if ($comprobar == 0 || $funcion=="I"){
        echo $value;
        $insertar = $fichero->insertarCliente($nombre, $apellido, $telefono);
    } else if ($comprobar == 1 && $funcion=="E"){
        $eliminar = $fichero->eliminarCliente($nombre, $apellido, $telefono);
    }
}


header('Location: ../controlador/controladorListadoClientes.php');


?>