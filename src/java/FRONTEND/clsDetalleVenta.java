package FRONTEND;
import DAO.clsQuery;
import java.util.List;

public class clsDetalleVenta {
    
    public int ID_DETALLE;
    public int FACTURA;
    public int COD_PRODUCTO;
    public int CANTIDAD;
    public double PRECIO;

    public clsDetalleVenta() {
    }

    public int getID_DETALLE() {
        return ID_DETALLE;
    }

    public void setID_DETALLE(int ID_DETALLE) {
        this.ID_DETALLE = ID_DETALLE;
    }

    public int getFACTURA() {
        return FACTURA;
    }

    public void setFACTURA(int FACTURA) {
        this.FACTURA = FACTURA;
    }

    public int getCOD_PRODUCTO() {
        return COD_PRODUCTO;
    }

    public void setCOD_PRODUCTO(int COD_PRODUCTO) {
        this.COD_PRODUCTO = COD_PRODUCTO;
    }

    public int getCANTIDAD() {
        return CANTIDAD;
    }

    public void setCANTIDAD(int CANTIDAD) {
        this.CANTIDAD = CANTIDAD;
    }

    public double getPRECIO() {
        return PRECIO;
    }

    public void setPRECIO(double PRECIO) {
        this.PRECIO = PRECIO;
    }
    
    public int fncingresoDetalleVenta(clsDetalleVenta pDetalleVenta, List<clsDetalleVenta> pDetallesVenta) throws Exception {
    int Resp = 0;
    clsQuery objConsulta = new clsQuery();
    if (objConsulta.fncIngresoDetalleVenta(pDetalleVenta) == 1) {
        Resp = 1;
    }
    return Resp;
       }    
   }