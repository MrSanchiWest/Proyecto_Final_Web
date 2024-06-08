<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.clsUsuario"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body, html {
            height: 100%;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            max-width: 400px;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        }
        .login-title {
            text-align: center;
            margin-bottom: 20px;
        }
        .btn-primary {
            width: 100%;
        }
        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1 class="login-title">Login</h1>
        <form action="index.jsp" method="post">
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingresa tu nombre">
            </div>
            <div class="form-group">
                <label for="pass">Contraseña:</label>
                <input type="password" class="form-control" id="pass" name="pass" placeholder="Ingresa tu contraseña">
            </div>
            <button type="submit" class="btn btn-primary">INGRESAR</button>
        </form>
        <%
            String nombre = request.getParameter("nombre");
            String pass = request.getParameter("pass");

            if (nombre != null && pass != null) {
                clsUsuario usuario = new clsUsuario();
                try {
                    if (usuario.existeUsuario(nombre, pass)) {
                        response.sendRedirect("menu.jsp");
                    } else {
                        out.println("<p class='error-message'>USUARIO INVALIDO</p>");
                    }
                } catch (Exception e) {
                    out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
