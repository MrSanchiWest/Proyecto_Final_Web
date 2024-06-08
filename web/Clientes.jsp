<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="Backend.clsCliente"%>
<!DOCTYPE html>
<%
    String Mensaje = "";
    
    if (request.getParameter("pNIT") != null && !request.getParameter("pNIT").isEmpty() &&
        request.getParameter("pNOMBRE") != null && !request.getParameter("pNOMBRE").isEmpty() &&
        request.getParameter("pDIRECCION") != null && !request.getParameter("pDIRECCION").isEmpty() &&
        request.getParameter("pTELEFONO") != null && !request.getParameter("pTELEFONO").isEmpty() &&
        request.getParameter("pCORREO") != null && !request.getParameter("pCORREO").isEmpty()) {
        
        try {
            clsCliente objCliente = new clsCliente();
            objCliente.setNIT(request.getParameter("pNIT"));
            objCliente.setNOMBRE(request.getParameter("pNOMBRE"));
            objCliente.setDIRECCION(request.getParameter("pDIRECCION"));
            objCliente.setTELEFONO(Double.parseDouble(request.getParameter("pTELEFONO")));
            objCliente.setCORREO(request.getParameter("pCORREO"));
            
            int Resp = objCliente.fncRegistro(objCliente);
            if (Resp == 1) {
                Mensaje = "Cliente registrado correctamente";
            } else {
                Mensaje = "Error al registrar el cliente";
            }
        } catch (Exception e) {
            Mensaje = "Error: " + e.getMessage();
        }
    } else if (request.getParameter("pNIT") != null) {
        // Solo mostrar este mensaje si hay una solicitud POST con parámetros faltantes.
        Mensaje = "Por favor complete todos los campos.";
    }
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="card-title text-center">Registro de Clientes</h4>
                    </div>
                    <div class="card-body">
                        <form id="clientRegistrationForm" method="post" action="index.jsp">
                            <div class="mb-3">
                                <label for="clientNIT" class="form-label">NIT</label>
                                <input type="text" class="form-control" id="clientNIT" name="pNIT" placeholder="Ingrese su NIT" required>
                            </div>
                            <div class="mb-3">
                                <label for="clientName" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="clientName" name="pNOMBRE" placeholder="Ingrese su nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="clientAddress" class="form-label">Dirección</label>
                                <input type="text" class="form-control" id="clientAddress" name="pDIRECCION" placeholder="Ingrese su dirección" required>
                            </div>
                            <div class="mb-3">
                                <label for="clientPhone" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="clientPhone" name="pTELEFONO" placeholder="Ingrese su teléfono" required>
                            </div>
                            <div class="mb-3">
                                <label for="clientEmail" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="clientEmail" name="pCORREO" placeholder="Ingrese su correo electrónico" required>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-success">Registrar</button>
                            </div>
                        </form>
                    </div>
                </div>
                <% if (!Mensaje.isEmpty()) { %>
                    <div class="mt-3">
                        <div class="alert alert-info" role="alert">
                            <%= Mensaje %>
                        </div>
                    </div>
                <% } %>
                <div class="mt-3">
                    <a href="RegistroUsuarios.jsp" class="btn btn-secondary">Registrar Usuario</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>