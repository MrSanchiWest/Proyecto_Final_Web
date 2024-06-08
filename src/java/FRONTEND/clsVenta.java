
package FRONTEND;

import DAO.clsQuery;
import java.util.List;


public class clsVenta {
    
    public int Factura;
    public String NIT;
    public String FECHA;
    public int MEDIO;
    public int COD_USUARIO;
    public String ESTATUS;

    public clsVenta() {
    }

    public int getFactura() {
        return Factura;
    }

    public void setFactura(int Factura) {
        this.Factura = Factura;
    }

    public String getNIT() {
        return NIT;
    }

    public void setNIT(String NIT) {
        this.NIT = NIT;
    }

    public String getFECHA() {
        return FECHA;
    }

    public void setFECHA(String FECHA) {
        this.FECHA = FECHA;
    }

    public int getMEDIO() {
        return MEDIO;
    }

    public void setMEDIO(int MEDIO) {
        this.MEDIO = MEDIO;
    }

    public int getCOD_USUARIO() {
        return COD_USUARIO;
    }

    public void setCOD_USUARIO(int COD_USUARIO) {
        this.COD_USUARIO = COD_USUARIO;
    }

    public String getESTATUS() {
        return ESTATUS;
    }

    public void setESTATUS(String ESTATUS) {
        this.ESTATUS = ESTATUS;
    }
    
    public int fncRegistro(clsVenta pVenta, List<clsDetalleVenta> pDetallesVenta) throws Exception {
    int Resp = 0;
    clsQuery objConsulta = new clsQuery();
    if (objConsulta.fncIngresoVenta(pVenta) == 1) {
        Resp = 1;
    }
    return Resp;
}
    
}
