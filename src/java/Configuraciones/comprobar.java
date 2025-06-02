
package Configuraciones;

import Configuraciones.conexion;


public class comprobar {
    public static void main(String[] args){
        conexion c = new conexion();
        if(c.conectar()!= null){
            System.out.println("conexion es correcta");
        }else{
            System.out.println("conexion erronea");
        }
    }
}
