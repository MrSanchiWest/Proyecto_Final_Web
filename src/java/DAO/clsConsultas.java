package DAO;

import Backend.clsCliente;
import Backend.clsUsuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class clsConsultas {

    public int fncRegistrarC(clsCliente pCliente) throws Exception {
        int Resp = 0; // 0 no se ingresó.
        clsConexion Con = new clsConexion();
        Connection cn = Con.conectar();
        try {
            String consulta = "INSERT INTO TB_CLIENTE (NIT, NOMBRE, DIRECCION, TELEFONO, CORREO)"
                    + "VALUES (?, ?, ?, ?, ?)";
            System.out.println(consulta);
            PreparedStatement ps = cn.prepareStatement(consulta);
            ps.setString(1, pCliente.getNIT());
            ps.setString(2, pCliente.getNOMBRE());
            ps.setString(3, pCliente.getDIRECCION());
            ps.setDouble(4, pCliente.getTELEFONO());
            ps.setString(5, pCliente.getCORREO());
            ps.executeUpdate();
            Resp = 1;

        } catch (SQLException Ex) {
            System.out.println(Ex.getMessage());
        }
        return Resp;
    }

    public int fncRegistrarU(clsUsuario pUsuario) throws Exception {
        int Resp = 0; // 0 no se ingresó.
        clsConexion Con = new clsConexion();
        Connection cn = Con.conectar();
        try {
            String consulta = "INSERT INTO TB_USUARIO (COD_USUARIO, NOMBRE, APELLIDO, PASS, ESTATUS)"
                    + "VALUES (?, ?, ?, ?, ?)";
            System.out.println(consulta);
            PreparedStatement ps = cn.prepareStatement(consulta);
            ps.setString(1, pUsuario.getCOD());
            ps.setString(2, pUsuario.getNOMBRE());
            ps.setString(3, pUsuario.getAPELLIDO());
            ps.setString(4, pUsuario.getPASS());
            ps.setString(5, pUsuario.getESTATUS());

            ps.executeUpdate();
            Resp = 1;

        } catch (SQLException Ex) {
            System.out.println(Ex.getMessage());
        }
        return Resp;
    }

    public int fncActualizarEstatus(String codUsuario, String nuevoEstatus) throws Exception {
        int Resp = 0;
        clsConexion Con = new clsConexion();
        Connection cn = Con.conectar();
        try {
            String consulta = "UPDATE TB_USUARIO SET ESTATUS = ? WHERE COD_USUARIO = ?";
            System.out.println(consulta);
            PreparedStatement ps = cn.prepareStatement(consulta);
            ps.setString(1, nuevoEstatus);
            ps.setString(2, codUsuario);
            ps.executeUpdate();
            Resp = 1;
        } catch (SQLException Ex) {
            System.out.println(Ex.getMessage());
        }
        return Resp;
    }
    
    
    
}