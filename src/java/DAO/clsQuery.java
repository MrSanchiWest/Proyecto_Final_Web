package DAO;
import Backend.clsProducto;
import FRONTEND.clsDetalleVenta;
import FRONTEND.clsVenta;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class clsQuery {
    public clsQuery() {
    }
    
    public int fncIngresoProducto(clsProducto pProducto) throws Exception {
        int Resp = 0; // 0 no se ingresó.
        clsConexion Con = new clsConexion(); 
        Connection cn = Con.conectar();
        try {
            String consulta = "INSERT INTO TB_PRODUCTO (COD_PRODUCTO, NOMBRE, STOCK, PRECIO, DESCRIPCION, INFORMACION, GARANTIA, ESTATUS) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = cn.prepareStatement(consulta);
            ps.setInt(1, pProducto.getCodProducto());
            ps.setString(2, pProducto.getNombreProducto());
            ps.setInt(3, pProducto.getStock());
            ps.setDouble(4, pProducto.getPrecio());
            ps.setString(5, pProducto.getDescripcion());
            ps.setString(6, pProducto.getInformacion());
            ps.setString(7, pProducto.getGarantia());
            ps.setString(8, pProducto.getEstatus());
            ps.executeUpdate();
            Resp = 1;
        } catch (SQLException Ex) {
            System.out.println(Ex.getMessage());
        }
        return Resp;
    }
    
    public int fncModificaProducto(clsProducto pProducto) throws Exception {
        int Resp = 0; // 0 no se ingresó.
        try {
            clsConexion Con = new clsConexion(); 
            Connection cn = Con.conectar();
            String consulta = "UPDATE TB_PRODUCTO "
                    + "SET NOMBRE = ?, STOCK = ?, PRECIO = ?, DESCRIPCION = ?, INFORMACION = ?, GARANTIA = ?, ESTATUS = ? "
                    + "WHERE COD_PRODUCTO = ?";
            PreparedStatement ps = cn.prepareStatement(consulta);
            ps.setString(1, pProducto.getNombreProducto());
            ps.setInt(2, pProducto.getStock());
            ps.setDouble(3, pProducto.getPrecio());
            ps.setString(4, pProducto.getDescripcion());
            ps.setString(5, pProducto.getInformacion());
            ps.setString(6, pProducto.getGarantia());
            ps.setString(7, pProducto.getEstatus());
            ps.setInt(8, pProducto.getCodProducto());
            ps.executeUpdate(); // Ejecuta la sentencia en la base de datos
            Resp = 1;
            System.out.println("CORRECTO");
        } catch (SQLException Ex) {
            System.out.println(Ex.getMessage());
        }
        return Resp;
    }
    
    public int fncEliminaProducto(int codProducto) throws Exception {
        int Resp = 0;
        try {
            clsConexion Con = new clsConexion(); 
            Connection cn = Con.conectar();
            String consulta = "DELETE FROM TB_PRODUCTO WHERE COD_PRODUCTO = ?";   
            PreparedStatement ps = cn.prepareStatement(consulta);  
            ps.setInt(1, codProducto);
            ps.executeUpdate();
            Resp = 1;
        } catch (SQLException Ex) {
            System.out.println(Ex.getMessage());
        }
        return Resp;
    }
    
public List<clsProducto> fncObtenerInventario() throws Exception {
        List<clsProducto> inventario = new ArrayList<>(); // Lista para almacenar productos
        clsConexion Con = new clsConexion(); 
        Connection cn = Con.conectar();
        ResultSet rs = null;
        try {
            String consulta = "SELECT COD_PRODUCTO, NOMBRE, STOCK, PRECIO FROM TB_PRODUCTO"; // Consulta con columnas específicas
            PreparedStatement ps = cn.prepareStatement(consulta);
            rs = ps.executeQuery(); // Ejecutar consulta y guardar resultado en el ResultSet
            // Recorrer ResultSet y agregar productos a la lista
            while (rs.next()) {
                clsProducto producto = new clsProducto();
                producto.setCodProducto(rs.getInt("COD_PRODUCTO"));
                producto.setNombreProducto(rs.getString("NOMBRE"));
                producto.setStock(rs.getInt("STOCK"));
                producto.setPrecio(rs.getDouble("PRECIO"));
                inventario.add(producto);
            }
        } catch (SQLException Ex) {
            System.out.println(Ex.getMessage());
        } finally {
            if (rs != null) {
                rs.close(); // Cerrar ResultSet
            }
        }
        return inventario; // Devolver lista de productos
    }

public clsProducto obtenerProductoPorCodigo(int codigoProducto) throws SQLException, ClassNotFoundException, Exception {
    String query = "SELECT * FROM TB_PRODUCTO WHERE COD_PRODUCTO = ?";
    clsConexion con = new clsConexion();
    try (Connection cn = con.conectar();
         PreparedStatement ps = cn.prepareStatement(query)) {
        ps.setInt(1, codigoProducto);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new clsProducto(
                    rs.getInt("COD_PRODUCTO"),
                    rs.getString("NOMBRE"),
                    rs.getInt("STOCK"),
                    rs.getDouble("PRECIO"),
                    rs.getString("DESCRIPCION"),
                    rs.getString("INFORMACION"),
                    rs.getString("GARANTIA"),
                    rs.getString("ESTATUS")
                );
            }
        }
    }
    return null;
}

public int actualizarCantidadProducto(int codigoProducto, int cantidadRestar) throws SQLException, ClassNotFoundException, Exception {
    int respuesta = 0; // 0 indica que no se actualizó.
    clsConexion con = new clsConexion();
    String queryObtenerProducto = "SELECT STOCK FROM TB_PRODUCTO WHERE COD_PRODUCTO = ?";
    String queryActualizarProducto = "UPDATE TB_PRODUCTO SET STOCK = ? WHERE COD_PRODUCTO = ?";

    try (Connection cn = con.conectar()) {
        // Inicia transacción
        cn.setAutoCommit(false);

        // Obtener la cantidad actual del producto
        try (PreparedStatement psObtenerProducto = cn.prepareStatement(queryObtenerProducto)) {
            psObtenerProducto.setInt(1, codigoProducto);
            try (ResultSet rs = psObtenerProducto.executeQuery()) {
                if (rs.next()) {
                    int cantidadActual = rs.getInt("STOCK");
                    if (cantidadActual >= cantidadRestar) {
                        int nuevaCantidad = cantidadActual - cantidadRestar;

                        // Actualizar la cantidad del producto
                        try (PreparedStatement psActualizarProducto = cn.prepareStatement(queryActualizarProducto)) {
                            psActualizarProducto.setInt(1, nuevaCantidad);
                            psActualizarProducto.setInt(2, codigoProducto);
                            psActualizarProducto.executeUpdate();

                            // Confirmar transacción
                            cn.commit();
                            respuesta = 1; // 1 indica que la actualización fue exitosa.
                        }
                    } else {
                        // La cantidad a restar es mayor que la cantidad actual, no se puede realizar la operación
                        throw new Exception("La cantidad a restar es mayor que la cantidad actual en stock.");
                    }
                } else {
                    // No se encontró el producto con el código proporcionado
                    throw new Exception("No se encontró el producto con el código proporcionado.");
                }
            }
        } catch (SQLException ex) {
            // En caso de error, deshace la transacción
            cn.rollback();
            System.out.println(ex.getMessage());
            throw ex;
        } finally {
            // Restaurar autocommit a true
            cn.setAutoCommit(true);
        }
    }
    return respuesta;
}

public int fncIngresoVenta(clsVenta pVenta) throws Exception {
    int Resp = 0; // 0 no se ingresó.
    clsConexion Con = new clsConexion(); 
    Connection cn = Con.conectar();
    try {
        // Inicia transacción
        cn.setAutoCommit(false);

        // Inserta venta
        String consultaVenta = "INSERT INTO TB_VENTA (FACTURA, NIT, FECHA, MEDIO, COD_USUARIO, ESTATUS) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement psVenta = cn.prepareStatement(consultaVenta);
        psVenta.setInt(1, pVenta.getFactura());
        psVenta.setString(2, pVenta.getNIT());
        psVenta.setDate(3, java.sql.Date.valueOf(pVenta.getFECHA()));
        psVenta.setInt(4, pVenta.getMEDIO());
        psVenta.setInt(5, pVenta.getCOD_USUARIO());
        psVenta.setString(6, pVenta.getESTATUS());
        psVenta.executeUpdate();
        // Confirma transacción
        cn.commit();
        Resp = 1;
    } catch (SQLException Ex) {
        // En caso de error, deshace la transacción
        cn.rollback();
        System.out.println(Ex.getMessage());
    } finally {
        // Restaurar autocommit a true
        cn.setAutoCommit(true);
    }
    return Resp;
}

public int fncIngresoDetalleVenta(clsDetalleVenta pDetalleVenta) throws Exception {
    int Resp = 0; // 0 no se ingresó.
    clsConexion Con = new clsConexion(); 
    Connection cn = Con.conectar();
    try {
        // Inicia transacción
        cn.setAutoCommit(false);

        // Inserta detalle venta
        String consultaDetalleVenta = "INSERT INTO TB_DETALLE_VENTA (FACTURA, COD_PRODUCTO, CANTIDAD, PRECIO) VALUES (?, ?, ?, ?)";
        PreparedStatement psDetalleVenta = cn.prepareStatement(consultaDetalleVenta);
        psDetalleVenta.setInt(1, pDetalleVenta.getFACTURA());
        psDetalleVenta.setInt(2, pDetalleVenta.getCOD_PRODUCTO());
        psDetalleVenta.setInt(3, pDetalleVenta.getCANTIDAD());
        psDetalleVenta.setDouble(4, pDetalleVenta.getPRECIO());
        psDetalleVenta.executeUpdate();
        // Confirma transacción
        cn.commit();
        Resp = 1;
    } catch (SQLException Ex) {
        // En caso de error, deshace la transacción
        cn.rollback();
        System.out.println(Ex.getMessage());
    } finally {
        // Restaurar autocommit a true
        cn.setAutoCommit(true);
    }
    return Resp;
}

}
