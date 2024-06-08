package FRONTEND;

import DAO.clsQuery;

public class clsProducto {
    public int cod_Producto;
    public String nombre;
    public int stock;
    public double precio;
    public String descripcion;
    public String informacion;
    public String garantia;
    public String estatus;

    public clsProducto(int cod_Producto, String nombre, int stock, double precio, String descripcion, String informacion, String garantia, String estatus) {
        this.cod_Producto = cod_Producto;
        this.nombre = nombre;
        this.stock = stock;
        this.precio = precio;
        this.descripcion = descripcion;
        this.informacion = informacion;
        this.garantia = garantia;
        this.estatus = estatus;
    }

    public int getCod_Producto() {
        return cod_Producto;
    }

    public String getNombre() {
        return nombre;
    }

    public int getStock() {
        return stock;
    }

    public double getPrecio() {
        return precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getInformacion() {
        return informacion;
    }

    public String getGarantia() {
        return garantia;
    }

    public String getEstatus() {
        return estatus;
    }
    

    public int fncActualizarStockProducto(int cod_Producto, int cantidadRestar) throws Exception {
        int respuesta = 0;
        clsQuery objConsulta = new clsQuery();
        respuesta = objConsulta.actualizarCantidadProducto(cod_Producto, cantidadRestar);
        return respuesta;
    }
}
