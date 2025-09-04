
package Configuraciones;

import java.sql.Connection;
import java.sql.DriverManager;

public class conexion {
    private final String baseDatos = "inventarios";
    private final String servidor = "jdbc:mysql://localhost:3306/" +baseDatos+"?useUnicode=true&characterEncoding=UTF-8";
    private final String usuario = "root";
    private final String clave = "pass";
    
    public Connection conectar(){
        Connection cn = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            cn = DriverManager.getConnection(servidor, usuario, clave);
        }catch(Exception e){
            System.out.println("Error al conectar" + e.getMessage());
        }
        return cn;
    }
            
}
