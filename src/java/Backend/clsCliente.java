package Backend;

import DAO.clsConsultas;


public class clsCliente {
      public String NIT;
      public String NOMBRE;
      public String DIRECCION;
      public Double TELEFONO;
      public String CORREO;

    public clsCliente() {
    }
    
    public clsCliente(String NIT, String NOMBRE, String DIRECCION, Double TELEFONO, String CORREO) {
        this.NIT = NIT;
        this.NOMBRE = NOMBRE;
        this.DIRECCION = DIRECCION;
        this.TELEFONO = TELEFONO;
        this.CORREO = CORREO;
    }

    public String getNIT() {
        return NIT;
    }

    public void setNIT(String NIT) {
        this.NIT = NIT;
    }

    public String getNOMBRE() {
        return NOMBRE;
    }

    public void setNOMBRE(String NOMBRE) {
        this.NOMBRE = NOMBRE;
    }

    public String getDIRECCION() {
        return DIRECCION;
    }

    public void setDIRECCION(String DIRECCION) {
        this.DIRECCION = DIRECCION;
    }

    public Double getTELEFONO() {
        return TELEFONO;
    }

    public void setTELEFONO(Double TELEFONO) {
        this.TELEFONO = TELEFONO;
    }

    public String getCORREO() {
        return CORREO;
    }

    public void setCORREO(String CORREO) {
        this.CORREO = CORREO;
    }

    
      
    public int fncRegistro(clsCliente pCliente) throws Exception{
        int Resp = 0;
        clsConsultas objConsulta = new clsConsultas();
        if (objConsulta.fncRegistrarC(pCliente)==1){
            Resp = 1;
        }
        
        return Resp;
    }  
    
  
}
