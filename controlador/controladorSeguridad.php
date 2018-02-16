<?php      

session_start();

if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] == true) {
 ?> 
<p>Hola, <?php echo $_SESSION['username']; ?> <a href="../controlador/controladorCerrarSesion.php">Cerrar sesión</a> </p>

<?php
}else{
    header('location: ../index.php');
}
?>

        <br>