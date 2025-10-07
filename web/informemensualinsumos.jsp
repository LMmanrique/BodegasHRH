<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Validar sesión
    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Informe Mensual de Insumos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            margin-top: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .spinner {
            display: none;
            text-align: center;
            margin-top: 20px;
        }
        .spinner div {
            width: 40px;
            height: 40px;
            background-color: #007bff;
            border-radius: 100%;
            display: inline-block;
            animation: sk-scaleout 1.0s infinite ease-in-out;
        }
        @keyframes sk-scaleout {
            0% { 
                transform: scale(0);
            } 100% {
                transform: scale(1.0);
                opacity: 0;
            }
        }
        .pdf-container {
            display: none;
            margin-top: 20px;
            text-align: center;
        }
        iframe {
            width: 100%;
            height: 600px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Informe Mensual de Insumos</h2>
        
        <form id="informeForm">
            <div class="form-group">
                <label for="existenciaId">ID de Existencia:</label>
                <input type="number" id="existenciaId" name="existenciaId" required>
            </div>
            
            <div class="form-group">
                <label for="mes">Mes:</label>
                <select id="mes" name="mes" required>
                    <option value="">Seleccione un mes</option>
                    <option value="1">Enero</option>
                    <option value="2">Febrero</option>
                    <option value="3">Marzo</option>
                    <option value="4">Abril</option>
                    <option value="5">Mayo</option>
                    <option value="6">Junio</option>
                    <option value="7">Julio</option>
                    <option value="8">Agosto</option>
                    <option value="9">Septiembre</option>
                    <option value="10">Octubre</option>
                    <option value="11">Noviembre</option>
                    <option value="12">Diciembre</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="anio">Año:</label>
                <input type="number" id="anio" name="anio" min="2020" max="2030" value="2025" required>
            </div>
            
            <button type="submit">Generar Informe</button>
        </form>
        
        <div class="spinner" id="spinner">
            <div></div>
            <p>Generando informe...</p>
        </div>
        
        <div class="pdf-container" id="pdfContainer">
            <h3>Informe Generado</h3>
            <iframe id="pdfFrame" src=""></iframe>
            <br><br>
            <button onclick="descargarPDF()">Descargar PDF</button>
        </div>
    </div>

    <script>
        let pdfUrl = '';
        
        document.getElementById('informeForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const existenciaId = document.getElementById('existenciaId').value;
            const mes = document.getElementById('mes').value;
            const anio = document.getElementById('anio').value;
            
            if (!existenciaId || !mes || !anio) {
                alert('Por favor complete todos los campos');
                return;
            }
            
            // Mostrar spinner
            document.getElementById('spinner').style.display = 'block';
            document.getElementById('pdfContainer').style.display = 'none';
            
            // Construir URL
            pdfUrl = 'GenerarInformeMensualInsumosServlet?existenciaId=' + existenciaId + 
                     '&mes=' + mes + '&anio=' + anio;
            
            // Simular delay para mostrar el spinner
            setTimeout(function() {
                // Cargar PDF en iframe
                document.getElementById('pdfFrame').src = pdfUrl;
                
                // Ocultar spinner y mostrar PDF después de un delay
                setTimeout(function() {
                    document.getElementById('spinner').style.display = 'none';
                    document.getElementById('pdfContainer').style.display = 'block';
                }, 1500);
            }, 500);
        });
        
        function descargarPDF() {
            if (pdfUrl) {
                window.open(pdfUrl, '_blank');
            }
        }
    </script>
</body>
</html>