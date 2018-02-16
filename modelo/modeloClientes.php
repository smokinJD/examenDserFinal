<?php
require_once '../core/conector.php';

class Cliente {
    private $link;
    private $cliente;
    
    public function __construct(){
        $this->link=Conectar::conexion();
        $this->cliente=array();
    }
    
    public function obtenerClientes() {
        $sql="CALL spMostrarClientes()"; 
        $consulta=$this->link->query($sql);
        while ($row = mysqli_fetch_array($consulta, MYSQLI_ASSOC)){
            $this->cliente[]=$row; 
        }
        $consulta->free_result();
        $this->link->close();
        return $this->cliente;
    } 
    
    public function obtenerClientesArticulos() {
        $sql="CALL spMostrarClientesArticulos()"; 
        $consulta=$this->link->query($sql);
        while ($row = mysqli_fetch_array($consulta, MYSQLI_ASSOC)){
            $this->cliente[]=$row; 
        }
        $consulta->free_result();
        $this->link->close();
        return $this->cliente;
    }
    
    
        public function insertarCliente($pNombre, $pApellido,$pTelefono ) {
        $consulta=$this->link->query("CALL spInsertarCliente('$pNombre', '$pApellido','$pTelefono')");
    }
    
    public function insertarClienteArticulo($pNombre, $pApellido,$pTelefono,$articulo1, $articulo2) {
        $this->link->autocommit(false);
        $stop = false;
        $sql1= "CALL spInsertarCliente('$pNombre', '$pApellido','$pTelefono')";
        $consulta=$this->link->query($sql1);
        
        // Código para seleccionar el id del cliente introducido
        foreach ($consulta as $res){
          $idClientearr=$res;
        }
        $idCliente = $idClientearr['ultimoId'];
        
        
        if ($this->link->errno) {
            $stop = true; // Si entro aqui, habra un error, entonces STOP!
            echo "Error: " . $this->link->error . ". ";
        }
        
        // codigo para liberar el result
        while($this->link->more_results()){
          $this->link->next_result();
          $this->link->use_result();
        }
        
        //segundo SQL
        $sql2= "CALL spInsertarClienteArticulo('$idCliente', '$articulo1')";
        $consulta=$this->link->query($sql2);
        
        if ($this->link->errno) {
            $stop = true; // Si entro aqui, habra un error, entonces STOP!
            echo "Error: " . $this->link->error . ". ";
        }
        
        // codigo para liberar el result
        while($this->link->more_results()){
          $this->link->next_result();
          $this->link->use_result();
        }
        
        //segundo SQL
        $sql3= "CALL spInsertarClienteArticulo('$idCliente', '$articulo2')";
        $consulta=$this->link->query($sql3);
        
        if ($this->link->errno) {
            $stop = true; // Si entro aqui, habra un error, entonces STOP!
            echo "Error: " . $this->link->error . ". ";
        }
        
        // codigo para liberar el result
        while($this->link->more_results()){
          $this->link->next_result();
          $this->link->use_result();
        }
        
        if ($stop == false) { // Si no ha habido ningun error, se meteran a la base de datos todos los querys
            $this->link->commit();
            echo "Datos insertados correctamente";
        } else {
            $this->link->rollback(); // Si hay error, se anulan todos los querys
            echo "No se han metido datos a la base de datos";
        }
          $this->link=null;
        }
}
?>