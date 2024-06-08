<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Backend.clsProducto"%>
<%@page import="java.util.List"%>

<script src="LibJavaScript.js" type="text/javascript"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

<!DOCTYPE html>
<%
    String flgFormulario = "display:block";
    String flgTabla = "display:block";
    String flgMensaje = "display:none";
    String Titulo = "TITULO DEL MENSAJE";
    String Mensaje = "MENSAJE DE SALIDA PARA EL USUARIO";

    String Operacion = request.getParameter("cbOperacion");

    if (Operacion != null) {
        switch (Integer.parseInt(Operacion)) {
            case 1: // Registrar Producto
                if (request.getParameter("pCodigoProducto") != null &&
                    request.getParameter("pNombreProducto") != null &&
                    request.getParameter("pStockDisponible") != null &&
                    request.getParameter("pDescripcion") != null &&
                    request.getParameter("pMasInformacion") != null &&
                    request.getParameter("pGarantia") != null &&
                    request.getParameter("pPrecioUnitario") != null) {

                    clsProducto objProducto = new clsProducto();
                    objProducto.setCodProducto(Integer.parseInt(request.getParameter("pCodigoProducto")));
                    objProducto.setNombreProducto(request.getParameter("pNombreProducto"));
                    objProducto.setStock(Integer.parseInt(request.getParameter("pStockDisponible")));
                    objProducto.setDescripcion(request.getParameter("pDescripcion"));
                    objProducto.setInformacion(request.getParameter("pMasInformacion"));
                    objProducto.setGarantia(request.getParameter("pGarantia"));
                    objProducto.setPrecio(Double.parseDouble(request.getParameter("pPrecioUnitario")));
                    objProducto.setEstatus(request.getParameter("pEstado"));

                    int Resp = objProducto.fncRegistro(objProducto);
                    if (Resp == 1) {
                        Mensaje = "PRODUCTO REGISTRADO CORRECTAMENTE";
                        flgMensaje = "display:block";
                        flgFormulario = "display:none";
                        flgTabla = "display:none";
                    } else {
                        Mensaje = "NO SE PUEDE REGISTRAR EL PRODUCTO";
                        flgMensaje = "display:block";
                        flgFormulario = "display:none";
                        flgTabla = "display:none";
                    }
                } else {
                    Mensaje = "NO SE PUEDE REGISTRAR EL PRODUCTO";
                    flgMensaje = "display:block";
                    flgFormulario = "display:none";
                    flgTabla = "display:none";
                }
                break;
            case 2: // Modificar Producto
                if (request.getParameter("pCodigoProducto") != null &&
                    request.getParameter("pNombreProducto") != null &&
                    request.getParameter("pStockDisponible") != null &&
                    request.getParameter("pDescripcion") != null &&
                    request.getParameter("pMasInformacion") != null &&
                    request.getParameter("pGarantia") != null &&
                    request.getParameter("pPrecioUnitario") != null) {

                    clsProducto objProducto = new clsProducto();
                    objProducto.setCodProducto(Integer.parseInt(request.getParameter("pCodigoProducto")));
                    objProducto.setNombreProducto(request.getParameter("pNombreProducto"));
                    objProducto.setStock(Integer.parseInt(request.getParameter("pStockDisponible")));
                    objProducto.setDescripcion(request.getParameter("pDescripcion"));
                    objProducto.setInformacion(request.getParameter("pMasInformacion"));
                    objProducto.setGarantia(request.getParameter("pGarantia"));
                    objProducto.setPrecio(Double.parseDouble(request.getParameter("pPrecioUnitario")));
                    objProducto.setEstatus(request.getParameter("pEstado"));
                    int Resp = objProducto.fncModifica(objProducto);
                    if (Resp == 1) {
                        Mensaje = "PRODUCTO MODIFICADO CORRECTAMENTE";
                        flgMensaje = "display:block";
                        flgFormulario = "display:none";
                        flgTabla = "display:none";
                    } else {
                        Mensaje = "NO SE PUEDE MODIFICAR EL PRODUCTO";
                        flgMensaje = "display:block";
                        flgFormulario = "display:none";
                        flgTabla = "display:none";
                    }
                } else {
                    Mensaje = "NO SE PUEDE MODIFICAR EL PRODUCTO";
                    flgMensaje = "display:block";
                    flgFormulario = "display:none";
                    flgTabla = "display:none";
                }
                break;
            case 3: // Eliminar Producto
                if (request.getParameter("pCodigoProducto") != null) {
                    clsProducto objProducto = new clsProducto();
                    objProducto.fncElimina(Integer.parseInt(request.getParameter("pCodigoProducto")));

                    Mensaje = "PRODUCTO ELIMINADO CORRECTAMENTE";
                    flgMensaje = "display:block";
                    flgFormulario = "display:none";
                    flgTabla = "display:none";
                } else {
                    Mensaje = "NO SE PUEDE ELIMINAR EL PRODUCTO";
                    flgMensaje = "display:block";
                    flgFormulario = "display:none";
                    flgTabla = "display:none";
                }
                break;
        }
    }
    

    clsProducto objProducto = new clsProducto();
    List<clsProducto> inventario = objProducto.obtenerInventario();
    request.setAttribute("inventario", inventario);

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SISTEMA DE INVENTARIO</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="alert alert-warning text-center">
                <h1>REGISTRO DE PRODUCTOS</h1>
            </div>
            <div class="d-flex">
                <div class="col-sm-6">
                    <form method="post" action="index.jsp" id="Formulario" style="<%=flgFormulario%>">
                        <div class="mb-3 row">
                            <label for="cbOperacion" class="col-sm-2 col-form-label">OPERACION:</label>
                            <div class="col-sm-10">
                                <select class="form-select" id="cbOperacion" name="cbOperacion">
                                    <option value="0">Seleccione Operacion</option>
                                    <option value="1">Registrar Producto</option>
                                    <option value="2">Modificar Producto</option>
                                    <option value="3">Eliminar Producto</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="pCodigoProducto" class="col-sm-2 col-form-label">Código:</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" id="pCodigoProducto" name="pCodigoProducto" placeholder="INGRESE CÓDIGO">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="pNombreProducto" class="col-sm-2 col-form-label">Nombre:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="pNombreProducto" name="pNombreProducto" placeholder="INGRESE NOMBRE">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="pStockDisponible" class="col-sm-2 col-form-label">Stock:</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" id="pStockDisponible" name="pStockDisponible" placeholder="INGRESE STOCK">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="pDescripcion" class="col-sm-2 col-form-label">Descripción:</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" id="pDescripcion" name="pDescripcion" placeholder="INGRESE DESCRIPCIÓN"></textarea>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="pMasInformacion" class="col-sm-2 col-form-label">Más Información:</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" id="pMasInformacion" name="pMasInformacion" placeholder="INGRESE INFORMACIÓN"></textarea>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="pGarantia" class="col-sm-2 col-form-label">Garantía:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="pGarantia" name="pGarantia" placeholder="INGRESE GARANTÍA">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="pPrecioUnitario" class="col-sm-2 col-form-label">Precio Unitario:</label>
                            <div class="col-sm-10">
                                <input type="number" step="0.01" class="form-control" id="pPrecioUnitario" name="pPrecioUnitario" placeholder="INGRESE PRECIO">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="pEstado" class="col-sm-2 col-form-label">Estado:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="pEstado" name="pEstado" placeholder="INGRESE ESTADO">
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-success">EJECUTAR</button>
                        </div>
                        
                        <div class="text-right">
                            <button type="button" class="btn btn-secondary">VOLVER</button>
                        </div>
                    </form>
                </div>

                <div class="col-sm-7">
                    
                    
<table class="table col-sm-8" action="index.jsp" id="TablaInventario" style="<%=flgTabla%>">
           
   
</div>
    <br> 
 <caption style="caption-side: top; text-align: center;">INVENTARIO</caption>    <thead>
        <tr>
            <th>Código</th>
            <th>Nombre</th>
            <th>Stock</th>
            <th>Precio</th>
        </tr>
    </thead>
    <tbody>
        <% 
            for (clsProducto producto : inventario) {
        %>
        <tr>
            <td><%= producto.getCodProducto() %></td>
            <td><%= producto.getNombreProducto() %></td>
            <td><%= producto.getStock() %></td>
            <td><%= producto.getPrecio() %></td>
        </tr>
        <% 
            }
        %>
        

    </tbody>
    
    
</table>
    
                </div>
            </div>

            <div class="modal-dialog modal-lg" id="Mensaje" style="<%=flgMensaje%>">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle"><%=Titulo%></h5>
                    </div>
                    <div class="modal-body">
                        <h4 class="modal-title" id="modalTitle"> <%=Mensaje%></h4>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" onclick="miFunc();">ACEPTAR</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
        
    </body>
</html>
