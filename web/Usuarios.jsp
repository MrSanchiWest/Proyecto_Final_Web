<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="Backend.clsUsuario"%>
<!DOCTYPE html>
<%
    String Mensaje = "";

    if (request.getParameter("pCOD") != null && !request.getParameter("pCOD").isEmpty() &&
        request.getParameter("pNOMBRE") != null && !request.getParameter("pNOMBRE").isEmpty() &&
        request.getParameter("pAPELLIDO") != null && !request.getParameter("pAPELLIDO").isEmpty() &&
        request.getParameter("pPASS") != null && !request.getParameter("pPASS").isEmpty()) {
        
        try {
            clsUsuario objUsuario = new clsUsuario();
            objUsuario.setCOD(request.getParameter("pCOD"));
            objUsuario.setNOMBRE(request.getParameter("pNOMBRE"));
            objUsuario.setAPELLIDO(request.getParameter("pAPELLIDO"));
            // Encriptar la contraseña antes de asignarla
            String encryptedPass = objUsuario.encrypt(request.getParameter("pPASS"));
            objUsuario.setPASS(encryptedPass);
            objUsuario.setESTATUS("1"); // Establecer estatus activo por defecto
            
            int Resp = objUsuario.fncRegistroU(objUsuario);
            if (Resp == 1) {
                Mensaje = "Usuario registrado correctamente";
            } else {
                Mensaje = "Error al registrar el usuario";
            }
        } catch (Exception e) {
            Mensaje = "Error: " + e.getMessage();
        }
    } else if (request.getParameter("pCOD") != null) {
        // Solo mostrar este mensaje si hay una solicitud POST con parámetros faltantes.
        Mensaje = "Por favor complete todos los campos.";
    }

    // Desactivación de usuario
    if (request.getParameter("dCOD") != null && !request.getParameter("dCOD").isEmpty() &&
        request.getParameter("dESTATUS") != null && request.getParameter("dESTATUS").equals("0")) {
        
        try {
            clsUsuario objUsuario = new clsUsuario();
            int Resp = objUsuario.updateStatus(request.getParameter("dCOD"), request.getParameter("dESTATUS"));
            if (Resp == 1) {
                Mensaje = "Usuario desactivado correctamente";
            } else {
                Mensaje = "Error al desactivar el usuario";
            }
        } catch (Exception e) {
            Mensaje = "Error: " + e.getMessage();
        }
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-warning text-white">
                        <h4 class="card-title text-center">Registro de Usuarios</h4>
                    </div>
                    <div class="card-body">
                        <form id="clientRegistrationForm" method="post" action="RegistroUsuarios.jsp">
                            <div class="mb-3">
                                <label for="clientNIT" class="form-label">Código Usuario</label>
                                <input type="text" class="form-control" name="pCOD" placeholder="Ingrese su código de usuario" required>
                            </div>
                            <div class="mb-3">
                                <label for="clientName" class="form-label">Nombre</label>
                                <input type="text" class="form-control" name="pNOMBRE" placeholder="Ingrese su nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="clientAddress" class="form-label">Apellido</label>
                                <input type="text" class="form-control" name="pAPELLIDO" placeholder="Ingrese su apellido" required>
                            </div>
                            <div class="mb-3">
                                <label for="clientPhone" class="form-label">Contraseña</label>
                                <input type="text" class="form-control" name="pPASS" placeholder="Ingrese su contraseña" required>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-secondary">Registrar</button>
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
                    <a href="index.jsp" class="btn btn-warning">Registrar Cliente</a>
                </div>

                <!-- Formulario para desactivar usuario -->
                <div class="card mt-5">
                    <div class="card-header bg-danger text-white">
                        <h4 class="card-title text-center">Desactivar Usuario</h4>
                    </div>
                    <div class="card-body">
                        <form id="userDeactivationForm" method="post" action="RegistroUsuarios.jsp">
                            <div class="mb-3">
                                <label for="deactivateUserCOD" class="form-label">Código Usuario</label>
                                <input type="text" class="form-control" name="dCOD" placeholder="Ingrese el código de usuario a desactivar" required>
                            </div>
                            <div class="mb-3">
                                <label for="deactivateUserStatus" class="form-label">Estatus</label>
                                <input type="text" class="form-control" name="dESTATUS" value="0" readonly>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-danger">Desactivar Usuario</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>