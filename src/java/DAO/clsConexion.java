package DAO;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class clsConexion {

    private String cadenaConexion = "jdbc:sqlserver://localhost; databaseName=BD_Ferreteria; password=Sergio123;";

    public Connection conectar() throws SQLException {
        Connection cn = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            cn = DriverManager.getConnection(cadenaConexion);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Error al cargar el driver de SQL Server", e);
        }

        return cn;
    }
}
