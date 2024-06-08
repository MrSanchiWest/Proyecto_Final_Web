<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                flex-direction: column;
            }
            .container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                width: 80%;
            }
            .section {
                flex: 1;
                min-width: 200px;
                padding: 20px;
                margin: 20px;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .button {
                display: block;
                width: 100%;
                padding: 20px 0;
                border: none;
                border-radius: 5px;
                font-size: 24px;
                font-weight: bold;
                text-decoration: none;
                color: #fff;
                transition: background-color 0.3s;
            }
            .button-cliente {
                background-color: #1F618D; /* Azul elegante */
            }
            .button-cliente:hover {
                background-color: #154360; /* Azul oscuro */
            }
            .button-usuario {
                background-color: #A569BD; /* Púrpura elegante */
            }
            .button-usuario:hover {
                background-color: #6C3483; /* Púrpura oscuro */
            }
            .button-producto {
                background-color: #48C9B0; /* Verde menta */
            }
            .button-producto:hover {
                background-color: #1ABC9C; /* Verde menta oscuro */
            }
            .button-venta {
                background-color: #F39C12; /* Naranja elegante */
            }
            .button-venta:hover {
                background-color: #D68910; /* Naranja oscuro */
            }
            .back-button {
                margin-top: 20px;
                padding: 10px 20px;
                font-size: 16px;
                background-color: #95a5a6; /* Gris */
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                transition: background-color 0.3s;
            }
            .back-button:hover {
                background-color: #7f8c8d; /* Gris oscuro */
            }
        </style>
    </head>
    <body>
        <div class="container text-center">
            <h1 class="w-100 mb-5">¡BIENVENIDO!</h1>
            <div class="section">
                <a href="registrar_cliente.jsp" class="button button-cliente">REGISTRAR CLIENTE</a>
            </div>
            <div class="section">
                <a href="registrar_usuario.jsp" class="button button-usuario">REGISTRAR USUARIO</a>
            </div>
            <div class="section">
                <a href="registrar_producto.jsp" class="button button-producto">REGISTRAR PRODUCTO</a>
            </div>
            <div class="section">
                <a href="registrar_venta.jsp" class="button button-venta">REGISTRAR VENTA</a>
            </div>
        </div>
        <a href="index.jsp" class="btn btn-danger">CERRAR SESION</a>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
