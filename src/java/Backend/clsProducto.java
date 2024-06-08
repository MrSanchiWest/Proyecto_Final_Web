/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Backend;

import DAO.clsQuery;
import java.util.List; 


public class clsProducto {
    private int codProducto;
    private String nombreProducto;
    private int stock;
    private double precio;
    private String descripcion;
    private String informacion;
    private String garantia;
    private String estatus;

    public clsProducto() {
    }

    public clsProducto(int codProducto, String nombreProducto, int stock, double precio, String descripcion, String informacion, String garantia, String estatus) {
        this.codProducto = codProducto;
        this.nombreProducto = nombreProducto;
        this.stock = stock;
        this.precio = precio;
        this.descripcion = descripcion;
        this.informacion = informacion;
        this.garantia = garantia;
        this.estatus = estatus;
    }

    // Métodos getters y setters

    public int getCodProducto() {
        return codProducto;
    }

    public void setCodProducto(int codProducto) {
        this.codProducto = codProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getInformacion() {
        return informacion;
    }

    public void setInformacion(String informacion) {
        this.informacion = informacion;
    }

    public String getGarantia() {
        return garantia;
    }

    public void setGarantia(String garantia) {
        this.garantia = garantia;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    // Métodos para operaciones CRUD

    public int fncRegistro(clsProducto pProducto) throws Exception {
        int Resp = 0;
        clsQuery objConsulta = new clsQuery();
        if (objConsulta.fncIngresoProducto(pProducto) == 1) {
            Resp = 1;
        }
        return Resp;
    }

    public int fncModifica(clsProducto pProducto) throws Exception {
        int Resp = 0;
        clsQuery objConsulta = new clsQuery();
        if (objConsulta.fncModificaProducto(pProducto) == 1) {
            Resp = 1;
        }
        return Resp;
    }

    public int fncElimina(int codProducto) throws Exception {
        int Resp = 0;
        clsQuery objConsulta = new clsQuery();
        if (objConsulta.fncEliminaProducto(codProducto) == 1) {
            Resp = 1;
        }
        return Resp;
    }
    
public List<clsProducto> obtenerInventario() throws Exception {
        clsQuery objConsulta = new clsQuery();
        return objConsulta.fncObtenerInventario(); // Devolver lista de productos
    }
}
