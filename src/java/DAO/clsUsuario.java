/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class clsUsuario {
    private clsConexion conexion;

    public clsUsuario() {
        conexion = new clsConexion();
    }

    public boolean existeUsuario(String nombre, String pass) throws SQLException {
        boolean existe = false;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = conexion.conectar();
            ps = cn.prepareStatement("SELECT NOMBRE, PASS FROM TB_USUARIO WHERE NOMBRE = ? AND PASS = ?");
            ps.setString(1, nombre);
            ps.setString(2, pass);
            rs = ps.executeQuery();

            if (rs.next()) {
                existe = true;
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }

        return existe;
    }
}
