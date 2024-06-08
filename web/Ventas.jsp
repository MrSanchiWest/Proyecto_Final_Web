<%@ page import="java.util.List" %>
<%@ page import="FRONTEND.clsProducto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="FRONTEND.clsVenta" %>
<%@ page import="FRONTEND.clsDetalleVenta" %>
<%@ page import="DAO.clsQuery" %>
<%
String action = request.getParameter("action");

if ("cancelar".equals(action)) {
    session.setAttribute("productos", new ArrayList<clsProducto>());
}

String quitarCodigoProducto = request.getParameter("quitarCodigoProducto");
if (quitarCodigoProducto != null) {
    List<clsProducto> productos = (List<clsProducto>) session.getAttribute("productos");
    if (productos != null) {
        int codigoProducto = Integer.parseInt(quitarCodigoProducto);
        productos.removeIf(producto -> producto.getCod_Producto() == codigoProducto);
        session.setAttribute("productos", productos);
    }
}

if ("true".equals(request.getParameter("realizarVenta"))) {
    int numeroFactura = Integer.parseInt(request.getParameter("numeroFactura"));
    String nit = request.getParameter("nit");
    String fecha = request.getParameter("fecha");
    int medio = Integer.parseInt(request.getParameter("medio"));
    int codigoUsuario = Integer.parseInt(request.getParameter("codigoUsuario"));
    String estatus = request.getParameter("estatus");

    clsVenta venta = new clsVenta();
    venta.setFactura(numeroFactura);
    venta.setNIT(nit);
    venta.setFECHA(fecha);
    venta.setMEDIO(medio);
    venta.setCOD_USUARIO(codigoUsuario);
    venta.setESTATUS(estatus);

    List<clsDetalleVenta> detallesVenta = new ArrayList<>();
    String[] codigosProducto = request.getParameterValues("codigosProducto");
    String[] cantidadesProducto = request.getParameterValues("cantidadesProducto");
    String[] preciosProducto = request.getParameterValues("precioProducto");

    for (int i = 0; i < codigosProducto.length; i++) {
        clsDetalleVenta detalle = new clsDetalleVenta();
        detalle.setFACTURA(numeroFactura);
        detalle.setCOD_PRODUCTO(Integer.parseInt(codigosProducto[i]));
        detalle.setCANTIDAD(Integer.parseInt(cantidadesProducto[i]));
        detalle.setPRECIO(Double.parseDouble(preciosProducto[i]));
        detallesVenta.add(detalle);
    }

    clsQuery query = new clsQuery();
    try {
        int respuesta = venta.fncRegistro(venta, detallesVenta);
        if (respuesta == 1) {
            out.print("<script>alert('La venta se ha guardado correctamente en el sistema.');</script>");
            session.setAttribute("productos", new ArrayList<clsProducto>());
        } else {
            out.print("<script>alert('Hubo un error al guardar la venta. Por favor, inténtalo de nuevo.');</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("<script>alert('Error al guardar la venta. Por favor, revisa los datos e inténtalo de nuevo.');</script>");
    }
} else if ("guardarVenta".equals(action)) {
    String numeroFactura = request.getParameter("numeroFactura");
    String[] codigosProducto = request.getParameterValues("codigosProducto[]");
    String[] cantidadesProducto = request.getParameterValues("cantidadesProducto[]");
    String totalVenta = request.getParameter("totalVenta");

    List<clsDetalleVenta> detallesVenta = new ArrayList<>();
    for (int i = 0; i < codigosProducto.length; i++) {
        clsDetalleVenta detalle = new clsDetalleVenta();
        detalle.setFACTURA(Integer.parseInt(numeroFactura));
        detalle.setCOD_PRODUCTO(Integer.parseInt(codigosProducto[i]));
        detalle.setCANTIDAD(Integer.parseInt(cantidadesProducto[i]));
        detalle.setPRECIO(Double.parseDouble(totalVenta) / cantidadesProducto.length);
        detallesVenta.add(detalle);
    }

    clsQuery query = new clsQuery();
    try {
        boolean allSuccessful = true;
        for (clsDetalleVenta detalleVenta : detallesVenta) {
            int respuesta = query.fncIngresoDetalleVenta(detalleVenta);
            if (respuesta != 1) {
                allSuccessful = false;
                break;
            }
        }
        response.setContentType("application/json");
        if (allSuccessful) {
            response.getWriter().write("{\"status\":\"success\",\"message\":\"La venta se ha guardado correctamente en el sistema.\"}");
        } else {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Hubo un error al guardar la venta. Por favor, inténtalo de nuevo.\"}");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.setContentType("application/json");
        response.getWriter().write("{\"status\":\"error\",\"message\":\"Error al guardar la venta. Por favor, revisa los datos e inténtalo de nuevo.\"}");
    }
    return;
} else if ("facturar".equals(action)) {
    String numeroFactura = request.getParameter("numeroFactura");
    String fecha = request.getParameter("fecha");
    String cliente = request.getParameter("cliente");
    String totalVenta = request.getParameter("totalVenta");

    boolean facturacionExitosa = true;

    response.setContentType("application/json");
    if (facturacionExitosa) {
        response.getWriter().write("{\"status\":\"success\",\"message\":\"La facturación se ha realizado correctamente.\"}");
    } else {
        response.getWriter().write("{\"status\":\"error\",\"message\":\"Hubo un error al realizar la facturación. Por favor, inténtalo de nuevo.\"}");
    }
    return;
}

%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Ventas El Arenal</title>
    <style>
        #Titulo {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            padding: 20px;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="bg-warning p-2 text-dark bg-opacity-75" id="Titulo">
        <h1>VENDER</h1>
    </div>
    <br>
    <div class="container">
        <form id="productoForm" method="GET" action="index.jsp">
            <div class="row">
                <div class="col-md-6">
                    <label for="codigoProducto" class="form-label">Codigo del Producto:</label>
                    <input type="number" id="codigoProducto" name="codigoProducto" placeholder="CODIGO DE BARRAS" class="form-control" />
                </div>
                <div class="col-md-6 d-flex align-items-end">
                    <button type="submit" class="btn btn-info" id="buscarProducto">BUSCAR</button>
                </div>
            </div>
        </form>
    </div>
    <br><br><br>
    <div class="container">
        <form id="realizarVentaForm" method="POST" action="index.jsp">
            <input type="hidden" name="realizarVenta" value="true">
            <input type="hidden" name="totalVenta" id="inputTotalVenta" value="0"> 
            <table id="tablaProductos" class="table table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Stock</th>
                        <th>Precio</th>
                        <th>Descripcion</th>
                        <th>Informacion</th>
                        <th>Garantia</th>
                        <th>Estatus</th>
                        <th>Cantidad</th>
                        <th>Total</th>
                        <th>Quitar</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Recuperar la lista de productos de la sesión
                        List<clsProducto> productos = (List<clsProducto>) session.getAttribute("productos");
                        if (productos == null) {
                            productos = new ArrayList<>();
                        }

                        String codigoProductoParam = request.getParameter("codigoProducto");
                        if (codigoProductoParam != null && !codigoProductoParam.isEmpty()) {
                            try {
                                int codigoProducto = Integer.parseInt(codigoProductoParam);
                                clsQuery query = new clsQuery();
                                clsProducto producto = query.obtenerProductoPorCodigo(codigoProducto);

                                if (producto != null) {
                                    productos.add(producto);
                                    session.setAttribute("productos", productos);
                                } else {
                                    out.print("<script>alert('Producto no encontrado');</script>");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.print("<script>alert('Error al procesar la solicitud');</script>");
                            }
                        }

                        for (clsProducto producto : productos) {
                    %>
                    <tr>
                        <td><%= producto.getCod_Producto() %></td>
                        <td><%= producto.getNombre() %></td>
                        <td><%= producto.getStock() %></td>
                        <td><%= producto.getPrecio() %></td>
                        <td><%= producto.getDescripcion() %></td>
                        <td><%= producto.getInformacion() %></td>
                        <td><%= producto.getGarantia() %></td>
                        <td><%= producto.getEstatus() %></td>
                        <td>
                            <input type="hidden" name="codigosProducto" value="<%= producto.getCod_Producto() %>">
                            <input type="hidden" name="precioProducto" value="<%= producto.getPrecio() %>">
                            <input type="number" name="cantidadesProducto" class="form-control cantidadProducto" value="1" min="1" max="<%= producto.getStock() %>">
                        </td>
                        <td class="totalProducto"><%= producto.getPrecio() %></td>
                        <td>
                            <form method="POST" action="index.jsp" style="display:inline;">
                                <input type="hidden" name="quitarCodigoProducto" value="<%= producto.getCod_Producto() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Quitar</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <div class="mb-3">
                <label for="totalVenta" class="form-label">Total:</label>
                <input type="text" id="totalVenta" class="form-control" disabled>
            </div>
            <br>
            <div class="container">
                <h2>Registrar Venta</h2>
                <div class="mb-3">
                    <label for="numeroFactura" class="form-label">Numero de Factura:</label>
                    <input type="number" class="form-control" id="numeroFactura" name="numeroFactura" required>
                </div>
                <div class="mb-3">
                    <label for="nit" class="form-label">NIT:</label>
                    <input type="text" class="form-control" id="nit" name="nit" required>
                </div>
                <div class="mb-3">
                    <label for="fecha" class="form-label">Fecha:</label>
                    <input type="date" class="form-control" id="fecha" name="fecha" required>
                </div>
                <div class="mb-3">
                    <label for="medio" class="form-label">Medio:</label>
                    <input type="number" class="form-control" id="medio" name="medio" required>
                </div>
                <div class="mb-3">
                    <label for="codigoUsuario" class="form-label">Codigo Usuario:</label>
                    <input type="number" class="form-control" id="codigoUsuario" name="codigoUsuario" required>
                </div>
                <div class="mb-3">
                    <label for="estatus" class="form-label">Estatus:</label>
                    <input type="text" class="form-control" id="estatus" name="estatus" required>
                </div>
                <button type="submit" class="btn btn-info" id="facturarVenta">Facturar</button>
                <button type="button" id="guardarVenta" class="btn btn-success">Guardar Venta</button>
            </div>
        </form>
        <br>
        <form method="POST" action="index.jsp">
            <input type="hidden" name="action" value="cancelar">
            <button type="submit" class="btn btn-danger">Cancelar Venta</button>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
$(document).ready(function() {
    function actualizarTotal() {
        let total = 0;
        $('.totalProducto').each(function() {
            total += parseFloat($(this).text());
        });
        $('#totalVenta').val(total.toFixed(2));
        $('#inputTotalVenta').val(total.toFixed(2));
    }

    actualizarTotal();

    $('#buscarProducto').on('click', function() {
        $('#productoForm').submit();
    });

    $('#tablaProductos').on('change', '.cantidadProducto', function() {
        let cantidad = $(this).val();
        let precio = $(this).closest('tr').find('[name="precioProducto"]').val();
        let total = cantidad * precio;
        $(this).closest('tr').find('.totalProducto').text(total.toFixed(2));
        actualizarTotal();
    });

    $('#tablaProductos').on('click', '.quitarProducto', function() {
        $(this).closest('tr').remove();
        actualizarTotal();
    });

    $('#guardarVenta').on('click', function() {
        var numeroFactura = $('#numeroFactura').val();
        var codigosProducto = [];
        var cantidadesProducto = [];

        $('#tablaProductos tbody tr').each(function() {
            codigosProducto.push($(this).find('input[name="codigosProducto"]').val());
            cantidadesProducto.push($(this).find('input[name="cantidadesProducto"]').val());
        });

        var totalVenta = $('#totalVenta').val();

        $.ajax({
            type: 'POST',
            url: 'index.jsp',
            data: {
                action: 'guardarVenta',
                numeroFactura: numeroFactura,
                codigosProducto: codigosProducto,
                cantidadesProducto: cantidadesProducto,
                totalVenta: totalVenta
            },
            success: function(response) {
                let res = JSON.parse(response);
                alert(res.message);
                if (res.status === 'success') {
                    location.reload();
                }
            },
            error: function() {
                alert('Error al guardar la venta. Por favor, inténtalo de nuevo.');
            }
        });
    });

    $('#cancelarVenta').on('click', function() {
        $.ajax({
            type: 'POST',
            url: 'index.jsp',
            data: { action: 'cancelar' },
            success: function(response) {
                let res = JSON.parse(response);
                alert(res.message);
                if (res.status === 'success') {
                    location.reload();
                }
            }
        });
    });

    // Agregamos la funcionalidad para el botón Facturar
    $('#facturar').on('click', function() {
        var numeroFactura = $('#numeroFactura').val();
        var fecha = $('#fecha').val();
        var cliente = $('#cliente').val();
        var totalVenta = $('#totalVenta').val();

        $.ajax({
            type: 'POST',
            url: 'index.jsp',
            data: {
                action: 'facturar',
                numeroFactura: numeroFactura,
                fecha: fecha,
                cliente: cliente,
                totalVenta: totalVenta
            },
            success: function(response) {
                let res = JSON.parse(response);
                alert(res.message);
                if (res.status === 'success') {
                    // Aquí puedes agregar cualquier acción adicional después de una facturación exitosa
                }
            },
            error: function() {
                alert('Error al realizar la facturación. Por favor, inténtalo de nuevo.');
            }
        });
    });
});

    </script>
</body>
</html>
