<?php
require_once '../core/conector.php';
class Fichero{
    private $link;
    private $cliente;
    
    public function __construct(){
        $this->link=Conectar::conexion();
        $this->cliente=array();
    }
    
    public function comprobarClientes($nombre, $apellido, $telefono){
        $sql="SELECT `comprobarCliente`(?,?,?) AS `existe`";// ? el simbolo de interrogacion es el parametro
        $sqlPrep = $this->link->prepare($sql);
    	$sqlPrep->bind_param("sss",$nombre,$apellido,$telefono);
        $sqlPrep->execute();
        
        $result=$sqlPrep->get_result();
     	if($result->num_rows>0){
     		while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
                    $this->cliente[]=$row; 
                }
                return $this->cliente[0]["existe"];
     	}
    }
    
    public function insertarCliente($nombre,$apellido,$telefono) {
        $sql=$this->link->query("CALL spInsertarCliente(?,?,?)");
        $sqlPrep = $this->link->prepare($sql);
    	$sqlPrep->bind_param("sss", $nombre,$apellido,$telefono);
        $sqlPrep->execute();
        $this->link->close();
    }
    
    public function eliminarCliente($pNombre, $pApellido,$pTelefono ) {
        $sql=$this->link->query("CALL spEliminarCliente(?,?,?)");
        $sqlPrep = $this->link->prepare($sql);
    	$sqlPrep->bind_param("sss",$pNombre,$pApellido,$pTelefono);
        $sqlPrep->execute();
        $this->link->close();
    }

            
}

?>