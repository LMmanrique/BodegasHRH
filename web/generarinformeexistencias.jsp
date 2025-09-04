<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // ✅ Validación de sesión de usuario
    if (session == null || session.getAttribute("usuario") == null) {
        response.sendRedirect("authentication-login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informe de Existencias - Hospital Regional Huehuetenango</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .header-hospital {
            background: linear-gradient(135deg, #2c5aa0 0%, #1e3d72 100%);
            color: white;
            padding: 20px 0;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .pdf-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 30px;
            position: relative;
        }
        #pdfViewer {
            width: 100%;
            height: 800px;
            border: 2px solid #dee2e6;
            border-radius: 8px;
        }
        /* Overlay con spinner */
        #loadingOverlay {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(255,255,255,0.95);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            z-index: 10;
            border-radius: 8px;
        }
        .btn-download {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-download:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3);
            color: white;
        }
        .btn-back {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(108, 117, 125, 0.3);
            color: white;
        }
        .info-card {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
            color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Encabezado del hospital -->
    <div class="header-hospital">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="mb-1">Hospital Regional de Huehuetenango</h2>
                    <h5 class="mb-0">"Dr. Jorge Vides Molina"</h5>
                    <small>Ministerio de Salud Pública y Asistencia Social</small>
                </div>
                <div class="col-md-4 text-end">
                    <i class="fas fa-hospital fa-2x"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Información del Informe -->
        <div class="info-card d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-2"><i class="fas fa-file-pdf me-2"></i> Informe de Existencias del Inventario</h4>
                <p class="mb-0">Almacén de Suministros - Generado el 
                    <%= new java.text.SimpleDateFormat("dd/MM/yyyy 'a las' HH:mm").format(new java.util.Date()) %>
                </p>
            </div>
            <div>
                <button class="btn btn-download" onclick="descargarPDF()">
                    <i class="fas fa-download me-2"></i> Descargar PDF
                </button>
                <button class="btn btn-back" onclick="window.close()">
                    <i class="fas fa-times me-2"></i> Cerrar
                </button>
            </div>
        </div>

        <!-- Contenedor PDF con overlay -->
        <div class="pdf-container">
            <iframe id="pdfViewer" src="GenerarInformeExistenciasServlet"
                    title="Informe de Existencias PDF"></iframe>

            <!-- Overlay encima del iframe -->
            <div id="loadingOverlay">
                <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;"></div>
                <p class="mt-3 text-muted">Generando informe de existencias...</p>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/sweetAlert2/sweetalert2.all.min.js"></script>
    <script>
        // Ocultar overlay después de 5 segundos
        window.onload = function() {
            setTimeout(function() {
                document.getElementById('loadingOverlay').style.display = 'none';
            }, 3000); // 5 segundos
        };

        function descargarPDF() {
            const link = document.createElement('a');
            link.href = 'GenerarInformeExistenciasServlet';
            link.download = 'informe_existencias_' + new Date().toISOString().split('T')[0] + '.pdf';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    </script>
</body>
</html>